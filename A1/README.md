# ECE 356 Assignment 1

By: Jeffrey Wu | 20711858 | j387wu

## Task 1

### Logging
Dear whoever is marking this,

Firstly, I made a typo when trying to log my output for the second time and named the file `cliSession` instead of `cliSession.txt`; this caused 2 separate files to be created. To remedy this, I just appended the second file to the first.

Secondly, I realized I had made a mistake in 4e and initially gave the column name instead of column type. I fixed the answer and just appended the CLI log to the bottom of the cliSession file.

Also, I made the mistake of doing a `SELECT *` which caused my log file to explode.
I've attached a `cliSessionReduced.txt` that removes the offending command and it's output to save you from scolling 1000 lines.

I apologize for any inconvenience my butterfingers have caused.

### CLI vs SQL
I interpreted the invalid SQL "syntactic sugar" to be "CLI commands" because they are "not valid SQL commands" so I assume it's the CLI or SQL server translating this convenience command into a raw SQL command.

## Task 2
Code structure is a bit wonky since I reused `if (argc ==3)` multiple times to check if `-l/n` had been passed. I haven't used C++ in a while; don't judge me. 🤪
Also I just concatenated `WHERE _____ NOT LIKE` into the query string. I interpreted the instructions saying the

## Task 3
Initially tried to make all queries inline but realized after checking piazza that we could use the assignment operator.
Other comments are written in the PDF file. If you really hate my handwriting, please let me know and I can switch to latex next time :D
