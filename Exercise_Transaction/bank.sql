CREATE DATABASE bank;

mysql> desc accounts;
+------------+------------+------+-----+---------+----------------+
| Field      | Type       | Null | Key | Default | Extra          |
+------------+------------+------+-----+---------+----------------+
| id         | int(11)    | NO   | PRI | NULL    | auto_increment |
| account_no | int(11)    | NO   | UNI | NULL    |                |
| balance    | float(7,2) | NO   |     | NULL    |                |
+------------+------------+------+-----+---------+----------------+
3 rows in set (0.00 sec)

mysql> desc users;
+------------+-------------+------+-----+---------+----------------+
| Field      | Type        | Null | Key | Default | Extra          |
+------------+-------------+------+-----+---------+----------------+
| id         | int(11)     | NO   | PRI | NULL    | auto_increment |
| name       | varchar(25) | NO   |     | NULL    |                |
| email      | varchar(25) | NO   |     | NULL    |                |
| account_no | int(11)     | NO   | UNI | NULL    |                |
+------------+-------------+------+-----+---------+----------------+
4 rows in set (0.00 sec)

mysql> SELECT *
    -> FROM users;
+----+-------+----------------+------------+
| id | name  | email          | account_no |
+----+-------+----------------+------------+
|  1 | User1 | user1@mail.com |       1001 |
|  2 | User2 | user2@mail.com |       1002 |
|  3 | User3 | user3@mail.com |       1003 |
|  4 | User4 | user4@mail.com |       1004 |
|  5 | User5 | user5@mail.com |       1005 |
+----+-------+----------------+------------+
5 rows in set (0.02 sec)

mysql> SELECT *
    -> FROM accounts;                                                                                                                  +----+-----------------+---------+
| id | account_no | balance |
+----+------------+---------+
|  1 |       1001 |  105.00 |
|  2 |       1002 | 1000.90 |
|  3 |       1003 | 2200.00 |
|  4 |       1004 | 1000.00 |
|  5 |       1005 |  200.00 |
+----+------------+---------+
5 rows in set (0.00 sec)
------------------------------------------------------
Q. userA is depositing 1000 Rs. his account
--------------
mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

mysql> UPDATE users, accounts
    -> SET balance = balance + 1000
    -> WHERE users.account_no = accounts.account_no
    ->     AND users.name = 'User1';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> COMMIT;
Query OK, 0 rows affected (0.05 sec)

mysql> SELECT * 
    -> FROM accounts;
+----+------------+---------+
| id | account_no | balance |
+----+------------+---------+
|  1 |       1001 | 1105.00 |
|  2 |       1002 | 1000.90 |
|  3 |       1003 | 2200.00 |
|  4 |       1004 | 1000.00 |
|  5 |       1005 |  200.00 |
+----+------------+---------+
5 rows in set (0.00 sec)

-----------------------------
Q. userA is withdrawing 500 Rs.
-------------------
mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

mysql> UPDATE users, accounts
    -> SET balance = balance - 500
    -> WHERE users.account_no = accounts.account_no
    ->     AND users.name = 'User1';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> COMMIT;
Query OK, 0 rows affected (0.03 sec)

mysql> SELECT * FROM accounts;
+----+------------+---------+
| id | account_no | balance |
+----+------------+---------+
|  1 |       1001 |  605.00 |
|  2 |       1002 | 1000.90 |
|  3 |       1003 | 2200.00 |
|  4 |       1004 | 1000.00 |
|  5 |       1005 |  200.00 |
+----+------------+---------+
5 rows in set (0.00 sec)
-----------------------------------
Q. userA is transferring 200 Rs to userB's account
-----------------
mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

mysql> UPDATE accounts, users
    -> SET balance = balance - 200
    -> WHERE accounts.account_no = users.account_no
    ->     AND users.name = 'User1';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> UPDATE accounts, users
    -> SET balance = balance + 200
    -> WHERE accounts.account_no = users.account_no 
    ->     AND users.name = 'User2';
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> COMMIT;
Query OK, 0 rows affected (0.04 sec)

mysql> SELECT *
       FROM accounts;
+----+------------+---------+
| id | account_no | balance |
+----+------------+---------+
|  1 |       1001 |  405.00 |
|  2 |       1002 | 1200.90 |
|  3 |       1003 | 2200.00 |
|  4 |       1004 | 1000.00 |
|  5 |       1005 |  200.00 |
+----+------------+---------+
5 rows in set (0.00 sec)

