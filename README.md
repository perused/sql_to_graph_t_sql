# sqlite_to_graph_t_sql
A program that takes in a file or directory that points to sqlite schema files and converts these files into T-SQL schema graphs as per https://docs.microsoft.com/en-us/sql/relational-databases/graphs/sql-graph-overview?view=sql-server-ver15

Creates an edge between primary and foreign keys between tables

Usage for a single file:

python converter.py 0 <file-name>

Usage for a directory (not implemented yet):

python converter.py 1 <directory-name>

