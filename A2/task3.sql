-- ADD PK to Game
ALTER TABLE Game ADD CONSTRAINT PK_Game PRIMARY KEY (gameID);

-- ADD PK, FK to BGP
ALTER TABLE BetterGamePlays ADD CONSTRAINT PK_BetterGamePlays PRIMARY KEY (playNumber, gameID);
ALTER TABLE BetterGamePlays ADD FOREIGN KEY (gameID) REFERENCES Game(gameID);

-- ADD PK, FK to BGG
ALTER TABLE BetterGameGoals ADD FOREIGN KEY (playNumber, gameID) REFERENCES BetterGamePlays(playNumber, gameID);
