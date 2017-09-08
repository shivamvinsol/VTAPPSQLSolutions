mysql> CREATE DATABASE vtapp;
Query OK, 1 row affected (0.07 sec)

mysql> CREATE USER 'vtapp_user'@'localhost'
    -> IDENTIFIED BY 'vtapppass';
Query OK, 0 rows affected (0.00 sec)

mysql> GRANT ALL PRIVILEGES
    -> ON vtapp.*
    -> TO 'vtapp_user'@'localhost'
    -> IDENTIFIED BY 'vtapppass'
    -> WITH GRANT OPTION;
Query OK, 0 rows affected (0.01 sec)

mysql> show grants for vtapp_user@localhost;
+-------------------------------------------------------------------------------------------------------------------+
| Grants for vtapp_user@localhost                                                                                   |
+-------------------------------------------------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO 'vtapp_user'@'localhost' IDENTIFIED BY PASSWORD '*04B4D8E540CADFB1D852DB7542B14B160FCF33B4' |
| GRANT ALL PRIVILEGES ON `vtapp`.* TO 'vtapp_user'@'localhost' WITH GRANT OPTION                                   |
+-------------------------------------------------------------------------------------------------------------------+
2 rows in set (0.00 sec)

