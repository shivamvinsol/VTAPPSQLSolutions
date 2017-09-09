// creating backup
vin@vin-HP-ProBook-4530s:~/Documents/tasks/SQL/Exercise4$ mysqldump -u root -p DVDRentals > 09112017backup.sql
Enter password: 
-------
// using backup to restore data
vin@vin-HP-ProBook-4530s:~/Documents/tasks/SQL/Exercise4$ mysql -u root -p restored < 09112017backup.sql
Enter password: 
---------
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| DVDRentals         |
| VTAPPSQLSolutions  |
| article_mgmnt      |
| mysql              |
| performance_schema |
| restored           |
| test               |
| vtapp              |
+--------------------+
9 rows in set (0.00 sec)

mysql> use restored;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> show tables;
+--------------------+
| Tables_in_restored |
+--------------------+
| AuthorBook         |
| Authors            |
| Books              |
| CDs                |
| Customers          |
| InStock            |
| MovieTypes         |
| Orders             |
| Ratings            |
| Roles              |
| Status             |
| Studios            |
| mytbl              |
| mytbl2             |
+--------------------+
14 rows in set (0.00 sec)

