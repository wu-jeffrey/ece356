# PLAIN
`select firstName, lastName from PlayerInfo inner join GamePlaysPlayers using (playerID) inner join GamePlays using (gameID, playNumber) where playerRole = 'Scorer' and dateTime = (select min(dateTime) from Game inner join GamePlays using (gameID) inner join TeamInfo on (teamIDfor = teamID) where playType = 'Goal' and name = 'Maple Leafs' and season = '20192020');`

```
+-----------+----------+
| firstName | lastName |
+-----------+----------+
| Frederik  | Gauthier |
+-----------+----------+
1 row in set (11.5682 sec)

+-----------+----------+
| firstName | lastName |
+-----------+----------+
| Frederik  | Gauthier |
+-----------+----------+
1 row in set (11.9542 sec)

+-----------+----------+
| firstName | lastName |
+-----------+----------+
| Frederik  | Gauthier |
+-----------+----------+
1 row in set (11.7130 sec)
```

`EXPLAIN select firstName, lastName from PlayerInfo inner join GamePlaysPlayers using (playerID) inner join GamePlays using (gameID, playNumber) where playerRole = 'Scorer' and dateTime = (select min(dateTime) from Game inner join GamePlays using (gameID) inner join TeamInfo on (teamIDfor = teamID) where playType = 'Goal' and name = 'Maple Leafs' and season = '20192020');`

```
+----+-------------+------------------+------------+------+---------------+------+---------+------+---------+----------+--------------------------------------------+
| id | select_type | table            | partitions | type | possible_keys | key  | key_len | ref  | rows    | filtered | Extra                                      |
+----+-------------+------------------+------------+------+---------------+------+---------+------+---------+----------+--------------------------------------------+
|  1 | PRIMARY     | PlayerInfo       | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    3839 |      100 | NULL                                       |
|  1 | PRIMARY     | GamePlaysPlayers | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 6186809 |        1 | Using where; Using join buffer (hash join) |
|  1 | PRIMARY     | GamePlays        | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 4083942 |      0.1 | Using where; Using join buffer (hash join) |
|  2 | SUBQUERY    | TeamInfo         | NULL       | ALL  | NULL          | NULL | NULL    | NULL |      33 |       10 | Using where                                |
|  2 | SUBQUERY    | Game             | NULL       | ALL  | NULL          | NULL | NULL    | NULL |   23477 |       10 | Using where; Using join buffer (hash join) |
|  2 | SUBQUERY    | GamePlays        | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 4083942 |      0.1 | Using where; Using join buffer (hash join) |
+----+-------------+------------------+------------+------+---------------+------+---------+------+---------+----------+--------------------------------------------+
6 rows in set, 1 warning (0.0223 sec)
Note (code 1003): /* select#1 */ select `NHL_Plain`.`PlayerInfo`.`firstName` AS `firstName`,`NHL_Plain`.`PlayerInfo`.`lastName` AS `lastName` from `NHL_Plain`.`PlayerInfo` join `NHL_Plain`.`GamePlaysPlayers` join `NHL_Plain`.`GamePlays` where ((`NHL_Plain`.`GamePlaysPlayers`.`playerID` = `NHL_Plain`.`PlayerInfo`.`playerID`) and (`NHL_Plain`.`GamePlays`.`playNumber` = `NHL_Plain`.`GamePlaysPlayers`.`playNumber`) and (`NHL_Plain`.`GamePlays`.`gameID` = `NHL_Plain`.`GamePlaysPlayers`.`gameID`) and (`NHL_Plain`.`GamePlays`.`dateTime` = (/* select#2 */ select min(`NHL_Plain`.`GamePlays`.`dateTime`) from `NHL_Plain`.`Game` join `NHL_Plain`.`GamePlays` join `NHL_Plain`.`TeamInfo` where ((`NHL_Plain`.`GamePlays`.`gameID` = `NHL_Plain`.`Game`.`gameID`) and (`NHL_Plain`.`GamePlays`.`teamIDfor` = `NHL_Plain`.`TeamInfo`.`teamID`) and (`NHL_Plain`.`TeamInfo`.`name` = 'Maple Leafs') and (`NHL_Plain`.`GamePlays`.`playType` = 'Goal') and (`NHL_Plain`.`Game`.`season` = 20192020)))) and (`NHL_Plain`.`GamePlaysPlayers`.`playerRole` = 'Scorer'))
```

