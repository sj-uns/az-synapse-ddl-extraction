# sql-ddl-extraction
Extract and parse SQL, built from Azure Synapse context, into individual files sorted into folders.

Table definitions are derived from metadata found in the sys tables.

Other object definitions are exported directly from sys tables, this includes:
* Views
* Stored Procedures
* Functions

There are two SQL scripts to extract the relevant information; one for Tables and another for other Objects (Views, Stored Procedures and Functions)

Python is used to construct the CREATE DDL and save into individual SQL files.


## Table Constraints, Distribution and Indexing
Consideration has been made for the following table constraints (more to be added):
* IDENTITY
* NULL / NOT NULL


## Folder Structure
```
.
└── <repo-dir>/
    └── <schema>/
        └── <object-type>
```

## Instructions
* [OPTIONAL] [RECOMMENDED] Create a Python Virtual Environment

* Install the libraries from the requirements.txt file

* Extract the Table Metadata and Object Definition using the provided SQL Scripts; save the output as JSON

* Run the Jupyter Notebook
