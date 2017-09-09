Rows in EXPLAIN
--------
id ->   Identifier for SELECT statement being analyzed, 1 for each row, for Select without subqueries.
select_type -> Type of SELECT statement, SIMPLE for statement with no subqueries, MATERIALIZED for complex queries
table -> Table being analyzed
type -> method used to match rows of tables. ALL means combination of all rows tested
possible_keys -> any indexes that can be used to find rows. NULL for no indexes
key -> indexes that are used to find rows
key_len -> length of key used to find rows
ref -> columns used with inddex to find rows
rows -> number of rows that willv be searched for query
extra -> additional information about the query, eg Using index, using filesort, using where
----------------------   

mysql> EXPLAIN SELECT * FROM comments WHERE user_id = 41;

+-------------+------+---------------+---------+-------+---------+-------------+
| select_type | type | key | key_len | ref | rows | Extra |
+-------------+------+---------------+---------+-------+---------+-------------+
| SIMPLE | ALL | NULL | NULL | NULL | 1002345 | Using where |
+-------------+------+---------------+---------+-------+---------+-------------+

mysql> SELECT count(id) FROM comments;

+-----------+
| count(id) |
+-----------+
| 1002345 |
+-----------+

2.1 The value under 'rows' column in the output of EXPLAIN query and SELECT query after it are same. What does it mean?
answer -> It means SQL will check ALL rows to find out filtered rows. This make the query slow in nature

2.2 Is the SELECT query optimal? If no, how do we optimize it?
answer-> NO, the query is NOT optimized.
     We can use INDEXING to speed up the query.
     Therefore, Indexing the user_id field will speed up the query
-------------------------------------------------
mysql> SELECT * FROM comments LIMIT 5;

+----+------------------+----------------+---------+
| id | commentable_type | commentable_id | user_id |
+----+------------------+----------------+---------+
| 1  + Article 		| 1 		 |	 1 |
+----+------------------+----------------+---------+
| 2  + Photo 		| 1		 |	 1 |
+----+------------------+----------------+---------+
| 3  + Photo		| 2		 |	 2 |
+----+------------------+----------------+---------+
| 4  + Photo 		| 2		 |	 2 |
+----+------------------+----------------+---------+
| 5  + Article 		| 1		 |	 2 |
+----+------------------+----------------+---------+

When we need to fetch comments of a user on a particular Article or Photo we form a query like:

mysql> EXPLAIN SELECT * FROM comments WHERE commentable_id = 1 AND commentable_type = 'Article' AND user_id = 1;

+-------------+------+-----+---------+-----+---------+-------------+
| select_type | type | key | key_len | ref | rows    | Extra       |
+-------------+------+---------------+---------+-------+-----------+
| SIMPLE      | ALL  |NULL | NULL    | NULL| 1000025 | Using where |
+-------------+------+-----+---------+-----+---------+-------------+

It seems that we do not have any index on any of the columns. And whole comments table is scanned to fetch those comments.

3.1 We decide to index columns in comments table to optimize the SELECT query. What column(s) will you index in which order? Ask the exercise creator for a hint if you are confused.

answer -> We should INDEX the user_id, to find comments of a user in articles/photos.
---------------------------------------------------------------------------------------------
4.1 EXPLAIN a SELECT query against one of your databases which employs an INNER JOIN between two tables. What does the output look like? What does the values under different columns mean? Do you get only one row in EXPLAIN's output?
answer


mysql> EXPLAIN 
    -> SELECT Location 
    -> FROM SANDWICHES AS S
    -> INNER JOIN TASTES AS T
    -> ON S.Filling = T.Filling
    -> AND T.Name = 'Jones'
    -> ;
+----+-------------+-------+------+---------------+------+---------+------+------+----------------------------------------------------+
| id | select_type | table | type | possible_keys | key  | key_len | ref  | rows | Extra                                              |
+----+-------------+-------+------+---------------+------+---------+------+------+----------------------------------------------------+
|  1 | SIMPLE      | T     | ALL  | NULL          | NULL | NULL    | NULL |    7 | Using where                                        |
|  1 | SIMPLE      | S     | ALL  | NULL          | NULL | NULL    | NULL |   10 | Using where; Using join buffer (Block Nested Loop) |
+----+-------------+-------+------+---------------+------+---------+------+------+----------------------------------------------------+
2 rows in set (0.00 sec)

id = 1, identifier for select statement
select_Type = SIMPLE , simple query, without any subqueries
table = s,t , Two tables (S,T) used by the query
possible_kes = NULL, no key can be used as INDEX
key = NULL, no key used as INDEX
key_len = NULL, no key used, therefore length = 0
ref = NULL
rows = 7,10 = rows scanned by the query
Extra = uses where clause


4.2 Form the same select query in above question using a subquery instead of a JOIN. What does the EXPLAIN output look like now? Which query is better and why?
answer
mysql> EXPLAIN
    -> SELECT Location
    -> FROM SANDWICHES AS S
    -> WHERE Filling 
    -> IN (
    ->    SELECT Filling 
    ->    FROM TASTES
    ->    WHERE Name = 'Jones'
    ->    );
+----+--------------+-------------+------+---------------+------+---------+------+------+----------------------------------------------------+
| id | select_type  | table       | type | possible_keys | key  | key_len | ref  | rows | Extra                                              |
+----+--------------+-------------+------+---------------+------+---------+------+------+----------------------------------------------------+
|  1 | SIMPLE       | <subquery2> | ALL  | NULL          | NULL | NULL    | NULL | NULL | NULL                                               |
|  1 | SIMPLE       | S           | ALL  | NULL          | NULL | NULL    | NULL |   10 | Using where; Using join buffer (Block Nested Loop) |
|  2 | MATERIALIZED | TASTES      | ALL  | NULL          | NULL | NULL    | NULL |    7 | Using where                                        |
+----+--------------+-------------+------+---------------+------+---------+------+------+----------------------------------------------------+
3 rows in set (0.00 sec)

JOIN is better than SUBQUERY because it scans less rows to find the result, is quicker in nature.