# PK
```
+-----------+----------+
| firstName | lastName |
+-----------+----------+
| Frederik  | Gauthier |
+-----------+----------+
1 row in set (5.8427 sec)

+-----------+----------+
| firstName | lastName |
+-----------+----------+
| Frederik  | Gauthier |
+-----------+----------+
1 row in set (4.3110 sec)

+-----------+----------+
| firstName | lastName |
+-----------+----------+
| Frederik  | Gauthier |
+-----------+----------+
1 row in set (2.8861 sec)

+-----------+----------+
| firstName | lastName |
+-----------+----------+
| Frederik  | Gauthier |
+-----------+----------+
1 row in set (2.9012 sec)

+-----------+----------+
| firstName | lastName |
+-----------+----------+
| Frederik  | Gauthier |
+-----------+----------+
1 row in set (2.9396 sec)
```
```
+----+-------------+------------------+------------+--------+---------------+---------+---------+-----------------------------------------------------+---------+----------+--------------------------------------------+
| id | select_type | table            | partitions | type   | possible_keys | key     | key_len | ref                                                 | rows    | filtered | Extra                                      |
+----+-------------+------------------+------------+--------+---------------+---------+---------+-----------------------------------------------------+---------+----------+--------------------------------------------+
|  1 | PRIMARY     | GamePlays        | NULL       | ALL    | PRIMARY       | NULL    | NULL    | NULL                                                | 4073893 |       10 | Using where                                |
|  1 | PRIMARY     | GamePlaysPlayers | NULL       | ref    | PRIMARY       | PRIMARY | 9       | NHL_PK.GamePlays.gameID,NHL_PK.GamePlays.playNumber |       1 |       10 | Using where                                |
|  1 | PRIMARY     | PlayerInfo       | NULL       | eq_ref | PRIMARY       | PRIMARY | 4       | NHL_PK.GamePlaysPlayers.playerID                    |       1 |      100 | NULL                                       |
|  2 | SUBQUERY    | Game             | NULL       | ALL    | PRIMARY       | NULL    | NULL    | NULL                                                |   23463 |       10 | Using where                                |
|  2 | SUBQUERY    | GamePlays        | NULL       | ref    | PRIMARY       | PRIMARY | 5       | NHL_PK.Game.gameID                                  |      88 |       10 | Using where                                |
|  2 | SUBQUERY    | TeamInfo         | NULL       | ALL    | PRIMARY       | NULL    | NULL    | NULL                                                |      33 |     3.03 | Using where; Using join buffer (hash join) |
+----+-------------+------------------+------------+--------+---------------+---------+---------+-----------------------------------------------------+---------+----------+--------------------------------------------+
```

# FK
```
+-----------+----------+
| firstName | lastName |
+-----------+----------+
| Frederik  | Gauthier |
+-----------+----------+
1 row in set (10.3530 sec)

+-----------+----------+
| firstName | lastName |
+-----------+----------+
| Frederik  | Gauthier |
+-----------+----------+
1 row in set (9.6682 sec)

+-----------+----------+
| firstName | lastName |
+-----------+----------+
| Frederik  | Gauthier |
+-----------+----------+
1 row in set (9.6264 sec)

+-----------+----------+
| firstName | lastName |
+-----------+----------+
| Frederik  | Gauthier |
+-----------+----------+
1 row in set (9.4444 sec)

```

