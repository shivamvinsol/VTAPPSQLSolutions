CREATE DATABASE knowledge_management;
Query OK, 1 row affected (0.00 sec)

USE knowledge_management;
Database changed

mysql> CREATE TABLE employees(
    -> `id` INT PRIMARY KEY AUTO_INCREMENT,
    -> `name` VARCHAR(20) NOT NULL
    -> );
Query OK, 0 rows affected (0.26 sec)

mysql> CREATE TABLE projects(
    -> `id` INT PRIMARY KEY AUTO_INCREMENT,
    -> `name` VARCHAR(20) NOT NULL
    -> );
Query OK, 0 rows affected (0.39 sec)

mysql> CREATE TABLE technologies(
    -> `id` INT PRIMARY KEY AUTO_INCREMENT,
    -> `name` VARCHAR(20) NOT NULL
    -> );
Query OK, 0 rows affected (0.34 sec)

mysql> CREATE TABLE project_technology(
    -> `project_id` INTEGER,
    -> `technology_id` INTEGER,
    -> FOREIGN KEY(`project_id`) REFERENCES projects(`id`),
    -> FOREIGN KEY(`technology_id`) REFERENCES technologies(`id`)
    -> );
Query OK, 0 rows affected (0.44 sec)

mysql> CREATE TABLE employee_project(
    -> `employee_id` INTEGER,
    -> `project_id` INTEGER,
    -> `currently_working` BIT(1) NOT NULL;
    -> FOREIGN KEY(`employee_id`) REFERENCES employees(`id`),
    -> FOREIGN KEY(`project_id`) REFERENCES projects(`id`)
    -> );
Query OK, 0 rows affected (0.49 sec)
-------------------------------------------------------
mysql> INSERT employees
    -> VALUES ('', 'User A'),
    ->        ('', 'User B'),
    ->        ('', 'User C'),
    ->        ('', 'User D');
Query OK, 4 rows affected, 4 warnings (0.10 sec)

mysql> INSERT projects
    -> VALUES ('', 'P1'),
    ->        ('', 'P2'),
    ->        ('', 'P3'),
    ->        ('', 'P4'),
    ->        ('', 'P5'),
    ->        ('', 'P6'),
    ->        ('', 'P7'),
    ->        ('', 'P8'),
    ->        ('', 'P9');
Query OK, 9 rows affected, 9 warnings (0.10 sec)
Records: 9  Duplicates: 0  Warnings: 9

mysql> INSERT technologies
    -> VALUES ('', 'HTML'),
    ->        ('', 'Javascript'),
    ->        ('', 'Ruby'),
    ->        ('', 'Rails'),
    ->        ('', 'IOS'),
    ->        ('', 'ANDriod');
Query OK, 6 rows affected, 6 warnings (0.37 sec)
Records: 6  Duplicates: 0  Warnings: 6

mysql> INSERT employee_project
    -> VALUES (1, 1, 0),
    ->        (1, 2, 0),
    ->        (1, 3, 0),
    ->        (1, 6, 1),
    ->        (2, 1, 0),
    ->        (2, 3, 0),
    ->        (2, 7, 0),
    ->        (2, 9, 0),
    ->        (3, 1, 0),
    ->        (3, 8, 0),
    ->        (3, 9, 0),
    ->        (3, 2, 0),
    ->        (4, 1, 0),
    ->        (4, 2, 0),
    ->        (4, 4, 0),
    ->        (4, 5, 1),
    ->        (4, 6, 1);
Query OK, 17 rows affected (0.18 sec)
Records: 17  Duplicates: 0  Warnings: 0

mysql> INSERT project_technology
    -> VALUES (1, 1),
    ->        (1, 2);
    ->        (1, 3),
    ->        (1, 4),
    ->        (2, 5),
    ->        (3, 6),
    ->        (4, 5),
    ->        (4, 6),
    ->        (5, 3),
    ->        (5, 4),
    ->        (6, 1),
    ->        (6, 6),
    ->        (6, 2),
    ->        (7, 6),
    ->        (7, 5),
    ->        (8, 1),
    ->        (8, 2),
    ->        (8, 3),
    ->        (8, 4),
    ->        (8, 6),
    ->        (9, 5);
Query OK, 21 rows affected (0.18 sec)
Records: 21  Duplicates: 0  Warnings: 0

---------------------------------------------------
1) Find names of all employees currently not working in any projects. (Use joins)
join-
mysql> SELECT e.name
       FROM employees e, employee_project ep
       WHERE e.id = ep.employee_id
       GROUP BY e.name
       HAVING SUM(CASE WHEN currently_working = 0 THEN 0 ELSE 1 END) = 0;
