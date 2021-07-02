# sqlite_to_graph_t_sql

## Description

A program that takes in a file or directory that points to sqlite schema files and converts these files into T-SQL schema graphs as per https://docs.microsoft.com/en-us/sql/relational-databases/graphs/sql-graph-overview?view=sql-server-ver15

Creates an edge between primary and foreign keys between tables

## Usage

Usage for a single file:

python converter.py 0 file-path

e.g python converter.py 0 schemas/battle_schema.sql

Usage for a directory (not implemented yet):

python converter.py 1 "directory-name"

e.g (not implemented yet)

## Issues

Tested on OSX environment only so far and paths have been hardcoded in rather than using os library - problems with paths will probably be encountered in a Windows environment. 

.sql schemas have only been tested using the Spider dataset (https://yale-lily.github.io/spider), so since it is untested on all other datasets it will likely run into issues there as well. 

Still in development stage so issues with Spider dataset are undergoing fixes too. 