```
+----+-------------+------------------+------------+--------+-------------------+----------+---------+-------------------------------------------------------------------+-------+----------+--------------------------------------------+
| id | select_type | table            | partitions | type   | possible_keys     | key      | key_len | ref                                                               | rows  | filtered | Extra                                      |
+----+-------------+------------------+------------+--------+-------------------+----------+---------+-------------------------------------------------------------------+-------+----------+--------------------------------------------+
|  1 | PRIMARY     | PlayerInfo       | NULL       | ALL    | PRIMARY           | NULL     | NULL    | NULL                                                              |  4389 |      100 | NULL                                       |
|  1 | PRIMARY     | GamePlaysPlayers | NULL       | ref    | PRIMARY,playerID  | playerID | 4       | NHL_FK.PlayerInfo.playerID                                        |   359 |       10 | Using where                                |
|  1 | PRIMARY     | GamePlays        | NULL       | eq_ref | PRIMARY           | PRIMARY  | 9       | NHL_FK.GamePlaysPlayers.gameID,NHL_FK.GamePlaysPlayers.playNumber |     1 |       10 | Using where                                |
|  2 | SUBQUERY    | Game             | NULL       | ALL    | PRIMARY           | NULL     | NULL    | NULL                                                              | 21064 |       10 | Using where                                |
|  2 | SUBQUERY    | GamePlays        | NULL       | ref    | PRIMARY,teamIDfor | PRIMARY  | 5       | NHL_FK.Game.gameID                                                |    90 |       10 | Using where                                |
|  2 | SUBQUERY    | TeamInfo         | NULL       | ALL    | PRIMARY           | NULL     | NULL    | NULL                                                              |    33 |     3.03 | Using where; Using join buffer (hash join) |
+----+-------------+------------------+------------+--------+-------------------+----------+---------+-------------------------------------------------------------------+-------+----------+--------------------------------------------+
```

# NONINDEXED COPY OF FK
```
-----------+----------+
| firstName | lastName |
+-----------+----------+
| Frederik  | Gauthier |
+-----------+----------+
1 row in set (3.0172 sec)

+-----------+----------+
| firstName | lastName |
+-----------+----------+
| Frederik  | Gauthier |
+-----------+----------+
1 row in set (2.9205 sec)

+-----------+----------+
| firstName | lastName |
+-----------+----------+
| Frederik  | Gauthier |
+-----------+----------+
1 row in set (2.9345 sec)

+-----------+----------+
| firstName | lastName |
+-----------+----------+
| Frederik  | Gauthier |
+-----------+----------+
1 row in set (2.9847 sec)
```

