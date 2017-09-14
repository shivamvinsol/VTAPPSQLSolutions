mysql> CREATE TABLE Users
    -> (
    -> `ID` INT NOT NULL AUTO_INCERMENT PRIMARY KEY,
    -> `NAME` VARCHAR(20) NOT NULL,
    -> `ROLE` ENUM('admin', 'normal') NOT NULL
    -> );

Query OK, 0 rows affected (0.67 sec)

mysql> CREATE TABLE Articles
    -> (
    -> `ID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    -> `TITLE` VARCHAR(20) NOT NULL,
    -> `CONTENT` TEXT NOT NULL,
    -> `CATEGORY_ID` INT NOT NULL,
    -> `USERS_ID` INT NOT NULL,
    -> FOREIGN KEY(USERS_ID) REFERENCES Users(ID)
    -> ON UPDATE CASCADE
    -> ON DELETE CASCADE,
    -> FOREIGN KEY(CATEGORY_ID) REFERENCES Categories(ID)
    -> ON UPDATE CASCADE
    -> ON DELETE CASCADE,
    -> );

mysql> CREATE TABLE Comments
    -> (
    -> `ID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    -> `COMMENT` TEXT NOT NULL,
    -> `USER_ID` INT NOT NULL,
    -> `ARTICLE_ID` INT NOT NULL,
    -> FOREIGN KEY(USER_ID) REFERENCES Users(ID)
    -> ON UPDATE CASCADE
    -> ON DELETE CASCADE,
    -> FOREIGN KEY(ARTICLE_ID) REFERENCES Articles(ID)
    -> ON UPDATE CASCADE
    -> ON DELETE CASCADE,
    -> );
Query OK, 0 rows affected (0.68 sec)

