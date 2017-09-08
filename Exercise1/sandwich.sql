mysql> CREATE TABLE TASTES
    -> (
    ->     `Name` VARCHAR(20) NOT NULL,
    ->     `Filling` VARCHAR(20) NOT NULL
    -> );
Query OK, 0 rows affected (0.37 sec)

mysql> INSERT INTO TASTES
    -> VALUES ('Brown', 'Turkey'),
    ->     ('Brown', 'Beef'),
    ->     ('Brown', 'Ham'),
    ->     ('Jones', 'Cheese'),
    ->     ('Green', 'Beef'),
    ->     ('Green', 'Turkey'),
    ->     ('Green', 'Cheese')
    -> ;
Query OK, 7 rows affected (0.10 sec)
Records: 7  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM TASTES;
+-------+---------+
| Name  | Filling |
+-------+---------+
| Brown | Turkey  |
| Brown | Beef    |
| Brown | Ham     |
| Jones | Cheese  |
| Green | Beef    |
| Green | Turkey  |
| Green | Cheese  |
+-------+---------+
7 rows in set (0.00 sec)

--------------------------------

mysql> CREATE TABLE LOCATIONS
    -> (
    ->     `LName` VARCHAR(20) NOT NULL,
    ->     `Phone` VARCHAR(8) NOT NULL,
    ->     `Address` TEXT NOT NULL
    -> );
Query OK, 0 rows affected (0.31 sec)

mysql> INSERT INTO LOCATIONS
    -> VALUES ('Lincoln', '682 4523', 'Lincoln Place'),
    ->     ('O\'Neills\'s', '674 2134', 'Pearse St'),
    ->     ('Old Nag', '767 8132', 'Dame St'),
    ->     ('Buttery', '702 3421', 'College St');
Query OK, 4 rows affected (0.10 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM LOCATIONS;                                                                                                        +------------+----------+---------------+
| LName      | Phone    | Address       |
+------------+----------+---------------+
| Lincoln    | 682 4523 | Lincoln Place |
| O'Neills's | 674 2134 | Pearse St     |
| Old Nag    | 767 8132 | Dame St       |
| Buttery    | 702 3421 | College St    |
+------------+----------+---------------+
4 rows in set (0.00 sec)

---------------------------------------
mysql> CREATE TABLE SANDWICHES
    -> (
    ->     `Location` VARCHAR(20) NOT NULL,
    ->     `Bread` VARCHAR(10) NOT NULL,
    ->     `Filling` VARCHAR(10) NOT NULL,
    ->     `Price` FLOAT(3,2) NOT NULL
    -> );
Query OK, 0 rows affected (0.48 sec)

mysql> INSERT INTO SANDWICHES
    -> VALUES ('Lincoln', 'Rye', 'Ham', 1.25),
    ->     ('O\'Neills\'s', 'White', 'Cheese', 1.20),
    ->     ('O\'Neills\'s', 'Whole', 'Ham', 1.25),
    ->     ('Old Nag', 'Rye', 'Beef', 1.35),
    ->     ('Buttery', 'White', 'Cheese', 1.00),
    ->     ('O\'Neills\'s', 'White', 'Turkey', 1.35),
    ->     ('Buttery', 'White', 'Ham', 1.10),
    ->     ('Lincoln', 'Rye', 'Beef', 1.35),
    ->     ('Lincoln', 'White', 'Ham', 1.30),
    ->     ('Old Nag', 'Rye', 'Ham', 1.40);
Query OK, 10 rows affected (0.46 sec)
Records: 10  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM SANDWICHES;
+------------+-------+---------+-------+
| Location   | Bread | Filling | Price |
+------------+-------+---------+-------+
| Lincoln    | Rye   | Ham     |  1.25 |
| O'Neills's | White | Cheese  |  1.20 |
| O'Neills's | Whole | Ham     |  1.25 |
| Old Nag    | Rye   | Beef    |  1.35 |
| Buttery    | White | Cheese  |  1.00 |
| O'Neills's | White | Turkey  |  1.35 |
| Buttery    | White | Ham     |  1.10 |
| Lincoln    | Rye   | Beef    |  1.35 |
| Lincoln    | White | Ham     |  1.30 |
| Old Nag    | Rye   | Ham     |  1.40 |
+------------+-------+---------+-------+
10 rows in set (0.00 sec)

---------------------------
1. Places where Jones can eat (using subquery)
-------
mysql> SELECT Location 
    -> FROM SANDWICHES
    -> WHERE Filling IN
    ->    ( SELECT Filling
    ->      FROM TASTES
    ->      WHERE Name = 'Jones'
    ->    );
+------------+
| Location   |
+------------+
| O'Neills's |
| Buttery    |
+------------+
2 rows in set (0.00 sec)
--------------------------
2. Places where Jones can eat (without using subquery)
--------
mysql> SELECT Location 
    -> FROM SANDWICHES AS s, TASTES AS t
    -> WHERE s.Filling = t.Filling
    ->     AND t.Name = 'Jones';
+------------+
| Location   |
+------------+
| O'Neills's |
| Buttery    |
+------------+
2 rows in set (0.00 sec)
----------------------------------
3. For each location, number of people who can eat there.
mysql> SELECT Location, COUNT(DISTINCT Name)
    -> FROM SANDWICHES AS s, TASTES as t
    -> WHERE s.Filling = t.Filling
    -> GROUP BY Location;
+------------+----------------------+
| Location   | COUNT(DISTINCT Name) |
+------------+----------------------+
| Buttery    |                    3 |
| Lincoln    |                    2 |
| O'Neills's |                    3 |
| Old Nag    |                    2 |
+------------+----------------------+
4 rows in set (0.00 sec)
=============================================================