```
+----+-------------+------------------+------------+--------+-------------------+---------+---------+-----------------------------------------------------------------+---------+----------+--------------------------------------------+
| id | select_type | table            | partitions | type   | possible_keys     | key     | key_len | ref                                                             | rows    | filtered | Extra                                      |
+----+-------------+------------------+------------+--------+-------------------+---------+---------+-----------------------------------------------------------------+---------+----------+--------------------------------------------+
|  1 | PRIMARY     | GamePlays        | NULL       | ALL    | PRIMARY           | NULL    | NULL    | NULL                                                            | 3902331 |       10 | Using where                                |
|  1 | PRIMARY     | GamePlaysPlayers | NULL       | ref    | PRIMARY,playerID  | PRIMARY | 9       | db356_j387wu.GamePlays.gameID,db356_j387wu.GamePlays.playNumber |       1 |       10 | Using where                                |
|  1 | PRIMARY     | PlayerInfo       | NULL       | eq_ref | PRIMARY           | PRIMARY | 4       | db356_j387wu.GamePlaysPlayers.playerID                          |       1 |      100 | NULL                                       |
|  2 | SUBQUERY    | TeamInfo         | NULL       | ALL    | PRIMARY           | NULL    | NULL    | NULL                                                            |      33 |     3.03 | Using where                                |
|  2 | SUBQUERY    | Game             | NULL       | ALL    | PRIMARY           | NULL    | NULL    | NULL                                                            |   23446 |       10 | Using where; Using join buffer (hash join) |
|  2 | SUBQUERY    | GamePlays        | NULL       | ref    | PRIMARY,teamIDfor | PRIMARY | 5       | db356_j387wu.Game.gameID                                        |      84 |      0.3 | Using where                                |
+----+-------------+------------------+------------+--------+-------------------+---------+---------+-----------------------------------------------------------------+---------+----------+--------------------------------------------+
```
# COMPARE
+----+-------------+------------------+------------+------+---------------+------+---------+------+---------+----------+--------------------------------------------+
| id | select_type | table            | partitions | type | possible_keys | key  | key_len | ref  | rows    | filtered | Extra                                      |
+----+-------------+------------------+------------+------+---------------+------+---------+------+---------+----------+--------------------------------------------+
|  1 | PRIMARY     | PlayerInfo       | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    3839 |      100 | NULL                                       |
|  1 | PRIMARY     | GamePlaysPlayers | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 6186809 |        1 | Using where; Using join buffer (hash join) |
|  1 | PRIMARY     | GamePlays        | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 4083942 |      0.1 | Using where; Using join buffer (hash join) |
|  2 | SUBQUERY    | TeamInfo         | NULL       | ALL  | NULL          | NULL | NULL    | NULL |      33 |       10 | Using where                                |
|  2 | SUBQUERY    | Game             | NULL       | ALL  | NULL          | NULL | NULL    | NULL |   23477 |       10 | Using where; Using join buffer (hash join) |
|  2 | SUBQUERY    | GamePlays        | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 4083942 |      0.1 | Using where; Using join buffer (hash join) |
+----+-------------+------------------+------------+------+---------------+------+---------+------+---------+----------+--------------------------------------------+
+----+-------------+------------------+------------+--------+---------------+---------+---------+-----------------------------------------------------+---------+----------+--------------------------------------------+
| id | select_type | table            | partitions | type   | possible_keys | key     | key_len | ref                                                 | rows    | filtered | Extra                                      |
+----+-------------+------------------+------------+--------+---------------+---------+---------+-----------------------------------------------------+---------+----------+--------------------------------------------+
|  1 | PRIMARY     | GamePlays        | NULL       | ALL    | PRIMARY       | NULL    | NULL    | NULL                                                | 4073893 |       10 | Using where                                |
|  1 | PRIMARY     | GamePlaysPlayers | NULL       | ref    | PRIMARY       | PRIMARY | 9       | NHL_PK.GamePlays.gameID,NHL_PK.GamePlays.playNumber |       1 |       10 | Using where                                |
|  1 | PRIMARY     | PlayerInfo       | NULL       | eq_ref | PRIMARY       | PRIMARY | 4       | NHL_PK.GamePlaysPlayers.playerID                    |       1 |      100 | NULL                                       |
|  2 | SUBQUERY    | Game             | NULL       | ALL    | PRIMARY       | NULL    | NULL    | NULL                                                |   23463 |       10 | Using where                                |
|  2 | SUBQUERY    | GamePlays        | NULL       | ref    | PRIMARY       | PRIMARY | 5       | NHL_PK.Game.gameID                                  |      88 |       10 | Using where                                |
|  2 | SUBQUERY    | TeamInfo         | NULL       | ALL    | PRIMARY       | NULL    | NULL    | NULL                                                |      33 |     3.03 | Using where; Using join buffer (hash join) |
+----+-------------+------------------+------------+--------+---------------+---------+---------+-----------------------------------------------------+---------+----------+--------------------------------------------+
+----+-------------+------------------+------------+--------+-------------------+----------+---------+-------------------------------------------------------------------+-------+----------+--------------------------------------------+
| id | select_type | table            | partitions | type   | possible_keys     | key      | key_len | ref                                                               | rows  | filtered | Extra                                      |
+----+-------------+------------------+------------+--------+-------------------+----------+---------+-------------------------------------------------------------------+-------+----------+--------------------------------------------+
|  1 | PRIMARY     | PlayerInfo       | NULL       | ALL    | PRIMARY           | NULL     | NULL    | NULL                                                              |  4389 |      100 | NULL                                       |
|  1 | PRIMARY     | GamePlaysPlayers | NULL       | ref    | PRIMARY,playerID  | playerID | 4       | NHL_FK.PlayerInfo.playerID                                        |   359 |       10 | Using where                                |
|  1 | PRIMARY     | GamePlays        | NULL       | eq_ref | PRIMARY           | PRIMARY  | 9       | NHL_FK.GamePlaysPlayers.gameID,NHL_FK.GamePlaysPlayers.playNumber |     1 |       10 | Using where                                |
|  2 | SUBQUERY    | Game             | NULL       | ALL    | PRIMARY           | NULL     | NULL    | NULL                                                              | 21064 |       10 | Using where                                |
|  2 | SUBQUERY    | GamePlays        | NULL       | ref    | PRIMARY,teamIDfor | PRIMARY  | 5       | NHL_FK.Game.gameID                                                |    90 |       10 | Using where                                |
|  2 | SUBQUERY    | TeamInfo         | NULL       | ALL    | PRIMARY           | NULL     | NULL    | NULL                                                              |    33 |     3.03 | Using where; Using join buffer (hash join) |
+----+-------------+------------------+------------+--------+-------------------+----------+---------+-------------------------------------------------------------------+-------+----------+--------------------------------------------+