CREATE TABLE Categories
    -> (
    -> `ID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    -> `NAME` VARCHAR(20) NOT NULL
    -> );

mysql> desc Users;
+-------+------------------------+------+-----+---------+----------------+
| Field | Type                   | Null | Key | Default | Extra          |
+-------+------------------------+------+-----+---------+----------------+
| ID    | int(11)                | NO   | PRI | NULL    | auto_increment |
| NAME  | varchar(20)            | NO   |     | NULL    |                |
| ROLE  | enum('admin','normal') | NO   |     | NULL    |                |
+-------+------------------------+------+-----+---------+----------------+
3 rows in set (0.00 sec)

mysql> desc Articles;
+-------------+-------------+------+-----+---------+----------------+
| Field       | Type        | Null | Key | Default | Extra          |
+-------------+-------------+------+-----+---------+----------------+
| ID          | int(11)     | NO   | PRI | NULL    | auto_increment |
| TITLE       | varchar(20) | NO   |     | NULL    |                |
| CONTENT     | text        | NO   |     | NULL    |                |
| CATEGORY_ID | int(11)     | NO   | MUL | NULL    |                |
| USER_ID     | int(11)     | NO   | MUL | NULL    |                |
+-------------+-------------+------+-----+---------+----------------+
5 rows in set (0.00 sec)

mysql> desc Comments;
+------------+---------+------+-----+---------+----------------+
| Field      | Type    | Null | Key | Default | Extra          |
+------------+---------+------+-----+---------+----------------+
| ID         | int(11) | NO   | PRI | NULL    | auto_increment |
| COMMENT    | text    | NO   |     | NULL    |                |
| USER_ID    | int(11) | NO   | MUL | NULL    |                |
| ARTICLE_ID | int(11) | NO   | MUL | NULL    |                |
+------------+---------+------+-----+---------+----------------+
4 rows in set (0.00 sec)

mysql> desc Categories;
+-------+-------------+------+-----+---------+----------------+
| Field | Type        | Null | Key | Default | Extra          |
+-------+-------------+------+-----+---------+----------------+
| ID    | int(11)     | NO   | PRI | NULL    | auto_increment |
| NAME  | varchar(20) | NO   |     | NULL    |                |
+-------+-------------+------+-----+---------+----------------+
2 rows in set (0.00 sec)

-----------------------------------------------------------------
mysql> INSERT Users
    -> VALUES ('', 'User1', 'admin'),
    ->        ('', 'User2', 'admin'),
    ->        ('', 'User3', 'normal'),
    ->        ('', 'User4', 'normal'),
    ->        ('', 'User5', 'normal');
Query OK, 5 rows affected, 5 warnings (0.10 sec)
Records: 5  Duplicates: 0  Warnings: 5

mysql> INSERT Categories
    -> VALUES (1, 'Politics'),
    ->        ('', 'Joke'),
    ->        ('', 'Sports'),
    ->        ('', 'Movies');
Query OK, 4 rows affected, 3 warnings (0.04 sec)
Records: 4  Duplicates: 0  Warnings: 3

mysql> INSERT Articles
    -> VALUES (1, 'Joke of day', 'Lorem IPUSM lOPECV FEEWFVV', 1, 1),
    ->        ('', 'Politics', 'Modi kejriwal pappu', 3, 4),
    ->        ('', '1000 rs note', 'lorme kekroek jjfojf kofkkfok', 2, 4),
    ->        ('', 'bank', 'deposit fmoent', 1, 5);
Query OK, 4 rows affected, 3 warnings (0.04 sec)
Records: 4  Duplicates: 0  Warnings: 3

mysql> INSERT Comments
    -> VALUES (1, 'HAHA', 2, 2),
    ->        ('', 'LOL', 2, 4),
    ->        ('', 'sad', 1, 3),
    ->        ('', 'okay', 3,1 ),
    ->        ('', 'ok', 5,2),
    ->        ('', 'hmm', 4,1);
Query OK, 6 rows affected, 5 warnings (0.27 sec)
Records: 6  Duplicates: 0  Warnings: 5

-----------------------

mysql> SELECT *
    -> FROM Users;
+----+-------+--------+
| ID | NAME  | ROLE   |
+----+-------+--------+
|  1 | User1 | admin  |
|  2 | User2 | admin  |
|  3 | User3 | normal |
|  4 | User4 | normal |
|  5 | User5 | normal |
+----+-------+--------+
5 rows in set (0.00 sec)

mysql> SELECT * 
    -> FROM Articles;
+----+--------------+-------------------------------+-------------+---------+
| ID | TITLE        | CONTENT                       | CATEGORY_ID | USER_ID |
+----+--------------+-------------------------------+-------------+---------+
|  1 | Joke of day  | Lorem IPUSM lOPECV FEEWFVV    |           1 |       1 |
|  2 | Politics     | Modi kejriwal pappu           |           3 |       4 |
|  3 | 1000 rs note | lorme kekroek jjfojf kofkkfok |           2 |       4 |
|  4 | bank         | deposit fmoent                |           1 |       5 |
+----+--------------+-------------------------------+-------------+---------+
4 rows in set (0.00 sec)

mysql> SELECT * 
    -> FROM Comments;
+----+---------+---------+------------+
| ID | COMMENT | USER_ID | ARTICLE_ID |
+----+---------+---------+------------+
|  1 | HAHA    |       2 |          2 |
|  2 | LOL     |       2 |          4 |
|  3 | sad     |       1 |          3 |
|  4 | okay    |       3 |          1 |
|  5 | ok      |       5 |          2 |
|  6 | hmm     |       4 |          1 |
+----+---------+---------+------------+
6 rows in set (0.00 sec)

mysql> SELECT *  
    -> FROM Categories;
+----+----------+
| ID | NAME     |
+----+----------+
|  1 | Politics |
|  2 | Joke     |
|  3 | Sports   |
|  4 | Movies   |
+----+----------+
4 rows in set (0.00 sec)

-----------------------------------------------------
Q1. Manage(create, update, delete) categories, articles, comments, and users
mysql> INSERT Users
    -> VALUES('', 'User6', 'normal');
Query OK, 1 row affected, 1 warning (0.35 sec)

mysql> INSERT Articles
    -> VALUES ('', 'Virat', 'Kohli scores Century', 2, 3),
    ->        ('', 'Floods', 'Floods in USA', 1, 3);

mysql> INSERT Comments
    -> VALUES('', 'its good', 6, 3);
Query OK, 1 row affected, 1 warning (0.47 sec)

mysql> DELETE 
    -> FROM Users
    -> WHERE ID = 6;
Query OK, 1 row affected (0.04 sec)

mysql> INSERT Comments
    -> VALUES ('', 'Wow', 1, 6),
    ->        ('', 'Wonderful', 2, 6),
    ->        ('', 'SAD', 4, 7);
Query OK, 3 rows affected, 3 warnings (0.38 sec)
Records: 3  Duplicates: 0  Warnings: 3


mysql> UPDATE Categories
    -> SET Name = 'Humour'
    -> WHERE ID = 2;
Query OK, 1 row affected (0.09 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> DELETE 
    -> FROM Articles
    -> WHERE ID = 4;
Query OK, 1 row affected (0.09 sec)

mysql> SELECT * FROM Comments;
+----+---------+---------+------------+
| ID | COMMENT | USER_ID | ARTICLE_ID |
+----+---------+---------+------------+
|  1 | HAHA    |       2 |          2 |
|  3 | sad     |       1 |          3 |
|  4 | okay    |       3 |          1 |
|  5 | ok      |       5 |          2 |
|  6 | hmm     |       4 |          1 |
+----+---------+---------+------------+
5 rows in set (0.00 sec)

================================================

Q2. Select all articles whose author's name is user3 (Do this exercise using variable also).
Ans.
mysql> SELECT Articles.*
    -> FROM Articles,
    -> Users WHERE Articles.USER_ID = Users.ID
    ->     AND Users.NAME = 'User3';
+----+--------+----------------------+-------------+---------+
| ID | TITLE  | CONTENT              | CATEGORY_ID | USER_ID |
+----+--------+----------------------+-------------+---------+
|  6 | Virat  | Kohli scores Century |           2 |       3 |
|  7 | Floods | Floods in USA        |           1 |       3 |
+----+--------+----------------------+-------------+---------+
2 rows in set (0.00 sec)

using variable----
mysql> SET @user_name = 'User3';
Query OK, 0 rows affected (0.00 sec)
mysql> SELECT Articles.*
    -> FROM Articles,
    -> Users WHERE Articles.USER_ID = Users.ID
    ->     AND Users.NAME = @user_name;
+----+--------+----------------------+-------------+---------+
| ID | TITLE  | CONTENT              | CATEGORY_ID | USER_ID |
+----+--------+----------------------+-------------+---------+
|  6 | Virat  | Kohli scores Century |           2 |       3 |
|  7 | Floods | Floods in USA        |           1 |       3 |
+----+--------+----------------------+-------------+---------+
2 rows in set (0.00 sec)
===================================================

Q3. For all the articles being selected above, select all the articles and also the comments associated with those articles in a single query (Do this using subquery also)
Answer
mysql> SELECT Articles.*, GROUP_CONCAT(COMMENT) AS Comments
    -> FROM Articles, Comments, Users
    -> WHERE Articles.USER_ID = Users.ID
    -> AND Articles.ID = Comments.ARTICLE_ID
    -> AND Users.NAME = 'User3'
    -> GROUP BY ID;
+----+--------+----------------------+-------------+---------+---------------+
| ID | TITLE  | CONTENT              | CATEGORY_ID | USER_ID | Comments      |
+----+--------+----------------------+-------------+---------+---------------+
|  6 | Virat  | Kohli scores Century |           2 |       3 | Wow,Wonderful |
|  7 | Floods | Floods in USA        |           1 |       3 | SAD           |
+----+--------+----------------------+-------------+---------+---------------+
2 rows in set (0.00 sec)

======================

Q4. Write a query to select all articles which do not have any comments (Do using subquery also)

mysql> SELECT Articles.*
    -> FROM Articles
    -> LEFT JOIN Comments
    -> ON Articles.Id = Comments.ARTICLE_ID
    -> WHERE Comments.ID IS NULL;
+----+-------+---------------+-------------+---------+
| ID | TITLE | CONTENT       | CATEGORY_ID | USER_ID |
+----+-------+---------------+-------------+---------+
|  8 | GAME  | game blue red |           3 |       1 |
+----+-------+---------------+-------------+---------+
1 row in set (0.00 sec)

subquery-----------
mysql> SELECT * 
    -> FROM Articles
    -> WHERE Articles.ID NOT IN
    ->     (
    ->     SELECT ARTICLE_ID
    ->     FROM Comments
    ->     );
+----+-------+---------------+-------------+---------+
| ID | TITLE | CONTENT       | CATEGORY_ID | USER_ID |
+----+-------+---------------+-------------+---------+
|  8 | GAME  | game blue red |           3 |       1 |
+----+-------+---------------+-------------+---------+
1 row in set (0.00 sec)
======================================

Q5. Write a query to select article which has maximum comments

mysql> SELECT Articles.*, COUNT(Comments.ARTICLE_ID) AS comments
    -> FROM Articles, Comments
    -> WHERE Articles.ID = Comments.ARTICLE_ID
    -> GROUP BY Comments.ARTICLE_ID
    -> ORDER BY comments DESC
    -> LIMIT 1;
+----+-------------+----------------------------+-------------+---------+----------+
| ID | TITLE       | CONTENT                    | CATEGORY_ID | USER_ID | comments |
+----+-------------+----------------------------+-------------+---------+----------+
|  1 | Joke of day | Lorem IPUSM lOPECV FEEWFVV |           1 |       1 |       3  |
+----+-------------+----------------------------+-------------+---------+----------+

==================================
Q6. Write a query to select article which does not have more than one comment by the same user ( do this using left join and group by )
Answer

mysql> SELECT DISTINCT Articles.*
    -> FROM Articles
    -> JOIN Comments 
    -> ON Articles.ID = Comments.ARTICLE_ID
    -> GROUP BY ARTICLE_ID, Comments.USER_ID
    -> HAVING COUNT(ARTICLE_ID) < 2;
+----+--------------+-------------------------------+-------------+---------+
| ID | TITLE        | CONTENT                       | CATEGORY_ID | USER_ID |
+----+--------------+-------------------------------+-------------+---------+
|  1 | Joke of day  | Lorem IPUSM lOPECV FEEWFVV    |           1 |       1 |
|  2 | Politics     | Modi kejriwal pappu           |           3 |       4 |
|  3 | 1000 rs note | lorme kekroek jjfojf kofkkfok |           2 |       4 |
|  6 | Virat        | Kohli scores Century          |           2 |       3 |
|  7 | Floods       | Floods in USA                 |           1 |       3 |
+----+--------------+-------------------------------+-------------+---------+
5 rows in set (0.00 sec)

using subquery
-------------
mysql> SELECT Articles.*
    -> FROM Articles
    -> WHERE ID IN
    -> (
    ->     SELECT ARTICLE_ID
    ->     FROM Comments
    ->     GROUP BY ARTICLE_ID, USER_ID
    ->     HAVING COUNT(ARTICLE_ID) < 2
    -> );
+----+--------------+-------------------------------+-------------+---------+
| ID | TITLE        | CONTENT                       | CATEGORY_ID | USER_ID |
+----+--------------+-------------------------------+-------------+---------+
|  1 | Joke of day  | Lorem IPUSM lOPECV FEEWFVV    |           1 |       1 |
|  2 | Politics     | Modi kejriwal pappu           |           3 |       4 |
|  3 | 1000 rs note | lorme kekroek jjfojf kofkkfok |           2 |       4 |
|  6 | Virat        | Kohli scores Century          |           2 |       3 |
|  7 | Floods       | Floods in USA                 |           1 |       3 |
+----+--------------+-------------------------------+-------------+---------+
5 rows in set (0.00 sec)

