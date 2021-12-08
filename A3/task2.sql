CREATE TABLE Game (
  gameID decimal(10,0),
  gameType char(1),
  PRIMARY KEY (gameID)
);

CREATE TABLE TeamInfo (
  teamID decimal(10,0),

  PRIMARY KEY (teamID)
);

CREATE TABLE PlayerInfo (
  playerID decimal(10,0),

  PRIMARY KEY (playerID)
);

CREATE TABLE GamePlays (
  playNumber decimal(10,0),
  gameID decimal(10,0),
  dateTime datetime,
  period decimal(1,0),
  periodType char(8),
  periodTime int,
  periodTimeRemaining char(4),
  goalsHome int,
  goalsAway int,
  description varChar(255),
  type varChar(25),

  PRIMARY KEY (playNumber, gameID),
  FOREIGN KEY (gameID) REFERENCES Game(gameID)
);

CREATE TABLE GameChallenges (
  playNumber decimal(10,0),
  gameID decimal(10,0),
  teamIDFor decimal(10,0),
  teamIDAgainst decimal(10,0),

  PRIMARY KEY (playNumber, gameID),
  FOREIGN KEY (gameID) REFERENCES Game(gameID),
  FOREIGN KEY (playNumber) REFERENCES GamePlays(playNumber),
  FOREIGN KEY (teamIDFor) REFERENCES TeamInfo(teamID),
  FOREIGN KEY (teamIDAgainst) REFERENCES TeamInfo(teamID)
);

CREATE TABLE ExecutablePlays (
  executeablePlayID decimal(10,0),
  playNumber decimal(10,0),
  gameID decimal(10,0),
  coordinates_x decimal(10,0),
  coordinates_y decimal(10,0),
  teamIDFor decimal(10,0),
  teamIDAgainst decimal(10,0),

  PRIMARY KEY (executeablePlayID),
  FOREIGN KEY (gameID) REFERENCES Game(gameID),
  FOREIGN KEY (playNumber) REFERENCES GamePlays(playNumber),
  FOREIGN KEY (teamIDFor) REFERENCES TeamInfo(teamID),
  FOREIGN KEY (teamIDAgainst) REFERENCES TeamInfo(teamID)
);

CREATE TABLE GamePenalties (
  executeablePlayID decimal(10,0),
  penaltySeverity char(15),
  penaltyMinutes decimal(2,0),
  type varChar(40),

  PRIMARY KEY (executeablePlayID),
  FOREIGN KEY (executeablePlayID) REFERENCES ExecutablePlays(executeablePlayID)
);

CREATE TABLE GameShots (
  executeablePlayID decimal(10,0),
  type varChar(40),

  PRIMARY KEY (executeablePlayID),
  FOREIGN KEY (executeablePlayID) REFERENCES ExecutablePlays(executeablePlayID)
);

CREATE TABLE GameGoals (
  executeablePlayID decimal(10,0),
  strength         char(12),
  gameWinningGoal  char(5),
  emptyNet         char(5),
  type varChar(40),

  PRIMARY KEY (executeablePlayID),
  FOREIGN KEY (executeablePlayID) REFERENCES ExecutablePlays(executeablePlayID)
);

CREATE TABLE Executes (
  playerID decimal(10,0),
  executeablePlayID decimal(10,0),
  playerRole varChar(40),

  FOREIGN KEY (playerID) REFERENCES PlayerInfo(playerID),
  FOREIGN KEY (executeablePlayID) REFERENCES ExecutablePlays(executeablePlayID)
);