----------- MY DB COPY

+----+-------------+------------------+------------+--------+-------------------+---------+---------+-----------------------------------------------------------------+---------+----------+--------------------------------------------+
| id | select_type | table            | partitions | type   | possible_keys     | key     | key_len | ref                                                             | rows    | filtered | Extra                                      |
+----+-------------+------------------+------------+--------+-------------------+---------+---------+-----------------------------------------------------------------+---------+----------+--------------------------------------------+
|  1 | PRIMARY     | GamePlays        | NULL       | ALL    | PRIMARY           | NULL    | NULL    | NULL                                                            | 3902331 |       10 | Using where                                |
|  1 | PRIMARY     | GamePlaysPlayers | NULL       | ref    | PRIMARY,playerID  | PRIMARY | 9       | db356_j387wu.GamePlays.gameID,db356_j387wu.GamePlays.playNumber |       1 |       10 | Using where                                |
|  1 | PRIMARY     | PlayerInfo       | NULL       | eq_ref | PRIMARY           | PRIMARY | 4       | db356_j387wu.GamePlaysPlayers.playerID                          |       1 |      100 | NULL                                       |
|  2 | SUBQUERY    | Game             | NULL       | ALL    | PRIMARY           | NULL    | NULL    | NULL                                                            |   23446 |       10 | Using where                                |
|  2 | SUBQUERY    | GamePlays        | NULL       | ref    | PRIMARY,teamIDfor | PRIMARY | 5       | db356_j387wu.Game.gameID                                        |      84 |       10 | Using where                                |
|  2 | SUBQUERY    | TeamInfo         | NULL       | ALL    | PRIMARY           | NULL    | NULL    | NULL                                                            |      33 |     3.03 | Using where; Using join buffer (hash join) |
+----+-------------+------------------+------------+--------+-------------------+---------+---------+-----------------------------------------------------------------+---------+----------+--------------------------------------------+
+----+-------------+------------------+------------+--------+-------------------+---------+---------+-----------------------------------------------------------------+---------+----------+--------------------------------------------+
| id | select_type | table            | partitions | type   | possible_keys     | key     | key_len | ref                                                             | rows    | filtered | Extra                                      |
+----+-------------+------------------+------------+--------+-------------------+---------+---------+-----------------------------------------------------------------+---------+----------+--------------------------------------------+
|  1 | PRIMARY     | GamePlays        | NULL       | ALL    | PRIMARY           | NULL    | NULL    | NULL                                                            | 3902331 |       10 | Using where                                |
|  1 | PRIMARY     | GamePlaysPlayers | NULL       | ref    | PRIMARY,playerID  | PRIMARY | 9       | db356_j387wu.GamePlays.gameID,db356_j387wu.GamePlays.playNumber |       1 |       10 | Using where                                |
|  1 | PRIMARY     | PlayerInfo       | NULL       | eq_ref | PRIMARY           | PRIMARY | 4       | db356_j387wu.GamePlaysPlayers.playerID                          |       1 |      100 | NULL                                       |
|  2 | SUBQUERY    | TeamInfo         | NULL       | ALL    | PRIMARY           | NULL    | NULL    | NULL                                                            |      33 |     3.03 | Using where                                |
|  2 | SUBQUERY    | Game             | NULL       | ALL    | PRIMARY           | NULL    | NULL    | NULL                                                            |   23446 |       10 | Using where; Using join buffer (hash join) |
|  2 | SUBQUERY    | GamePlays        | NULL       | ref    | PRIMARY,teamIDfor | PRIMARY | 5       | db356_j387wu.Game.gameID                                        |      84 |      0.3 | Using where                                |
+----+-------------+------------------+------------+--------+-------------------+---------+---------+-----------------------------------------------------------------+---------+----------+--------------------------------------------+

AFTER USING BOTH INDEXES

+-----------+----------+
| firstName | lastName |
+-----------+----------+
| Frederik  | Gauthier |
+-----------+----------+
1 row in set (2.5982 sec)

+-----------+----------+
| firstName | lastName |
+-----------+----------+
| Frederik  | Gauthier |
+-----------+----------+
1 row in set (2.6694 sec)

+-----------+----------+
| firstName | lastName |
+-----------+----------+
| Frederik  | Gauthier |
+-----------+----------+
1 row in set (2.6769 sec)
