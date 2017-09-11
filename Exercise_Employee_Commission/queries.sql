mysql> CREATE TABLE Departments
    -> (
    -> `ID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    -> `NAME` VARCHAR(20) NOT NULL
    -> );
Query OK, 0 rows affected (0.35 sec)

mysql> CREATE TABLE Employees
    -> (
    -> `ID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    -> `NAME` VARCHAR(20) NOT NULL,
    -> `SALARY` INT NOT NULL,
    -> `DEPARTMENT_ID` INT NOT NULL,
    -> FOREIGN KEY(DEPARTMENT_ID) REFERENCES Departments(ID)
    -> );

mysql> CREATE TABLE Commissions
    -> (
    -> `ID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    -> `EMPLOYEE_ID` INT NOT NULL,
    -> `COMMISSION_AMOUNT` INT NOT NULL,
    -> FOREIGN KEY(EMPLOYEE_IDmysql> INSERT Departments
    -> VALUES ('', 'Banking'),
    ->        ('', 'Insurance'),
    ->        ('', 'Services');
Query OK, 3 rows affected, 3 warnings (0.03 sec)
Records: 3  Duplicates: 0  Warnings: 3

mysql> INSERT Employees
    -> VALUES (1, 'Chris Gayle', 1000000, 1),
    ->        ('', 'Micheal Clarke', 800000, 2),
    ->        ('', 'Rahul Dravid', 700000, 1),
    ->        ('', 'Ricky Pointing', 600000, 2),
    ->        ('', 'Albie Morkel', 650000, 2),
    ->        ('', 'Wasim Akram', 750000, 3);
Query OK, 6 rows affected, 5 warnings (0.04 sec)
Records: 6  Duplicates: 0  Warnings: 5

mysql> INSERT Commissions
    -> VALUES (1, 1, 5000),
    ->        ('', 2, 3000),
    ->        ('', 3, 4000),
    ->        ('', 1, 4000),
    ->        ('', 2, 3000),
    ->        ('', 4, 2000),
    ->        ('', 5, 1000),
    ->        ('', 6, 5000);
Query OK, 8 rows affected, 7 warnings (0.07 sec)
Records: 8  Duplicates: 0  Warnings: 7

mysql> SELECT * 
    -> FROM Departments;
+----+-----------+
| ID | NAME      |
+----+-----------+
|  1 | Banking   |
|  2 | Insurance |
|  3 | Services  |
+----+-----------+
3 rows in set (0.00 sec)

mysql> SELECT *
    -> FROM Employees;
+----+----------------+---------+---------------+
| ID | NAME           | SALARY  | DEPARTMENT_ID |
+----+----------------+---------+---------------+
|  1 | Chris Gayle    | 1000000 |             1 |
|  2 | Micheal Clarke |  800000 |             2 |
|  3 | Rahul Dravid   |  700000 |             1 |
|  4 | Ricky Pointing |  600000 |             2 |
|  5 | Albie Morkel   |  650000 |             2 |
|  6 | Wasim Akram    |  750000 |             3 |
+----+----------------+---------+---------------+
6 rows in set (0.00 sec)

mysql> SELECT * 
    -> FROM Commissions;
+----+-------------+-------------------+
| ID | EMPLOYEE_ID | COMMISSION_AMOUNT |
+----+-------------+-------------------+
|  1 |           1 |              5000 |
|  2 |           2 |              3000 |
|  3 |           3 |              4000 |
|  4 |           1 |              4000 |
|  5 |           2 |              3000 |
|  6 |           4 |              2000 |
|  7 |           5 |              1000 |
|  8 |           6 |              5000 |
+----+-------------+-------------------+
8 rows in set (0.00 sec)
======================================================================

Q1. Find the employee who gets the highest total commission.
ANSWER-
mysql> SELECT NAME FROM Employees, Commissions
    -> WHERE Employees.ID = Commissions.EMPLOYEE_ID
    -> GROUP BY (Commissions.EMPLOYEE_ID)
    -> ORDER BY SUM(Commissions.COMMISSION_AMOUNT) DESC
    -> LIMIT 1;
+-------------+
| NAME        |
+-------------+
| Chris Gayle |
+-------------+
1 row in set (0.00 sec)
-------------------

Q2. Find employee with 4th Highest salary from employee table.
ANSWER-
mysql> SELECT NAME
    -> FROM Employees
    -> ORDER BY SALARY DESC
    -> LIMIT 3,1;
+--------------+
| NAME         |
+--------------+
| Rahul Dravid |
+--------------+
1 row in set (0.00 sec)
---------------------------------------

Q3. Find department that is giving highest commission.
ANSWER-
mysql> SELECT Departments.NAME
    -> FROM Departments, Employees, Commissions
    -> WHERE Departments.ID = Employees.DEPARTMENT_ID
    ->     AND Employees.ID = Commissions.EMPLOYEE_ID
    -> GROUP BY Employees.DEPARTMENT_ID
    -> ORDER BY SUM(Commissions.COMMISSION_AMOUNT) DESC
    -> LIMIT 1;
+---------+
| NAME    |
+---------+
| Banking |
+---------+
1 row in set (0.00 sec)
----------------------------------------

Q4.Find employees getting commission more than 3000
ANSWER-
mysql> SELECT GROUP_CONCAT(DISTINCT Employees.NAME) as PLAYERS
    -> FROM Employees, Commissions
    -> WHERE Employees.ID = Commissions.EMPLOYEE_ID
    ->     AND Commissions.COMMISSION_AMOUNT > 3000;
+--------------------------------------+
| PLAYERS                              |
+--------------------------------------+
| Chris Gayle,Rahul Dravid,Wasim Akram |
+--------------------------------------+
1 row in set (0.01 sec)


