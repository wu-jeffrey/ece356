-- Create Tables
CREATE TABLE BetterGamePlays LIKE GamePlays;
CREATE TABLE BetterGameGoals LIKE GameGoals;

-- Add Columns
ALTER TABLE BetterGamePlays ADD COLUMN playNumber decimal(10,0) FIRST;

ALTER TABLE BetterGameGoals ADD COLUMN playNumber decimal(10,0) FIRST;
ALTER TABLE BetterGameGoals ADD COLUMN gameID decimal(10,0) AFTER playNumber;

-- Drop compound playID column
ALTER TABLE BetterGamePlays DROP COLUMN playID;
ALTER TABLE BetterGameGoals DROP COLUMN playID;

-- Backfill tables with data from old tables
INSERT INTO BetterGamePlays (playNumber, gameID, teamIDfor, teamIDagainst, playType, secondaryType, x, y, period, periodType, periodTime, periodTimeRemaining, dateTime, goalsAway, goalsHome, description)
SELECT substring_index(playID, '_', -1), gameID, teamIDfor, teamIDagainst, playType, secondaryType, x, y, period, periodType, periodTime, periodTimeRemaining, dateTime, goalsAway, goalsHome, description
FROM GamePlays;

INSERT INTO BetterGameGoals (playNumber, gameID, strength, gameWinningGoal, emptyNet)
SELECT substring_index(playID, '_', -1), substring_index(playID, '_', 1), strength, gameWinningGoal, emptyNet
FROM GameGoals AS GG;

-- Drop old tables
DROP TABLE IF EXISTS GamePlays;
DROP TABLE IF EXISTS GameGoals;

-- Create Views
CREATE VIEW GamePlays AS SELECT CONCAT(gameID, '_', playNumber) AS playID, gameID, teamIDfor, teamIDagainst, playType, secondaryType, x, y, period, periodType, periodTime, periodTimeRemaining, dateTime, goalsAway, goalsHome, description from BetterGamePlays;
CREATE VIEW GameGoals AS SELECT CONCAT(gameID, '_', playNumber) AS playID, strength, gameWinningGoal, emptyNet from BetterGameGoals;

