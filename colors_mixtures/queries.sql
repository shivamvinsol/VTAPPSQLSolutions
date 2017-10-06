mysql> CREATE TABLE colors(
    -> `id` INT NOT NULL,
    -> `name` VARCHAR(20) NOT NULL,
    -> `density` DECIMAL(3,2) NOT NULL
    -> );
Query OK, 0 rows affected (0.40 sec)

mysql> CREATE TABLE mixtures(
    -> `id` INT NOT NULL,
    -> `parent1_id` INT NOT NULL,
    -> `parent2_id` INT NOT NULL,
    -> `mix_id` INT NOT NULL,
    -> `mix_density` DECIMAL(3,2) NOT NULL,
    -> `parent1_perc` INT(2) NOT NULL,
    -> `parent2_perc` INT(2) NOT NULL
    -> );

mysql> INSERT colors
    -> VALUES (10, 'Red', 0.20),
    ->        (11, 'Green', 0.30),
    ->        (12, 'Blue', 0.40),
    ->        (13, 'Yellow', 0.20),
    ->        (14, 'Pink', 0.30),
    ->        (15, 'Cyan', 0.40),
    ->        (16, 'White', 0.28);
Query OK, 7 rows affected (0.10 sec)
Records: 7  Duplicates: 0  Warnings: 0

mysql> INSERT mixtures
    -> VALUES (1, 10, 11, 13, 0.6, 30, 70),
    ->        (2, 10, 12, 14, 0.5, 50, 50),
    ->        (3, 11, 12, 15, 0.75, 40, 60),
    ->        (4, 10, 13, 16, 0.28, 80, 20);
Query OK, 4 rows affected (0.36 sec)
Records: 4  Duplicates: 0  Warnings: 0

------------------------------
1. Find the colors that can be clubbed with 'Red' and also name the resulting color

mysql> SELECT b.name as 'combine with', c.name as 'resulting color'
       FROM colors a, mixtures m, colors b, colors c
       WHERE ((a.id = parent1_id AND b.id = parent2_id AND c.id = mix_id)
       OR (b.id = parent1_id  AND a.id = parent2_id AND c.id = mix_id))
       AND a.name = 'Red';
+--------------+-----------------+
| combine with | resulting color |
+--------------+-----------------+
| Green        | Yellow          |
| Blue         | Pink            |
| Yellow       | White           |
+--------------+-----------------+
3 rows in set (0.00 sec)

---------------------
2. Find mixtures that can be formed without 'Red'

mysql> SELECT c.name
       FROM colors a, mixtures, colors c
       WHERE parent1_id != a.id
       AND parent2_id != a.id
       AND a.name = 'Red'
       AND c.id = mix_id;
+------+
| name |
+------+
| Cyan |
+------+
1 row in set (0.00 sec)
------------------------
3. Find the mixtures that have one common parent

mysql> SELECT a.name AS 'parent name', group_concat(b.name SEPARATOR ' & ') AS 'possible mixture'
       FROM colors a, mixtures, colors b
       WHERE (parent1_id = a.id OR parent2_id = a.id)
       AND b.id = mix_id
       GROUP BY a.name
       ORDER BY COUNT(mix_id) DESC;
+-------------+-----------------------+
| parent name | possible mixture      |
+-------------+-----------------------+
| Red         | Pink & Yellow & White |
| Blue        | Pink & Cyan           |
| Green       | Cyan & Yellow         |
| Yellow      | White                 |
+-------------+-----------------------+
4 rows in set (0.01 sec)
-------------
4. Find parent colors(as a couple) that give mix colors with density higher than the color density originally

mysql> SELECT CONCAT(parent1_id, ' & ',  parent2_id) AS 'parent colors', mix_id, mix_density, density AS 'original density'
       FROM mixtures, colors
       WHERE mix_id = colors.id;
+---------------+--------+-------------+------------------+
| parent colors | mix_id | mix_density | original density |
+---------------+--------+-------------+------------------+
| 10 & 11       |     13 |        0.60 |             0.20 |
| 10 & 12       |     14 |        0.50 |             0.30 |
| 11 & 12       |     15 |        0.75 |             0.40 |
| 10 & 13       |     16 |        0.28 |             0.28 |
+---------------+--------+-------------+------------------+
4 rows in set (0.00 sec)
--------
5. calculate the total amount of color 'Red'(in kgs) needed to make a 1kg mix each for its possible mixtures(yellow,pink..)

mysql> SELECT
           (SELECT COALESCE(SUM(parent1_perc/100), 0)
            FROM colors, mixtures
            WHERE colors.name = 'Red'
            AND parent1_id = colors.id
           ) +
           (SELECT COALESCE(SUM(parent2_perc/100), 0)
            FROM colors, mixtures
            WHERE colors.name = 'Red'
            AND parent2_id = colors.id
           )
      AS 'amount';
+--------+
| amount |
+--------+
| 1.6000 |
+--------+
1 row in set (0.00 sec)

