import os
from posixpath import split
import sys
import argparse
from pprint import pprint
from collections import defaultdict

# converts an SQLite file to T-SQL as a graph format (tested using Microsoft Azure SQL DB)
class Converter:
    def __init__(self, path):
        self.path = path
        self.converted = ""
        self.tables = defaultdict(lambda: []) # tables and their fields
        self.table_pks = defaultdict(lambda: []) # tables and their primary keys
        self.table_fks = defaultdict(lambda: []) # tables and their foreign keys stored as table: (for_key, ref_table, ref_key)
        self.table_vals = defaultdict(lambda: []) # (table_name, col_name): [vals...]
        self.convert()

    def convert(self):
        self.convert_file()
        edge_tables, edge_queries = self.add_edges()
        self.insert_edges(edge_tables, edge_queries)
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
                table_name = split_line[2]
                table_name = table_name.replace('"', '')
                table_name = table_name.replace('`', '')
                i = self.convert_table(contents, i, table_name)

            # insert
            elif split_line[0].upper() == "INSERT":
                table = self.convert_insert(line)
                if prev_insert == None:
                    prev_insert = table
                elif prev_insert != table:
                    self.converted += "\n"
                    prev_insert = table


            i += 1

        return

    # add table name to self.tables and its fields too
    # convert datatypes e.g text to VARCHAR(100)
    # add primary and foreign keys too
    # add AS NODE to end of table
    # add to self.converted
    def convert_table(self, contents, i, table_name):
        self.converted += contents[i].replace("`", '')
        i += 1
        line = contents[i].strip()
        id = 1
        while line != ");":
            # TODO: check if any inserts in spider are larger than 100 characters
            # TODO: check if any spider fields have 'text' in them
            line = line.replace("text", "VARCHAR(100)")
            line = line.replace('`', '')
            line = line.replace('"', '')
            # TODO: check if any inserts in spider have 'real' in them
            line = line.replace("real", "FLOAT")
            self.converted += "\t" + line + "\n"
            split_line = line.lower().split()
            # print(f"table {table_name} content: {line}")

            # TODO: account for if there is a double or more primary key
            if split_line[0] == "primary":
                pks = line[line.index("(")+1:-2 if line[-1] == "," else -1]
                pks = pks.split(",")
                self.table_pks[table_name].extend([pk.strip() for pk in pks])

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

    # convert sqlite insert statement to valid T-SQL insert statement
    # self.table_vals = defaultdict(lambda: []) # (table_name, col_name): [vals...]
    def convert_insert(self, line):
        lower_line = line.lower()
        split_line = line.split()
        table_name = split_line[2].replace('"', '')
        columns = "(" + ", ".join([col for col in self.tables[table_name]]) + ")"
        vals_bracket = line.index("(", lower_line.index("values")) + 1
        vals = line[vals_bracket:-2]
        # vals = vals.replace("'", "")
        vals = vals.replace("`", "'")
        vals = vals.replace('"', "'")
        new_line = f"""INSERT INTO {table_name} {columns} VALUES ({vals});\n"""
        self.converted += new_line

        # storing of values for later usage
        # technically for foreign <-> primary key edges we only need to store foreign and primary key values, but for extensibility sake we will store all
        # TODO: check that no entries have commas in them 
        vals_list = vals.replace("'", "").split(",")
        for col, val in zip(self.tables[table_name], vals_list):
            self.table_vals[(table_name, col)].append(val)

        return table_name

    # given a table name and their single or composite primary key/s, return the list of queries for that table 
    def get_pk_query(self, table_name, pks):
        # f"((SELECT $node_id FROM {from_table} WHERE {from_col} = {from_val}), (SELECT $node_id FROM {to_table} WHERE {to_col} = {to_val}))"
        pass

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
                from_queries = self.get_pk_query(from_table, self.table_pks[from_table])
                to_queries = self.get_pk_query(to_table, self.table_pks[to_table])
                for from_query in from_queries:
                    for to_query in to_queries:
                        query = f"({from_query}, {to_query})"
                        edge_tables[edge_table_name].append(query)
                seen.add((from_table, to_table))

        return edge_tables

        # for from_table in tables:
        #     for from_col, to_table, to_col in self.table_fks[from_table]:

        #         edge_table_a = f"{from_table}_to_{to_table}"
        #         edge_table_b = f"{to_table}_to_{from_table}"

        #         if edge_table_a in edge_tables.keys():
        #             edge_table_name = edge_table_a
        #         elif edge_table_b in edge_tables.keys():
        #             edge_table_name = edge_table_b
        #         else:
        #             edge_table_name = edge_table_a
        #             edge_tables[edge_table_name] = count
        #             edge_queries.append([])
        #             count += 1

        #         idx = edge_tables[edge_table_name]
        #         self.converted += f"CREATE TABLE {edge_table_name} AS EDGE;\n"

        #         for from_val in self.table_vals[(from_table, from_col)]:
        #             for to_val in self.table_vals[(to_table, to_col)]:
        #                 query = f"((SELECT $node_id FROM {from_table} WHERE {from_col} = {from_val}), (SELECT $node_id FROM {to_table} WHERE {to_col} = {to_val}))"
        #                 edge_queries[idx].append(query)  
        
        # self.converted += "\n"
        # return edge_tables, edge_queries

    # inserts edge queries into the edge tables
    def insert_edges(self, edge_tables, edge_queries):
        for edge_table_name in edge_tables:
            idx = edge_tables[edge_table_name]
            if len(edge_queries[idx]) == 0:
                continue
            self.converted += f"INSERT INTO {edge_table_name} VALUES\n"
            first = True
            for query in edge_queries[idx]:
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
                        print(f"Attempting to convert '{path}'")
                        Converter(path)
                # print(os.path.join(root, name))
            # for name in dirs:
            #     print(os.path.join(root, name))

if __name__ == "__main__":
    main()