// if currently_working stores T/F instead of 0/1, we can use the same logic.
+--------+
| name   |
+--------+
| User B |
| User C |
+--------+
2 rows in set (0.00 sec)

subquery-
mysql> SELECT name
       FROM employees
       WHERE id NOT IN (
           SELECT employee_id
           FROM employee_project
           WHERE currently_working = 1
       );
+--------+
| name   |
+--------+
| User B |
| User C |
+--------+
2 rows in set (0.00 sec)
--------------------------
2) Find all employees who have exposure to HTML, Javascript and IOS.

// to check if query is correct or not, changed technology name.

mysql> SELECT e.name
       FROM employees e, employees e2, employees e3, technologies t, technologies t2, technologies t3, employee_project ep,
            employee_project ep2, employee_project ep3, project_technology pt, project_technology pt2, project_technology pt3
       WHERE e.id = ep.employee_id
       AND ep.project_id = pt.project_id 
       AND t.id = pt.technology_id
       AND t.name = 'HTML' 
       AND e2.id = ep2.employee_id
       AND ep2.project_id = pt2.project_id
       AND t2.id = pt2.technology_id
       AND t2.name = 'Javascript'
       AND e3.id = ep3.employee_id
       AND ep3.project_id = pt3.project_id
       AND t3.id = pt3.technology_id
       AND t3.name = 'Java'
       AND e.id = e2.id
       AND e.id = e3.id
       GROUP BY e.name;
+--------+
| name   |
+--------+
| User B |
+--------+
1 row in set (0.02 sec)



mysql> SELECT DISTINCT e.name FROM employees e, technologies t, employee_project ep, project_technology pt
       WHERE e.id = ep.employee_id
       AND pt.technology_id = t.id
       AND ep.project_id = pt.project_id
       AND t.name = 'Javascript'
       AND e.name in
          ( SELECT e.name
            FROM employees e, technologies t, employee_project ep, project_technology pt
            WHERE e.id = ep.employee_id
            AND pt.technology_id = t.id 
            AND ep.project_id = pt.project_id
            AND t.name = 'HTML'
            AND e.name in 
                (  SELECT e.name
                   FROM employees e, technologies t, employee_project ep, project_technology pt 
                   WHERE e.id = ep.employee_id
                   AND pt.technology_id = t.id
                   AND ep.project_id = pt.project_id
                   AND t.name = 'IOS'
                )
          );
+--------+
| name   |
+--------+
| User A |
| User B |
| User C |
| User D |
+--------+
4 rows in set (0.01 sec)


----------------------------

3) Find the technologies in which a particular employee(Say B) has expertise(3 or more projects)

mysql> SELECT t.name
       FROM employees e, employee_project ep, technologies t, project_technology pt
       WHERE e.id = ep.employee_id
       AND t.id = pt.technology_id
       AND ep.project_id = pt.project_id
       AND e.name = 'User B'
       GROUP BY t.name
       HAVING count(t.name) > 1;
+---------+
| name    |
+---------+
| Android |
| IOS     |
+---------+
2 rows in set (0.00 sec)
-------------------------------------------------
4) Find the employee who has done most no of projects in android (do this using variable also).

mysql> SELECT e.name
       FROM employees e, technologies t, employee_project ep, project_technology pt
       WHERE e.id = ep.employee_id
       AND ep.project_id = pt.project_id
       AND t.id = pt.technology_id
       AND t.name = 'Android'
       GROUP BY e.name
       ORDER BY count(*)
       DESC LIMIT 1;
+--------+
| name   |
+--------+
| User D |
+--------+
1 row in set (0.00 sec)

using variables--

mysql> SELECT @max:= count(*)
       FROM employees e, technologies t, employee_project ep, project_technology pt
       WHERE e.id = ep.employee_id                       
       AND ep.project_id = pt.project_id
       AND t.id = pt.technology_id
       AND t.name = 'Android'
       GROUP BY e.name
       ORDER BY count(*)
       DESC LIMIT 1;

mysql> SELECT e.name
       FROM employees e, technologies t, employee_project ep, project_technology pt
       WHERE e.id = ep.employee_id
       AND ep.project_id = pt.project_id
       AND t.id = pt.technology_id
       AND t.name = 'Android'
       GROUP BY e.name
       HAVING count(*) = @max;
+--------+
| name   |
+--------+
| User A |
| User B |
| User D |
+--------+
3 rows in set (0.00 sec)


