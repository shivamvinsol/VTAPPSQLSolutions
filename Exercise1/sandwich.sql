mysql> CREATE TABLE tastes
    -> (
    ->     `name` VARCHAR(20) NOT NULL,
    ->     `filling` VARCHAR(20) NOT NULL
    -> );
Query OK, 0 rows affected (0.37 sec)

mysql> INSERT INTO tastes
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

mysql> SELECT * FROM tastes;
+-------+---------+
| name  | filling |
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

mysql> CREATE TABLE locations
    -> (
    ->     `lname` VARCHAR(20) NOT NULL,
    ->     `phone` VARCHAR(8) NOT NULL,
    ->     `address` TEXT NOT NULL
    -> );
Query OK, 0 rows affected (0.31 sec)

mysql> INSERT INTO locations
    -> VALUES ('Lincoln', '682 4523', 'Lincoln Place'),
    ->     ('O\'Neills\'s', '674 2134', 'Pearse St'),
    ->     ('Old Nag', '767 8132', 'Dame St'),
    ->     ('Buttery', '702 3421', 'College St');
Query OK, 4 rows affected (0.10 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM locations;                                                                                                        +------------+----------+---------------+
| lname      | phone    | address       |
+------------+----------+---------------+
| Lincoln    | 682 4523 | Lincoln Place |
| O'Neills's | 674 2134 | Pearse St     |
| Old Nag    | 767 8132 | Dame St       |
| Buttery    | 702 3421 | College St    |
+------------+----------+---------------+
4 rows in set (0.00 sec)

---------------------------------------
mysql> CREATE TABLE sandwiches
    -> (
    ->     `location` VARCHAR(20) NOT NULL,
    ->     `bread` VARCHAR(10) NOT NULL,
    ->     `filling` VARCHAR(10) NOT NULL,
    ->     `price` FLOAT(3,2) NOT NULL
    -> );
Query OK, 0 rows affected (0.48 sec)

mysql> INSERT INTO sandwiches
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

mysql> SELECT * FROM sandwiches;
+------------+-------+---------+-------+
| location   | bread | filling | price |
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
mysql> SELECT location 
    -> FROM sandwiches
    -> WHERE filling IN
    ->    ( SELECT filling
    ->      FROM tastes
    ->      WHERE name = 'Jones'
    ->    );
+------------+
| location   |
+------------+
| O'Neills's |
| Buttery    |
+------------+
2 rows in set (0.00 sec)
--------------------------
2. Places where Jones can eat (without using subquery)
--------
mysql> SELECT location 
    -> FROM sandwiches AS s, tastes AS t
    -> WHERE s.filling = t.filling
    ->     AND t.name = 'Jones';
+------------+
| location   |
+------------+
| O'Neills's |
| Buttery    |
+------------+
2 rows in set (0.00 sec)
----------------------------------
3. For each location, number of people who can eat there.
mysql> SELECT location, COUNT(DISTINCT name)
    -> FROM sandwiches AS s, tastes AS t
    -> WHERE s.filling = t.filling
    -> GROUP BY location;
+------------+----------------------+
| location   | COUNT(DISTINCT name) |
+------------+----------------------+
| Buttery    |                    3 |
| Lincoln    |                    2 |
| O'Neills's |                    3 |
| Old Nag    |                    2 |
+------------+----------------------+
4 rows in set (0.00 sec)
=============================================================
