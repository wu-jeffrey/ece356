CREATE INDEX idx_play_type ON GamePlays (playType);
CREATE INDEX idx_game_season ON Game (season);


DROP INDEX idx_play_type ON GamePlays;
DROP INDEX idx_game_season ON Game;

ANALYZE TABLE TeamInfo DROP HISTOGRAM ON name;
