import os
import sys
import argparse
from pprint import pprint
from collections import defaultdict

# converts an SQLite file to T-SQL
class Converter:
    def __init__(self, path) -> None:
        self.path = path
        self.converted = ""
        self.tables = defaultdict(lambda: []) # tables and their fields
        self.table_pks = {} # tables and their primary key
        self.table_fks = defaultdict(lambda: []) # tables and their foreign keys stored as table: (referenced table, referenced key)
        # edges
        # key = (table_a, table_b)
        # values = list of (table_a_node, table_b_node)
        self.edges = defaultdict(lambda: []) 
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
            if split_line[0] == "CREATE":
                # TODO: check if there are any two word table names in the DB
                table_name = split_line[2]
                table_name = table_name.replace('"', '')
                i = self.convert_table(contents, i, table_name)

            # insert
            elif split_line[0] == "INSERT":
                self.convert_insert(line)

            # other
            else:
                self.converted += line + "\n\n"
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
        while line != ");":
            # TODO: check if any inserts in spider are larger than 100 characters
            line = line.replace("text", "VARCHAR(100)")
            line = line.replace('`', '"')
            self.converted += "\t" + line + "\n"
            split_line = line.split()
            # print(f"table {table_name} content: {line}")

            if split_line[0] == "primary":
                if line[-1] == ",":
                    self.table_pks[table_name] = split_line[1][5:-3]
                else:
                    self.table_pks[table_name] = split_line[1][5:-2]

            elif split_line[0] == "foreign":
                # string manipulation to extract mentions of foreign key, referenced table and referenced key from this line
                for_key = split_line[2][2:-2]
                ref_table = split_line[4][1:self.get_occurrence(split_line[4], '"', 2)]
                if line[-1] == ",":
                    ref_key = split_line[4][self.get_occurrence(split_line[4], '"', 3)+1:-3]
                else:
                    ref_key = split_line[4][self.get_occurrence(split_line[4], '"', 3)+1:-2]
                self.table_fks[table_name] = (for_key, ref_table, ref_key)

            else:
                self.tables[table_name].append(split_line[0])

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
    # Insertions into table need to be changed from INSERT INTO <table> VALUES (val_col_0, val_col_1, …, val_col_n), which looks like this: INSERT INTO  "battle" VALUES (1,"Battle of Adrianople","14 April 1205","Kaloyan","Baldwin I","Bulgarian victory"); into INSERT INTO <table> VALUES (1, <val_0>), (2, <val_1>), …, (n, <val_n>)
    def convert_insert(self, line):
        first_bracket = self.get_occurrence(line, "(", 1) + 1
        new_line = line[0:first_bracket]
        vals = line[first_bracket:-2]
        new_vals = "\n"
        vals = vals.split(",")
        for i, val in enumerate(vals, 1):
            if i == len(vals):
                new_vals += f"\t({i}, {val})\n"
            else:
                new_vals += f"\t({i}, {val}),\n"
        new_line += new_vals + ");\n\n"
        self.converted += new_line

# -- Create EDGE tables.
# CREATE TABLE likes (rating INTEGER) AS EDGE;
# CREATE TABLE friendOf AS EDGE;
# CREATE TABLE livesIn AS EDGE;
# CREATE TABLE locatedIn AS EDGE;

# -- Insert into edge table. While inserting into an edge table,
# -- you need to provide the $node_id from $from_id and $to_id columns.
# /* Insert which restaurants each person likes */
# INSERT INTO likes
# 	VALUES ((SELECT $node_id FROM Person WHERE ID = 1), (SELECT $node_id FROM Restaurant WHERE ID = 1), 9)
# 		 , ((SELECT $node_id FROM Person WHERE ID = 2), (SELECT $node_id FROM Restaurant WHERE ID = 2), 9)
# 		 , ((SELECT $node_id FROM Person WHERE ID = 3), (SELECT $node_id FROM Restaurant WHERE ID = 3), 9)
# 		 , ((SELECT $node_id FROM Person WHERE ID = 4), (SELECT $node_id FROM Restaurant WHERE ID = 3), 9)
# 		 , ((SELECT $node_id FROM Person WHERE ID = 5), (SELECT $node_id FROM Restaurant WHERE ID = 3), 9);

    # add edge tables for all possible relations between two tables - edges are not directed so A -> B == B -> A
    # add primary/foreign key edges to these tables
    def add_edges(self):
        tables = self.tables.keys()
        edges = set()
        for a in tables:
            for b in tables:
                if a == b:
                    continue
                if (a, b) not in edges and (b, a) not in edges:
                    edges.add((a, b))
        print(edges)

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