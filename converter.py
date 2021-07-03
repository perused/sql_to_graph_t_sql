import os
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
        self.add_edges()
        self.write_output()
    
    # converts schema into t-sql format (including replacing data types in tables and changing format of insert statements), adds tables + primary keys + foreign keys to instance dictionaries and adds AS NODE to end of tables
    def convert_file(self):
        fp = open(self.path, "r")
        contents = fp.readlines()
        fp.close()
        i = 0
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
                i = self.convert_table(contents, i, table_name)

            # insert
            elif split_line[0].upper() == "INSERT":
                self.convert_insert(line)

            i += 1

        return

    # add table name to self.tables and its fields too
    # convert datatypes e.g text to VARCHAR(100)
    # add primary and foreign keys too
    # add AS NODE to end of table
    # add to self.converted
    def convert_table(self, contents, i, table_name):
        self.converted += contents[i]
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
            split_line = line.split()
            # print(f"table {table_name} content: {line}")

            # TODO: account for if there is a double or more primary key
            if split_line[0].lower() == "primary":
                pks = line[self.get_occurrence(line, "(", 1)+1:-2 if line[-1] == "," else -1]
                pks = pks.split(",")
                self.table_pks[table_name].extend([pk.strip() for pk in pks])

            elif split_line[0].lower() == "foreign":
                # extract mention of foreign key, referenced table and referenced key from this line
                for_key = split_line[2][1:-1]
                ref_table = split_line[4][:self.get_occurrence(split_line[4], "(", 1)]
                if line[-1] == ",":
                    ref_key = split_line[4][self.get_occurrence(split_line[4], '(', 1)+1:-2]
                else:
                    ref_key = split_line[4][self.get_occurrence(split_line[4], '(', 1)+1:-1]
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

    # given the desired index of occurrence of a character, return the index of that character at that occurrence. Assumes occ > 0. None if not found
    def get_occurrence(self, string, char, occ):
        i = 0
        count = 0
        while i < len(string):
            if string[i] == char:
                count += 1
                if count == occ:
                    return i
            i += 1
        return None

    # convert sqlite insert statement to valid T-SQL insert statement
    # self.table_vals = defaultdict(lambda: []) # (table_name, col_name): [vals...]
    def convert_insert(self, line):
        split_line = line.split()
        table_name = split_line[2].replace('"', '')
        columns = "(" + ", ".join([col for col in self.tables[table_name]]) + ")"
        first_bracket = self.get_occurrence(line, "(", 1) + 1
        vals = line[first_bracket:-2]
        vals = vals.replace("'", "")
        vals = vals.replace('"', "'")
        new_line = f"""INSERT INTO {table_name} {columns} VALUES ({vals});\n\n"""
        self.converted += new_line

        # storing of values for later usage
        # technically for foreign <-> primary key edges we only need to store foreign and primary key values, but for extensibility sake we will store all
        # TODO: check that no entries have commas in them 
        vals_list = vals.replace("'", "").split(",")
        for col, val in zip(self.tables[table_name], vals_list):
            self.table_vals[(table_name, col)].append(val)

    # add edge tables for all possible relations between two tables - edges are not directed so A -> B == B -> A
    # return the set of edge table names
    # def add_edge_tables(self):
    #     tables = self.tables.keys()
    #     edges = set()
    #     self.converted += "\n"
    #     for a in tables:
    #         for b in tables:
    #             if a == b:
    #                 continue
    #             if f"{a}_to_{b}" not in edges and f"{b}_to_{a}" not in edges:
    #                 # add the edge and its table
    #                 edge_name = f"{a}_to_{b}"
    #                 edges.add(edge_name)
    #                 self.converted += f"CREATE TABLE {edge_name} AS EDGE;\n"
    #     self.converted += "\n"
    #     return edges

    # add primary/foreign key edges to tables, create them if they don't already exist
    # TODO: NEW IDEA
    # loop through the foreign key tables and create edges for these
    # edge tables are created on the fly
    def add_edges(self):
        tables = self.tables.keys()
        edge_tables = {} # table_to_table: idx
        edge_queries = [] # idx corresponds to edge_tables idx
        edges_added = {} # (from_table, from_col): (to_table, to_col)
        count = 0
        self.create_edges = ""
        for from_table in tables:
            for from_col, to_table, to_col in self.table_fks[from_table]:

                # If we created edges from this tables from col to the other tables to col before, skip
                if (from_table, to_table) in edges_added 

                edge_table_a = f"{from_table}_to_{to_table}"
                edge_table_b = f"{to_table}_to_{from_table}"

                if edge_table_a in edge_tables.keys():
                    idx = edge_tables[edge_table_a]
                elif edge_table_b in edge_tables.keys():
                    idx = edge_tables[edge_table_b]
                else:
                    edge_tables[edge_table_a] = count
                    edge_queries.append([])
                    idx = count
                    count += 1

                for from_val in self.table_vals[(from_table, from_col)]:
                    for to_val in self.table_vals[(to_table, to_col)]:
                        query = f"((SELECT $node_id FROM {from_table} WHERE {from_col} = {from_val}), (SELECT $node_id FROM {to_table} WHERE {to_col} = {to_val}))"
                        edge_queries[idx].append(query)  

    # add primary/foreign key edges to these tables
    # TODO: 
    # Currently utilises self.table_fks = defaultdict(lambda: []) # tables and their foreign keys stored as table: (for_key, ref_table, ref_key)
    # When we insert the edge we currently call: (SELECT $node_id FROM farm_competition WHERE ID = 4)
    # In the given graph example, edges are inserted between specific values in tables. However, we are only able to identify relations between foreign keys (columns) and the keys they reference (also columns)
    # This means that to place an edge between foreign and referenced keys, then we need to create an edge between every entry in the foreign key column and every entry in the referenced key column, which is n x m edges where n is the number of entries in the foreign key column and m is the number of edges in the referenced column. 
    # def insert_edges(self, edge_table_names):
    #     for edge_name in edge_table_names:
    #         insertion = f"INSERT INTO {edge_name} VALUES\n"
    #         edge_name = edge_name.split("_to_")
    #         left_table = edge_name[0]
    #         right_table = edge_name[1]
    #         edges = set() # (node_a, node_b)
    #         count = 0

    #         # table_vals: (table, col): val
    #         # table_fks: table: (for_key, ref_table, ref_key)


    #         print(f"\ntable_vals = {self.table_vals}\n")

    #         for foreign_key_triple in self.table_fks[a]:
    #             for_key, ref_table, ref_key = foreign_key_triple
    #             for left_val in self.table_vals[(a, for_key)]:
    #                 for right_val in self.table_vals

                # to make the below loops work, we need some storage like:
                # for left in for_key_vals_in_table_a:
                #     for right in ref_key_vals_in_table_ref:
                        # if edge doesnt already exist
                        # insert edge from left to right 
                        # write to insertion

    #         # check for primary/foreign keys from a to b, add these edges to 'edges' and 'insertion'
    #         for entry in self.table_fks[a]:
    #             edge_from = entry[0]
    #             edge_to = entry[2]
    #             if (edge_from, edge_to) not in edges and (edge_to, edge_from) not in edges:

    #                 edges.add((edge_from, edge_to))
    #                 edge_from_table = a
    #                 edge_from_id = self.nodes[(edge_from_table, edge_from)]
    #                 edge_to_table = entry[1]
    #                 edge_to_id = self.nodes[(edge_to_table, edge_to)]

    #                 if count > 0:
    #                     insertion += f"\t,((SELECT $node_id FROM {edge_from_table} WHERE ID = {edge_from_id}), (SELECT $node_id FROM {edge_to_table} WHERE ID = {edge_to_id}))\n"
    #                 else:
    #                     insertion += f"\t ((SELECT $node_id FROM {edge_from_table} WHERE ID = {edge_from_id}), (SELECT $node_id FROM {edge_to_table} WHERE ID = {edge_to_id}))\n"

    #                 count += 1

    #         # check for primary/foreign keys from b to a, add these edges if they are new to 'edges' 
    #         for entry in self.table_fks[b]:
    #             # TODO: below, but first the above needs to store which edges have been recorded!
    #             edge_from = entry[0]
    #             edge_to = entry[2]
    #             if (edge_from, edge_to) not in edges and (edge_to, edge_from) not in edges:

    #                 edge_from_table = b
    #                 edge_from_id = self.nodes[(edge_from_table, edge_from)]
    #                 edge_to_table = entry[1]
    #                 edge_to_id = self.nodes[(edge_to_table, edge_to)]
    #                 if count > 0:
    #                     insertion += f"\t,((SELECT $node_id FROM {edge_from_table} WHERE ID = {edge_from_id}), (SELECT $node_id FROM {edge_to_table} WHERE ID = {edge_to_id}))\n"
    #                 else:
    #                     insertion += f"\t ((SELECT $node_id FROM {edge_from_table} WHERE ID = {edge_from_id}), (SELECT $node_id FROM {edge_to_table} WHERE ID = {edge_to_id}))\n"

    #                 count += 1
            
    #         insertion += ";\n\n"
    #         if count > 0:
    #             self.converted += insertion

    # write the final output to path_converted.txt
    def write_output(self):
        new_path = self.path.replace(".sql", "")
        new_path += "_converted.sql"
        with open(new_path, "w") as fp:
            fp.write(self.converted)
        print(f"Converted output written to '{new_path}'.")

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
        c = Converter(args.path)
    else:
        for root, dirs, files in os.walk(args.path):
            for name in files:
                print(os.path.join(root, name))
            for name in dirs:
                print(os.path.join(root, name))

if __name__ == "__main__":
    main()