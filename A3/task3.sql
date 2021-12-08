CREATE TABLE PeriodData (
  periodDataID decimal(10,0),
  periodNumber decimal(1,0),
  gameType char(1),
  periodType char(8),

  PRIMARY KEY (periodDataID)
  CONSTRAINT UC_PeriodType UNIQUE (periodNumber, gameType, periodType)
);

ALTER TABLE GamePlays ADD COLUMN periodDataID;
ALTER TABLE GamePlays ADD FOREIGN KEY (periodDataID) REFERENCES PeriodData(periodDataID);

-- Should backfill data here but it wasn't mentioned in the instructions

ALTER TABLE GamePlays DROP COLUMN period;
ALTER TABLE GamePlays DROP COLUMN periodType;
