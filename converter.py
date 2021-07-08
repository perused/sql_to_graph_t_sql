import os
from posixpath import split
import sys
import argparse
from pprint import pprint
from collections import defaultdict
import re

# converts an SQLite file to T-SQL as a graph format (tested using Microsoft Azure SQL DB)
class Converter:
    def __init__(self, path):
        self.path = path
        self.converted = ""
        self.tables = defaultdict(lambda: []) 
        self.table_pks = defaultdict(lambda: []) 
        # tables and their foreign keys stored as table: (for_key, ref_table, ref_key)
        self.table_fks = defaultdict(lambda: []) 
        # Values of tables stored as: (table_name, col_name): [vals...]
        self.table_vals = defaultdict(lambda: []) 
        self.convert()

    # calls all relevant functions to convert the input file
    def convert(self):
        self.convert_file()
        edge_tables = self.add_edges()
        self.insert_edges(edge_tables)
        self.write_output()
    
    # converts schema into t-sql format (including replacing data types in tables and changing format of insert statements), adds tables + primary keys + foreign keys to instance dictionaries and adds AS NODE to end of tables
    def convert_file(self):
        fp = open(self.path, "r")
        contents = fp.readlines()
        fp.close()
        i = 0
        prev_insert = None
        while i < len(contents):
            line = contents[i].strip()
            split_line = line.split()
            if len(split_line) == 0:
                i += 1
                continue

            # table
            if split_line[0].upper() == "CREATE":
                # TODO: check if there are any two word table names in the DB
                table_name = split_line[2].lower()
                table_name = table_name.replace('"', '')
                table_name = table_name.replace('`', '')
                i = self.convert_table(contents, i, table_name)
                prev_insert = None

            # insert
            elif split_line[0].upper() == "INSERT":
                table = self.convert_insert(line)
                if prev_insert == None:
                    prev_insert = table
                elif prev_insert != table:
                    self.converted += "\n"
                    prev_insert = table

            i += 1
        self.converted += "\n"

        return

    # add table name to self.tables and its fields too
    # convert datatypes e.g text to VARCHAR(100)
    # add primary and foreign keys too
    # add AS NODE to end of table
    # add to self.converted
    def convert_table(self, contents, i, table_name):
        self.converted += "\n" + contents[i].replace("`", '')
        i += 1
        line = contents[i].strip()
        id = 1
        while line != ");":
            line = self.field_replacements(line)
            self.converted += "\t" + line + "\n"
            split_line = line.lower().split()
            lower_line = line.lower()
            # print(f"table {table_name} content: {line}")

            # accounts for if there is a double or more primary key
            if split_line[0] == "primary":
                pks = line[line.index("(")+1:-2 if line[-1] == "," else -1]
                pks = pks.split(",")
                self.table_pks[table_name].extend([pk.strip().lower() for pk in pks])

            # accounts for if primary key is specified at the end of the field
            elif "primary key" in lower_line:
                pk = split_line[0].strip().lower()
                self.table_pks[table_name].extend([pk])
                self.tables[table_name].append(pk)

            elif split_line[0] == "foreign":
                # extract mention of foreign key, referenced table and referenced key from this line
                for_key = split_line[2][1:-1]
                bracket_idx = None
                word_idx = split_line.index("references")
                while not bracket_idx and word_idx < len(split_line):
                    try:
                        bracket_idx = split_line[word_idx].index("(")
                    except:
                        word_idx += 1
                ref_table = split_line[word_idx][:bracket_idx]
                if line[-1] == ",":
                    ref_key = split_line[word_idx][bracket_idx+1:-2]
                else:
                    ref_key = split_line[word_idx][bracket_idx+1:-1]
                self.table_fks[table_name].append((for_key, ref_table, ref_key))

            else:
                node = split_line[0].replace('"', '')
                self.tables[table_name].append(node)
                # self.nodes[(table_name, node)] = id
                id += 1

            i += 1
            line = contents[i].strip()

        self.converted += ") AS NODE;" + "\n\n"

        return i

    # takes in a field of a table and returns the converted field
    def field_replacements(self, line):
        line = line.lower()
        # TODO: check if any inserts in spider are larger than 100 characters
        # TODO: check if any spider fields have 'text' in them
        line = line.replace("text", "VARCHAR(100)")
        line = line.replace('`', '')
        line = line.replace('"', '')
        # TODO: check if any inserts in spider have 'real' in them
        line = line.replace("real", "FLOAT")
        # TODO: Currently just removing constraints but can insert them with alter table statements
        line = line.replace("not null", "")
        line = line.replace("null", "")
        line = line.replace("double", "FLOAT")
        # the below is for a mistake with driving_schema.sql where the allocated varchar is not big enough
        line = line.replace("varchar(10)", "varchar(20)")
        return line

    # convert sqlite insert statement to valid T-SQL insert statement
    def convert_insert(self, line):
        lower_line = line.lower()
        split_line = line.split()
        table_name = split_line[2].replace('"', '').replace('`', '').replace("'", "").lower()
        columns = "(" + ", ".join([col for col in self.tables[table_name]]) + ")"
        vals_bracket = line.index("(", lower_line.index("values")) + 1
        vals = line[vals_bracket:-2]
        
        split_vals = self.clean_vals(len(self.tables[table_name]), vals)
        
        vals_text = ""
        for i in range(len(split_vals)):
            val = split_vals[i]
            if type(val) == int:
                vals_text += str(val)
            else:
                vals_text += f"'{val}'"
            if i != len(split_vals) - 1:
                vals_text += ", "

        new_line = f"INSERT INTO {table_name} {columns} VALUES ({vals_text});\n"

        self.converted += new_line
        
        # storing of values for later usage
        for col, val in zip(self.tables[table_name], split_vals):
            self.table_vals[(table_name, col)].append(val)

        return table_name

    # scans through the values string and extracts individual values
    # takes into account apostrophes e.g 'Valentine's' and 'L'oreal' 
    # takes into account extra commas e.g 'Smith, John' 
    # returns a list of each individual value
    def clean_vals(self, num_columns, vals):

        numerical = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ".", "-"]
        inside_text_val = False
        inside_num_val = False
        text_val = ""
        num_val = ""
        split_vals = []
        i = 0

        while i < len(vals):

            cur = vals[i]

            # if we have seen a text open apostrophe already
            if inside_text_val:
                # if we are seeing another apostrophe
                if cur == "'" or cur == '"' or cur == "`":
                    # it is either a possessive/other e.g 'Valentine's' or 'L'oreal' in which case skip
                    if i != len(vals) - 1 and vals[i+1] != ",":
                        pass

                    # or we are marking the end of the text value
                    else:
                        split_vals.append(text_val)
                        text_val = ""
                        inside_text_val = False
                
                # otherwise we just append it to the text val and continue
                else:
                    text_val += cur

            # if we have seen a numerical value already
            elif inside_num_val:
                # if we are seeing a comma it is finished
                if cur == ",":
                    split_vals.append(int(num_val))
                    num_val = ""
                    inside_num_val = False
                
                # otherwise we add it to ongoing numerical val
                elif cur in numerical:
                    num_val += cur

                else:
                    raise Exception(f"When parsing values, expected to be inside a numerical value, which so far is '{num_val}', but encountered the character '{cur}' which is not considered a numerical value. The full values line is: {vals}")

            # otherwise we are a) encountering a new text value b) encountering a new numerical value c) in between values
            else:
                # a)
                if cur == "'" or cur == '"' or cur == "`": 
                    inside_text_val = True
                # b)
                elif cur in numerical:
                    num_val += cur
                    inside_num_val = True
                # c)
                else:
                    pass

            i += 1

        # if we finished the loop at a numerical value, it wont have been appended yet
        if inside_num_val:
            split_vals.append(int(num_val))

        if num_columns != len(split_vals):
            raise Exception(f"Length of split vals is {len(split_vals)} and number of columns is {num_columns}, meaning that there is an unexpected comma value in the values, which are: {vals}.")

        return split_vals

    # given a table name and their single or composite primary key/s, return the list of queries for that table 
    def get_pk_queries(self, table_name, pks):
        if len(pks) == 0:
            raise Exception(f"Recorded zero primary keys for {table_name}")
        elif len(pks) == 1:
            return self.get_single_pk_queries(table_name, pks[0])
        elif len(pks) == 2:
            return self.get_double_pk_queries(table_name, pks)
        elif len(pks) == 3:
            raise Exception(f"Three primary keys not implemented yet. Table name = {table_name} and supposed pks = {pks}")
        elif len(pks) >= 4:
            raise Exception(f"Four or more primary keys not implemented yet. Table name = {table_name} and supposed pks = {pks}")

    def get_single_pk_queries(self, table_name, pk_col):
        queries = []
        for val in self.table_vals[(table_name, pk_col)]:
            if type(val) != int:
                val = f"'{val}'"
            queries.append(f"(SELECT $node_id FROM {table_name} WHERE {pk_col} = {val})")
        return queries

    def get_double_pk_queries(self, table_name, pks):
        queries = []
        for val_a, val_b in zip(self.table_vals[(table_name, pks[0])], self.table_vals[(table_name, pks[1])]):
            if type(val_a) != int:
                val_a = f"'{val_a}'"
            if type(val_b) != int:
                val_b = f"'{val_b}'"
            queries.append(f"(SELECT $node_id FROM {table_name} WHERE {pks[0]} = {val_a} AND {pks[1]} = {val_b})")
        return queries

    # create an edge between all primary keys in all tables
    # returns the tables names: queries dictionary for writing into the final document
    def add_edges(self):
        tables = self.tables.keys()
        edge_tables = defaultdict(lambda: []) # table_to_table: [queries...]
        seen = set()

        for from_table in tables:
            for to_table in tables:
                if from_table == to_table:
                    continue
                # no need to do the reverse edges since they are not directed
                if (from_table, to_table) in seen or (to_table, from_table) in seen:
                    continue
                edge_table_name = f"{from_table}_to_{to_table}"
                self.converted += f"CREATE TABLE {edge_table_name} AS EDGE;\n"
                from_queries = self.get_pk_queries(from_table, self.table_pks[from_table])
                to_queries = self.get_pk_queries(to_table, self.table_pks[to_table])
                for from_query in from_queries:
                    for to_query in to_queries:
                        query = f"({from_query}, {to_query})"
                        edge_tables[edge_table_name].append(query)
                seen.add((from_table, to_table))
        self.converted += "\n"

        return edge_tables

    # inserts edge queries into the edge tables
    # table_to_table: [queries...]
    def insert_edges(self, edge_tables):
        for edge_table_name in edge_tables.keys():
            self.converted += f"INSERT INTO {edge_table_name} VALUES\n"
            first = True
            for query in edge_tables[edge_table_name]:
                if first:
                    self.converted += "\t " + query + "\n"
                    first = False
                else:
                    self.converted += "\t," + query + "\n"
            self.converted += ";\n\n"

    # write the final output to path_converted.txt
    def write_output(self):
        new_path = self.path.replace(".sql", "")
        new_path += "_converted.sql"
        with open(new_path, "w") as fp:
            fp.write(self.converted)
        print(f"Successfully converted '{self.path}' to '{new_path}'")

# process command line arguments
# returns: args - namespace of command line arguments
def process_args():
    
    parser = argparse.ArgumentParser()
    parser.add_argument("file_flag", type=int, choices=[0, 1], help="0 for converting a single file, 1 for a whole directory")
    parser.add_argument("path", type=str, help="If single file, the path to that file. If directory, the path to that directory.")
    args = parser.parse_args()

    if args.file_flag == 0:
        if not os.path.isfile(args.path):
            raise Exception("Given file path is not valid.")
    else:
        if not os.path.isdir(args.path):
            raise Exception("Given directory path is not valid.")

    return args

def main():
    args = process_args()
    if args.file_flag == 0:
        Converter(args.path)
    else:
        for root, dirs, files in os.walk(args.path):
            for name in files:
                path = os.path.join(root, name)
                with open(path, "r") as fp:
                    try:
                        line_one = fp.readline().strip().split()
                        test = line_one[0].lower() == "pragma"
                    except:
                        continue
                    if test:
                        Converter(path)
                # print(os.path.join(root, name))
            # for name in dirs:
            #     print(os.path.join(root, name))

if __name__ == "__main__":
    main()