use DAT601;
go
-- DDL Making tables and indexes and CHECKS
drop procedure if exists MakeTables;
go
create procedure MakeTables 
as
begin
    DECLARE @ZoneIDtbl TABLE(zoneID INTEGER);
	DECLARE @ContractIDtbl TABLE(ID INTEGER);

	DROP TABLE IF EXISTS tblSubDatabox;
	DROP TABLE IF EXISTS tblSubscription;
	DROP TABLE IF EXISTS tblContractZone;
	DROP TABLE IF EXISTS tblDataBoxZone;
    DROP TABLE IF EXISTS tblZoneBoundaryMarker;
	DROP TABLE IF EXISTS tblZone;
	DROP TABLE IF EXISTS tblContract;
	DROP TABLE IF EXISTS tblDATA;
    DROP TABLE IF EXISTS tblDATABOX;
	DROP TABLE IF EXISTS tblSalesPerson;
	
	CREATE TABLE tblDATABOX(
		DBNUM INTEGER NOT NULL PRIMARY KEY,
		Lat DECIMAL(20,10) NOT NULL DEFAULT 0.0 ,
		Long DECIMAL(20,10) NOT NULL DEFAULT 0.0
	);
 

	
	CREATE TABLE tblDATA(
		DBNUM INTEGER NOT NULL,
		DATACOUNT INTEGER NOT NULL,
		Temp DECIMAL(5,2) NOT NULL DEFAULT 0.0,
		Hum  DECIMAL(5,2) NOT NULL DEFAULT 0.0,
		Lat  DECIMAL(5,2) NOT NULL DEFAULT 0.0,
		Long DECIMAL(5,2) NOT NULL DEFAULT 0.0,
		PRIMARY KEY(DBNUM,DATACOUNT),
		FOREIGN KEY(DBNUM) REFERENCES tblDATABOX(DBNUM)
	);
	 
	DELETE tblDATA;
	DELETE tblDATABOX;

	INSERT INTO tblDATABOX (DBNUM,Lat, Long)
	VALUES (1,0.1,2.0), (2,100.1,2.0), (3,0.1,200.0);

	INSERT INTO tblDATA (DBNUM,DATACOUNT,Temp, Hum, Lat, Long)
	VALUES (1,1, 99.0, 99.0 , 0.1,2.0), 
		   (1,2, 99.0, 99.0 , 0.1,2.0),
		   (2,1, 99.0, 99.0 , 0.1,2.0),
		   (2,2, 99.0, 99.0 , 0.1,2.0);
	
	CREATE TABLE tblSalesPerson(
	   ID INTEGER IDENTITY PRIMARY KEY, 
	   Name VARCHAR(255),
	   MAXDISCOUNT REAL CHECK (MAXDISCOUNT >= 0.0 AND MAXDISCOUNT <= 100.0)
	);

	INSERT INTO tblSalesPerson VALUES ( 'Thomas',0.3), ( 'Sharon',0.3);

	CREATE TABLE tblSubScription(
	  SubID INTEGER IDENTITY PRIMARY KEY,
	  SalesID INTEGER,
	  SubFirstName VARCHAR(30),
	  SubSecondName VARCHAR(30),
	  SubscriberAddress VARCHAR(255),
	  Subphone VARCHAR(12),
	  Discount REAL CHECK ( Discount >= 0.0 and Discount <= 100.00),
	  FOREIGN KEY(SalesID) REFERENCES tblSalesPerson(ID)
	);

	CREATE TABLE tblSubDatabox(
	   SubID INTEGER,
	   DataBID INTEGER,
	   PRIMARY KEY(SubID, DataBID),
	   Foreign key(SubID) references tblSubScription(SubID),
	   Foreign key(DataBID) references tblDatabox(DBNUM)
	);
	CREATE TABLE tblZone(
	   ID INTEGER IDENTITY PRIMARY KEY,
	   ZoneName VARCHAR(25) NOT NULL UNIQUE
	);


	DROP TABLE IF EXISTS tblZoneBoundaryMarker;
	CREATE TABLE tblZoneBoundaryMarker(
	  ID INTEGER,
	  Long DECIMAL(9,6),Lat DECIMAL (8,6),
	  PRIMARY KEY (ID, Lat, Long),
      FOREIGN KEY(ID) REFERENCES tblZone(ID)
	);


	INSERT INTO tblZone
	OUTPUT INSERTED.ID INTO @ZoneIDtbl
	VALUES ('Nelson Central');
	
	DELETE FROM @ZoneIDtbl;
	
	INSERT INTO tblZone
	OUTPUT INSERTED.ID INTO @ZoneIDtbl
	VALUES ('Nelson South');
	
	DROP TABLE IF EXISTS tblOrganisation;

	CREATE TABLE tblOrganisation(
	   [Name] VARCHAR(20) PRIMARY KEY ,
	    Size Integer,
		ContactName VARCHAR(20),
		ContactPhone VARCHAR(20)
	)
	INSERT INTO tblOrganisation
	VALUES( 'Nelson City Council', 10000,'CEO', '64-3-1234556');

	DROP TABLE IF EXISTS tblContract;

	CREATE TABLE tblContract(
		ID INTEGER IDENTITY PRIMARY KEY,
		ContractingOrg VARCHAR(20),
		FOREIGN KEY (ContractingOrg) REFERENCES tblOrganisation([Name]) 
	);
	INSERT INTO tblContract 
	OUTPUT INSERTED.ID INTO @ContractIDtbl
	VALUES ('Nelson City Council');

	DROP TABLE IF EXISTS tblDataboxZone;
	CREATE TABLE tblDataboxZone(
	    DataBoxID INTEGER, ZoneID INTEGER,
		PRIMARY KEY(DataBoxID, ZoneID),
		FOREIGN KEY(DataBoxID) REFERENCES tblDataBox(DBNum),
		FOREIGN KEY(ZoneID) REFERENCES tblZone(ID)
	);
	INSERT INTO tblDataboxZone
	VALUES (1,1),(2,1);
	
	DROP TABLE IF EXISTS tblContractZone;

	CREATE TABLE tblContractZone(
	   ContractID INTEGER, ZoneID INTEGER,
	   PRIMARY KEY (ZoneID, ContractID),
	   FOREIGN KEY(ZoneID) REFERENCES tblZone(ID),
	   FOREIGN KEY ( ContractID ) REFERENCES tblContract(ID)
	);
	
	
