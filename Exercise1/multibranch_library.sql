mysql> CREATE TABLE Branch
    -> (
    -> BCode VARCHAR(5) NOT NULL PRIMARY KEY,
    -> Librarian VARCHAR(20) NOT NULL,
    -> Address TEXT NOT NULL
    -> );
Query OK, 0 rows affected (0.37 sec)

mysql> INSERT INTO Branch
    -> VALUES ('B1', 'John Smith', '2 Anglesea Rd'),
    ->      ('B2', 'Mary Jones', '34 Pearse St'),
    ->      ('B3', 'Francis Owens', 'Grange X');
Query OK, 3 rows affected (0.36 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM Branch;
+-------+---------------+---------------+
| BCode | Librarian     | Address       |
+-------+---------------+---------------+
| B1    | John Smith    | 2 Anglesea Rd |
| B2    | Mary Jones    | 34 Pearse St  |
| B3    | Francis Owens | Grange X      |
+-------+---------------+---------------+
3 rows in set (0.00 sec)
=========================

mysql> CREATE TABLE Titles
    -> (
    -> Title VARCHAR(30) NOT NULL,
    -> Author VARCHAR(20) NOT NULL,
    -> Publisher VARCHAR(20) NOT NULL
    -> );
Query OK, 0 rows affected (0.41 sec)

mysql> INSERT INTO Titles
    -> VALUES ('Susannah', 'Ann Brown', 'Macmillan'),
    ->    ('How to Fish', 'Amy Fly', 'Stop Press'),
    ->    ('A History Of Dublin', 'David Little', 'Wiley'),
    ->    ('Computers', 'Blaise Pascal', 'Applewoods'),
    ->    ('The Wife', 'Ann Brown', 'Macmillan');
Query OK, 5 rows affected (0.10 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM Titles;
+---------------------+---------------+------------+
| Title               | Author        | Publisher  |
+---------------------+---------------+------------+
| Susannah            | Ann Brown     | Macmillan  |
| How to Fish         | Amy Fly       | Stop Press |
| A History Of Dublin | David Little  | Wiley      |
| Computers           | Blaise Pascal | Applewoods |
| The Wife            | Ann Brown     | Macmillan  |
+---------------------+---------------+------------+
5 rows in set (0.00 sec)
======================================

mysql> CREATE TABLE Holdings
    -> (
    -> Branch VARCHAR(5) NOT NULL,
    -> Title VARCHAR(30) NOT NULL,
    -> `#copies` INT(5) NOT NULL
    -> );
Query OK, 0 rows affected (0.44 sec)

mysql> INSERT INTO Holdings
    -> VALUES ('B1', 'Susannah', 3),
    ->     ('B1', 'How to Fish', 2),
    ->     ('B1', 'A History Of Dublin', 1);
    ->     ('B2', 'How to Fish', 4),
    ->     ('B2', 'Computers', 2),
    ->     ('B2', 'The Wife', 3);
    ->     ('B3', 'A History Of Dublin', 1),
    ->     ('B3', 'Computers', 4),
    ->     ('B3', 'Susannah', 3),
    ->     ('B3', 'The Wife', 1);
Query OK, 10 rows affected (0.10 sec)
Records: 10  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM Holdings;
+--------+---------------------+---------+
| Branch | Title               | #copies |
+--------+---------------------+---------+
| B1     | Susannah            |       3 |
| B1     | How to Fish         |       2 |
| B1     | A History Of Dublin |       1 |
| B2     | How to Fish         |       4 |
| B2     | Computers           |       2 |
| B2     | The Wife            |       3 |
| B3     | A History Of Dublin |       1 |
| B3     | Computers           |       4 |
| B3     | Susannah            |       3 |
| B3     | The Wife            |       1 |
+--------+---------------------+---------+
10 rows in set (0.00 sec)
=============================================================
1. Name of all books published by macmillan
------
mysql> SELECT Title 
    -> FROM Titles
    -> WHERE Publisher = 'Macmillan';
+----------+
| Title    |
+----------+
| Susannah |
| The Wife |
+----------+
2 rows in set (0.00 sec)

========================

2. Branches that hold any books of Ann Brown (using subquery)
-------------
mysql> SELECT DISTINCT Branch
    -> FROM Holdings
    -> WHERE h.Title IN
    ->     ( SELECT Title FROM Titles
    ->       WHERE Author = 'Ann Brown'
    ->     );
+--------+
| Branch |
+--------+
| B1     |
| B2     |
| B3     |
+--------+
3 rows in set (0.00 sec)
========================

3. Branches that hold any books of Ann Brown (without using subquery)
-------------

mysql> SELECT DISTINCT Branch
    -> FROM Holdings AS h, Titles AS t
    -> WHERE h.Title = t.Title
    ->     AND t.Author = 'Ann Brown';
+--------+
| Branch |
+--------+
| B1     |
| B2     |
| B3     |
+--------+
3 rows in set (0.00 sec)
=============================================
4. The total number of books at each branch
------------
mysql> SELECT Branch, SUM(`#copies`) AS 'TOTAL BOOKS'
    -> FROM Holdings
    -> GROUP BY Branch;
+--------+-------------+
| Branch | TOTAL BOOKS |
+--------+-------------+
| B1     |           6 |
| B2     |           9 |
| B3     |           9 |
+--------+-------------+
3 rows in set (0.00 sec)

