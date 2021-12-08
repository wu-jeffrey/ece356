WITH
  LfGl AS (
    SELECT GamePlays.gameID, GamePlays.playNumber, GamePlays.dateTime
    FROM GamePlays
    WHERE (gameID) IN (
      SELECT gameID FROM Game WHERE season = '20192020'
      )
      AND teamIDfor = (
        SELECT teamID FROM TeamInfo WHERE name = 'Maple Leafs'
      )
      AND playType = 'Goal'
    ),

  FstLfGl AS (
    SELECT LfGl.gameID, LfGl.playNumber
    FROM LfGl
    WHERE dateTime = (
      SELECT min(dateTime) FROM LfGl
    )
  )

  SELECT firstName, lastName
  FROM PlayerInfo
  WHERE playerID = (
    SELECT playerID
    FROM (GamePlaysPlayers AS GPP) INNER JOIN FstLfGl ON (FstLfGl.gameID = GPP.gameID AND FstLfGl.playNumber = GPP.playNumber)
    WHERE GPP.playerRole = 'Scorer'
  );
