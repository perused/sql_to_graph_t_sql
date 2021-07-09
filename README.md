# sqlite_to_graph_t_sql

## Description

A Python progam that, when given a path to a file or directory, converts all sqlite files in the path to T-SQL schema graphs as per https://docs.microsoft.com/en-us/sql/relational-databases/graphs/sql-graph-overview?view=sql-server-ver15

Creates an edge between primary keys between tables.

## Usage

Usage for a single file:

python converter.py 0 file-path

e.g python converter.py 0 schemas/battle_schema.sql

Usage for a directory:

python converter.py 1 "directory-name"

e.g python converter.py 1 schemas

## Important Notes and Potential Issues

- Python script tested on OSX environment only so far and paths have been hardcoded in rather than using os library - problems with paths will probably be encountered in a Windows environment. 
- SQL only tested in Microsoft Azure SQL DB environment only.
- .sql schemas have only been obtained from the Spider dataset (https://yale-lily.github.io/spider), other datasets may not be compatible and will require tweaks. 
- Still in development stage so issues with Spider dataset are undergoing fixes too. 
- For constraints such as NOT NULL and NULL, these have been removed for now as the Microsoft SQL Server equivalent is: "ALTER TABLE ALTER COLUMN NOT NULL" and this has not been deemed necessary in the converted sql yet
- Tables without primary keys, such as Has_pet in schemas/pets_1/schema.sql, are excluded from edge creations since they represent the same thing the edges are attempting to represent
- Some schemas have the INSERTs to tables in nested directories containing .csv files e.g schemas/flight_2/. This behaviour has not been accounted for yet.