end;
go
exec MakeTables;
go


-- Transaction A 
-- INCLUDE Text from brief about the transaction
DROP PROCEDURE IF EXISTS SubscribeToDatabox; 
go
CREATE PROCEDURE SubscribeToDatabox @pSalesID AS INTEGER, @pSubFirstName VARCHAR(30),
	  @pSubSecondName VARCHAR(30),
	  @pSubscriberAddress VARCHAR(255),
	  @pSubphone VARCHAR(12),
	  @pDiscount REAL,
	  @pDataboxID INTEGER

as
begin
       DECLARE @tblID TABLE ( SUBID INTEGER);

	   INSERT INTO tblSubScription(	  SalesID ,SubFirstName,SubSecondName ,SubscriberAddress, Subphone, Discount) 
	   OUTPUT INSERTED.SubID INTO @tblID
	   VALUES ( @pSalesID ,@pSubFirstName,@pSubSecondName ,@pSubscriberAddress, @pSubphone, @pDiscount);

	   INSERT INTO tblSubDatabox VALUES ( (SELECT SUbID from @tblID),@pDataboxID); 
end;

go
-- TESTING A - Thomas Salesperson ID 1 sells a subscription to Jane Doe at a discount of 3% to DATABOX 1
DELETE FROM tblSubscription;
exec SubscribeToDatabox 1,'Jane','Doe','t','t',3.0,1;
select * from tblSubscription;
select * from tblSubDatabox;
go

-- Transaction B
-- Put the description of Transaction B here
DROP PROCEDURE IF EXISTS ShowSales;
go
CREATE PROCEDURE ShowSales @pName VARCHAR(255)
as
begin
  SELECT SubFirstName, SubSecondName, Discount
  FROM 
       tblSalesPerson as SP JOIN tblSubScription SB on SP.ID = SB.SalesID
  WHERE
        SP.Name = @pName;
end;
go
-- TESTING B
EXEC ShowSales 'Thomas';
go 

-- Transaction C
-- Put the text describing transaction C here
-- List the location in latitude, longitude coordinates, 
-- of each BT Databox that is currently in a contract. 
-- The transaction presents the Contracting organisation's name, 
-- a BT DataboxID, a Latitude, and a Longitude.

DROP PROCEDURE IF EXISTS ListDataBoxesByOrganisation;

GO
    CREATE PROCEDURE ListDataBoxesByOrganisation 
	AS 
    BEGIN
    SELECT C.ContractingOrg, DB.Lat, DB.Long, DB.DBNUM 
    FROM tblContract C JOIN tblContractZone CZ
                        ON C.ID = CZ.ContractID
                        JOIN tblZone Z
                        ON Z.ID = CZ.ZoneID
                        JOIN tblDataboxZone DZ
                        ON Z.ID = DZ.ZoneID
                        JOIN tblDATABOX DB
                        ON DZ.DataBoxID = DBNUM;
END;

GO