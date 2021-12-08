-- FIND THE PLAYER WHO SCORED THE FIRST GOAL FOR THE LEAFS IN THE 2019-2020 SEASON
select firstName, lastName from PlayerInfo
  inner join GamePlaysPlayers using (playerID)
  inner join GamePlays using (gameID, playNumber)
where playerRole = 'Scorer' and
  dateTime = (
    select min(dateTime) from Game
      inner join GamePlays using (gameID)
      inner join TeamInfo on (teamIDfor = teamID)
    where playType = 'Goal' and
      name = 'Maple Leafs' and
      season = '20192020'
  );

EXPLAIN select firstName, lastName from PlayerInfo inner join GamePlaysPlayers using (playerID) inner join GamePlays using (gameID, playNumber) where playerRole = 'Scorer' and dateTime = (select min(dateTime) from Game inner join GamePlays using (gameID) inner join TeamInfo on (teamIDfor = teamID) where playType = 'Goal' and name = 'Maple Leafs' and season = '20192020');

RESULT:
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
6 rows in set, 1 warning (0.0337 sec)
Note (code 1003): /* select#1 */ select `db356_j387wu`.`PlayerInfo`.`firstName` AS `firstName`,`db356_j387wu`.`PlayerInfo`.`lastName` AS `lastName` from `db356_j387wu`.`PlayerInfo` join `db356_j387wu`.`GamePlaysPlayers` join `db356_j387wu`.`GamePlays` where ((`db356_j387wu`.`PlayerInfo`.`playerID` = `db356_j387wu`.`GamePlaysPlayers`.`playerID`) and (`db356_j387wu`.`GamePlaysPlayers`.`playNumber` = `db356_j387wu`.`GamePlays`.`playNumber`) and (`db356_j387wu`.`GamePlaysPlayers`.`gameID` = `db356_j387wu`.`GamePlays`.`gameID`) and (`db356_j387wu`.`GamePlays`.`dateTime` = (/* select#2 */ select min(`db356_j387wu`.`GamePlays`.`dateTime`) from `db356_j387wu`.`Game` join `db356_j387wu`.`GamePlays` join `db356_j387wu`.`TeamInfo` where ((`db356_j387wu`.`GamePlays`.`gameID` = `db356_j387wu`.`Game`.`gameID`) and (`db356_j387wu`.`TeamInfo`.`teamID` = `db356_j387wu`.`GamePlays`.`teamIDfor`) and (`db356_j387wu`.`TeamInfo`.`name` = 'Maple Leafs') and (`db356_j387wu`.`GamePlays`.`playType` = 'Goal') and (`db356_j387wu`.`Game`.`season` = 20192020)))) and (`db356_j387wu`.`GamePlaysPlayers`.`playerRole` = 'Scorer'))


EXPLAIN ANALYZE select firstName, lastName from PlayerInfo inner join GamePlaysPlayers using (playerID) inner join GamePlays using (gameID, playNumber) where playerRole = 'Scorer' and dateTime = (select min(dateTime) from Game inner join GamePlays using (gameID) inner join TeamInfo on (teamIDfor = teamID) where playType = 'Goal' and name = 'Maple Leafs' and season = '20192020');

| -> Nested loop inner join  (cost=971032.78 rows=76227) (actual time=3849.511..4136.529 rows=1 loops=1)
    -> Nested loop inner join  (cost=888611.94 rows=76227) (actual time=3843.628..4130.645 rows=1 loops=1)
        -> Filter: (GamePlays.`dateTime` = (select #2))  (cost=422168.34 rows=390233) (actual time=3822.395..4109.382 rows=1 loops=1)
            -> Table scan on GamePlays  (cost=422168.34 rows=3902331) (actual time=96.673..2269.197 rows=4216630 loops=1)
            -> Select #2 (subquery in condition; run only once)
                -> Aggregate: min(GamePlays.`dateTime`)  (actual time=530.251..530.251 rows=1 loops=1)
                    -> Inner hash join (TeamInfo.teamID = GamePlays.teamIDfor)  (cost=27284.79 rows=601) (actual time=530.175..530.217 rows=253 loops=1)
                        -> Filter: (TeamInfo.`name` = 'Maple Leafs')  (cost=0.00 rows=1) (actual time=14.144..14.154 rows=1 loops=1)
                            -> Table scan on TeamInfo  (cost=0.00 rows=33) (actual time=14.138..14.146 rows=33 loops=1)
                        -> Hash
                            -> Nested loop inner join  (cost=25299.04 rows=19818) (actual time=186.470..512.975 rows=7361 loops=1)
                                -> Filter: (Game.season = 20192020)  (cost=2696.80 rows=2345) (actual time=172.602..173.512 rows=1215 loops=1)
                                    -> Table scan on Game  (cost=2696.80 rows=23446) (actual time=41.144..168.903 rows=23735 loops=1)
                                -> Filter: (GamePlays.playType = 'Goal')  (cost=1.19 rows=8) (actual time=0.092..0.279 rows=6 loops=1215)
                                    -> Index lookup on GamePlays using PRIMARY (gameID=Game.gameID)  (cost=1.19 rows=85) (actual time=0.063..0.242 rows=322 loops=1215)
        -> Filter: (GamePlaysPlayers.playerRole = 'Scorer')  (cost=1.00 rows=0) (actual time=21.231..21.260 rows=1 loops=1)
            -> Index lookup on GamePlaysPlayers using PRIMARY (gameID=GamePlays.gameID, playNumber=GamePlays.playNumber)  (cost=1.00 rows=2) (actual time=21.226..21.254 rows=4 loops=1)
    -> Single-row index lookup on PlayerInfo using PRIMARY (playerID=GamePlaysPlayers.playerID)  (cost=0.98 rows=1) (actual time=5.882..5.882 rows=1 loops=1)
 |
