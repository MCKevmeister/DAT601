GO
    DROP DATABASE IF EXISTS BeingThere
GO
    CREATE DATABASE BeingThere
GO
    USE Being There
GO

DROP PROCEDURE IF EXISTS createDBBeingThere;
CREATE PROCEDURE createDBBeingThere()
AS
BEGIN
    DROP TABLE IF EXISTS tblOwnsVideoRights;
    DROP TABLE IF EXISTS tblOwnsDataRights;
    DROP TABLE IF EXISTS tblStaffRole;
    DROP TABLE IF EXISTS tblContractScientificData;
    DROP TABLE IF EXISTS tblContractedZone;
    DROP TABLE IF EXISTS tblContractedBTDatabox;
    DROP TABLE IF EXISTS tblContract;
    DROP TABLE IF EXISTS tblSubscriptoinDatabox;
    DROP TABLE IF EXISTS tblSubscriptionZone;
    DROP TABLE IF EXISTS tblZoneCondition;
    DROP TABLE IF EXISTS tblZoneCountry;
    DROP TABLE IF EXISTS tblOrderItem;
    DROP TABLE IF EXISTS tblOrder;
    DROP TABLE IF EXISTS tblPartSupplier;
    DROP TABLE IF EXISTS tblMaintenancePart;
    DROP TABLE IF EXISTS tblMaintenance;
    DROP TABLE IF EXISTS tblVideoStreamController;
    DROP TABLE IF EXISTS tblVideoStreamViewer;
    DROP TABLE IF EXISTS tblSale;
    DROP TABLE IF EXISTS tblSalespersonStore;
    DROP TABLE IF EXISTS tblStore;
    DROP TABLE IF EXISTS tblBTDataboxZone;
    DROP TABLE IF EXISTS tblBTDataboxPart;
    DROP TABLE IF EXISTS tblBTDataboxPart;
    DROP TABLE IF EXISTS tblBTDataboxData;
    DROP TABLE IF EXISTS tblBTDataboxStream;
    DROP TABLE IF EXISTS tblPriceChange;
    DROP TABLE IF EXISTS tblSuperPlatinum;
    DROP TABLE IF EXISTS tblPlatinum;
    DROP TABLE IF EXISTS tblGold;
    DROP TABLE IF EXISTS tblSubscription;
    DROP TABLE IF EXISTS tblDiscount;
    DROP TABLE IF EXISTS tblSubscriber;
    DROP TABLE IF EXISTS tblContractee;
    DROP TABLE IF EXISTS tblDroneOwner;
    DROP TABLE IF EXISTS tblPayment;
    DROP TABLE IF EXISTS tblCustomer;
    DROP TABLE IF EXISTS tblAccount;
    DROP TABLE IF EXISTS tblAddress;
    DROP TABLE IF EXISTS tblPostCode;
    DROP TABLE IF EXISTS tblVideoStream;
    DROP TABLE IF EXISTS tblSupplier;
    DROP TABLE IF EXISTS tblPart;
    DROP TABLE IF EXISTS tblBTDatabox;
    DROP TABLE IF EXISTS tblScientificData;
    DROP TABLE IF EXISTS tblStaff;
    DROP TABLE IF EXISTS tblDrone;
    DROP TABLE IF EXISTS tblMaintenanceperson;
    DROP TABLE IF EXISTS tblSalesperson;
    DROP TABLE IF EXISTS tblAdministrationExecutive;
    DROP TABLE IF EXISTS tblDirector;
    DROP TABLE IF EXISTS tblCondition;
    DROP TABLE IF EXISTS tblZone;
    DROP TABLE IF EXISTS tblCountry;

    CREATE TABLE BeingThere.tblCountry ( 
            [Country] VARCHAR(64) IDENTITY PRIMARY KEY 
        );
    
        CREATE TABLE BeingThere.tblZone ( 
            [ZoneID] INT IDENTITY PRIMARY KEY,
            [MinimumLatitude] Decimal(10, 7) NOT NULL,
            [MaximumLatitude] Decimal (10, 7) NOT NULL,
            [MinimumLongitude] Decimal (10, 7) NOT NULL,
            [MaximumLongitude] Decimal (10, 7) NOT NULL
        );
    
        CREATE TABLE BeingThere.tblCondition (
            [ConditionID] INT IDENTITY PRIMARY KEY,
            [ConditionDescription] VARCHAR(255) NOT NULL
        );
    
        CREATE TABLE BeingThere.tblDirector (
            [DirectorID] INT IDENTITY PRIMARY KEY
        );
        
        CREATE TABLE BeingThere.tblAdministrationExecutive (
            [AdminExecID] INT IDENTITY PRIMARY KEY
        );

        CREATE TABLE BeingThere.tblSalesperson (
            [SalespersonID] INT IDENTITY PRIMARY KEY
        )
        CREATE TABLE BeingThere.tblMaintenancePerson ( 
            [MaintencepersonID] INT IDENTITY PRIMARY KEY
        );
        CREATE TABLE BeingThere.tblDrone (
            [DroneID] INT IDENTITY PRIMARY KEY,
            [Description] VARCHAR(255) NOT NULL,
            [OperationTime] INT NOT NULL
        );
        CREATE TABLE BeingThere.tblStaff (
            [AccountID] INT IDENTITY PRIMARY KEY,
            [Salary] MONEY NOT NULL,
            [NextOfKin] VARCHAR(64) NOT NULL,
            [BeganEmployment] DATE NOT NULL,
            [EndedEmployment] DATE
        )
        CREATE TABLE BeingThere.tblScientificData (
            [ScientificDataID] INT IDENTITY PRIMARY KEY,
            [Longitude] Decimal(10, 7) NOT NULL,
            [Latitude] Decimal(10, 7) NOT NULL,
            [Altitude] INT NOT NULL,
            [Temperature] Decimal(5, 2) NOT NULL,
            [AmbientLightStrength] Decimal(11, 4) NOT NULL,
            [RecordingTime] TIME NOT NULL
        )
        CREATE TABLE BeingThere.tblBTDatabox ( 
            [BTDataboxID] INT IDENTITY PRIMARY KEY,
            [FirstOperated] DATE,
            [NextScheduledMaintanence] DATE,
            [IPRating] VARCHAR(2) NOT NULL
        )
        CREATE TABLE BeingThere.tblPart (
            [PartID] INT IDENTITY PRIMARY KEY,
            [Partname] VARCHAR(64) NOT NULL,
            [Description] VARCHAR(64) NOT NULL,
            [Cost] MONEY NOT NULL
        )
        CREATE TABLE BeingThere.tblSupplier (
            [SupplierID] INT IDENTITY PRIMARY KEY
            [SupplierName] VARCHAR(64) NOT NULL,
            [ContactPerson] VARCHAR(64) NOT NULL,
            [Email] VARCHAR(64) NOT NULL,
            [Address] VARCHAR(64) NOT NULL,
            [PhoneNumber] VARCHAR(64) NOT NULL
        )
        CREATE TABLE BeingThere.tblVideoStream (
            [StreamID] INT IDENTITY PRIMARY KEY
            [StartTime] DATETIME NOT NULL,
            [EndTime] DATETIME
            [Length] INT
        )
        CREATE TABLE BeingThere.tblPostCode (
            [PostCodeID] INT IDENTITY PRIMARY KEY
            [PostCode] VARCHAR(16) NOT NULL,
            [City] VARCHAR(64) NOT NULL,
            [Country] VARCHAR(64) NOT NULL,
            FOREIGN KEY (Country) REFERENCES BeingThere.tblCountry (Country)
        )
        CREATE TABLE BeingThere.tblAddress (
            [AddressID] INT IDENTITY PRIMARY KEY,
            [Prefix] VARCHAR(16),
            [StreetNumber] VARCHAR(16) NOT NULL,
            [StreetName] VARCHAR(64) NOT NULL,
            [PostCodeID] INT NOT NULL,
            FOREIGN KEY (PostCodeID) REFERENCES BeingThere.tblPostCode (PostCodeID)
        
        )
        CREATE TABLE BeingThere.tblAccount ( 
            [AccountID] INT IDENTITY PRIMARY KEY,
            [Name] VARCHAR(255) NOT NULL,
            [Password] VARCHAR(64) NOT NULL,
            [AddressID] INT NOT NULL,
            [PhoneNumber] VARCHAR(64),
            FOREIGN KEY (AddressID) REFERENCES BeingThere.tblAddress (AddressID)
        )
        CREATE TABLE BeingThere.tblCustomer ( 
            [AccountID] INT IDENTITY PRIMARY KEY,
            FOREIGN KEY (AccountID) REFERENCES BeingThere.tblAccount (AccountID)
        )
        CREATE TABLE BeingThere.tblPayment ( 
            [PaymentID] INT IDENTITY PRIMARY KEY,
            [Type] VARCHAR(16) NOT NULL,
            [PaymentDate] DATE NOT NULL,
            [Amount] MONEY NOT NULL,
            [CustomerID] INT NOT NULL,
            FOREIGN KEY (CustomerID) REFERENCES BeingThere.tblCustomer(CustomerID)
        )
        CREATE TABLE BeingThere.tblDroneOwner ( 
            [AccountID] INT,
            [DroneID] INT,
            PRIMARY KEY(AccountID, DroneID),
            FOREIGN KEY (AccountID) REFERENCES BeingThere.tblAccount(AccountID),
            FOREIGN KEY (DroneID) REFERENCES BeingThere.tblDrone(DroneID)
        )
        CREATE TABLE BeingThere.tblContractee (
            [AccountID] INT PRIMARY KEY,
            FOREIGN KEY (AccountID) REFERENCES BeingThere.tblAccount (AccountID)
        )
        CREATE TABLE BeingThere.tblSubscriber ( 
            [AccountID] INT PRIMARY KEY,
            FOREIGN KEY (AccountID) REFERENCES BeingThere.tblAccount (AccountID)
        )
        CREATE TABLE BeingThere.tblDiscount (
            [DiscountAmount] REAL IDENTITY PRIMARY KEY
        )
        CREATE TABLE BeingThere.tblSubscription (
            [SubscriptionID] INT IDENTITY PRIMARY KEY,
            [AccountID] INT NOT NULL,
            [TotalPrice] MONEY,
            FOREIGN KEY (AccountID) REFERENCES BeingThere.tblAccount (AccountID)
        )
        CREATE TABLE BeingThere.tblGold ( 
            [SubscriptionID] INT PRIMARY KEY,
            [GoldPrice] MONEY NOT NULL,
            FOREIGN KEY (SubscriptionID) REFERENCES BeingThere.tblSubscription (SubscriptionID)
        )
        CREATE TABLE BeingThere.tblPlatinum (
            [SubscriptionID] INT PRIMARY KEY,
            [PlatinumPrice] MONEY NOT NULL,
            FOREIGN KEY (SubscriptionID) REFERENCES BeingThere.tblGold (SubscriptionID)
        )
        CREATE TABLE BeingThere.tblSuperPlatinum (
            [SubscriptionID] INT PRIMARY KEY,
            [SuperPlatinumPrice] MONEY NOT NULL,
            FOREIGN KEY (SubscriptionID) REFERENCES BeingThere.tblPlatinum (SubscriptionID)
        )
        CREATE TABLE BeingThere.tblPriceChange (
            [PriceChangeID] INT IDENTITY PRIMARY KEY,
            [DirectorID] INT NOT NULL,
            [SubscriptionID] INT NOT NULL,
            [Date] DATE NOT NULL,
            [PreviousPrice] MONEY NOT NULL,
            [NewPrice] MONEY NOT NULL,
            FOREIGN KEY (DirectorID) REFERENCES BeingThere.tblDirector (DirectorID),
            FOREIGN KEY (SubscriptionID) REFERENCES BeingThere.tblPlatinum (SubscriptionID)
        )
        CREATE TABLE BeingThere.tblBTDataboxStream ( 
            [BTDataboxID] INT NOT NULL,
            [StreamID] INT NOT NULL,
            PRIMARY KEY(BTDataboxID, StreamID),
            FOREIGN KEY (BTDataboxID) REFERENCES BeingThere.tblBTDatabox (BTDataboxID),
            FOREIGN KEY (StreamID) REFERENCES BeingThere.tblVideoStream (StreamID)
        )
        CREATE TABLE BeingThere.tblBTDataboxData (
            [BTDataboxID] INT NOT NULL,
            [ScientificDataID] INT NOT NULL,
            PRIMARY KEY(BTDataboxID, ScientificDataID),
            FOREIGN KEY (BTDataboxID) REFERENCES BeingThere.tblBTDatabox (BTDataboxID),
            FOREIGN KEY (ScientificDataID) REFERENCES BeingThere.tblScientificData (ScientificDataID)
        )
        CREATE TABLE BeingThere.tblBTDataboxPart (
            [BTDataboxID] INT NOT NULL,
            [PartID] INT NOT NULL,
            PRIMARY KEY(BTDataboxID, PartID),
            FOREIGN KEY (BTDataboxID) REFERENCES BeingThere.tblBTDatabox (BTDataboxID),
            FOREIGN KEY (PartID) REFERENCES BeingThere.tblPart (PartID)
        )
        CREATE TABLE BeingThere.tblBTDataboxZone (
            [BTDataboxID] INT NOT NULL,
            [ZoneID] INT NOT NULL,
            PRIMARY KEY(BTDataboxID, ZoneID),
            FOREIGN KEY (BTDataboxID) REFERENCES BeingThere.tblBTDataboxData (BTDataboxID),
            FOREIGN KEY (ZoneID) REFERENCES BeingThere.tblZone (ZoneID)
        )
        CREATE TABLE BeingThere.tblStore (
            [StoreID] INT IDENTITY PRIMARY KEY,
            [Name] VARCHAR(64) NOT NULL,
            [AddressID] INT NOT NULL,
            [PhoneNumber] VARCHAR(32) NOT NULL,
            FOREIGN KEY (BTDataboxID) REFERENCES BeingThere.tblBTDataboxData (BTDataboxID),
            FOREIGN KEY (ZoneID) REFERENCES BeingThere.tblZone (ZoneID)
        )
        CREATE TABLE BeingThere.tblSalespersonStore ( 
            [StoreID] INT NOT NULL,
            [SalespersonID] INT NOT NULL,
            PRIMARY KEY(StoreID, SalespersonID),
            FOREIGN KEY (StoreID) REFERENCES BeingThere.tblStore (StoreID),
            FOREIGN KEY (SalespersonID) REFERENCES BeingThere.tblSalesperson (SalespersonID)
        )
        CREATE TABLE BeingThere.tblSale (
            [SalesPersonID] INT NOT NULL,
            [SubscriptionID] INT NOT NULL,
            [DiscountAmount] REAL,
            PRIMARY KEY(SalesPersonID, SubscriptionID),
            FOREIGN KEY (SalesPersonID) REFERENCES BeingThere.tblSalesperson (SalesPersonID),
            FOREIGN KEY (ZoneID) REFERENCES BeingThere.tblZone (ZoneID)
        )
        CREATE TABLE BeingThere.tblVideoStreamViewer (
            [StreamID] INT NOT NULL,
            [SubscriptionID] INT NOT NULL,
            PRIMARY KEY(StreamID, SubscriptionID),
            FOREIGN KEY (StreamID) REFERENCES BeingThere.tblVideoStream (StreamID),
            FOREIGN KEY (SubscriptionID) REFERENCES BeingThere.tblSubscription (SubscriptionID)
        )
        CREATE TABLE BeingThere.tblVideoStreamController (
            [StreamID] INT NOT NULL,
            [SubscriptionID] INT NOT NULL,
            [Pan] Decimal(6, 3) NOT NULL,
            [Tilt] Decimal(6, 3) NOT NULL,
            [Zoom] Decimal(6, 3) NOT NULL,
            FOREIGN KEY (SubscriptionID) REFERENCES BeingThere.tblSubscription (SubscriptionID)
        )
        CREATE TABLE BeingThere.tblMaintenancePart ( 
            [MaintenanceID] INT NOT NULL,
            [PartID] INT NOT NULL,
            PRIMARY KEY(MaintenanceID, PartID),
            FOREIGN KEY (MaintenanceID) REFERENCES BeingThere.tblMaintenance (MaintenanceID),
            FOREIGN KEY (PartID) REFERENCES BeingThere.tblPart (PartID)
        )
        CREATE TABLE BeingThere.tblPartSupplier ( 
            [PartID] INT NOT NULL,
            [SupplierID] INT NOT NULL,
            PRIMARY KEY(PartID, SupplierID),
            FOREIGN KEY (PartID) REFERENCES BeingThere.tblPart (PartID),
            FOREIGN KEY (SupplierID) REFERENCES BeingThere.tblSupplier (SupplierID)
        )
        CREATE TABLE BeingThere.tblOrder ( 
            [OrderID] INT NOT NULL,
            [MaintenancePersonID] INT NOT NULL,
            PRIMARY KEY(OrderID, SupplierID),
            FOREIGN KEY (OrderID) REFERENCES BeingThere.tblOrder (OrderID),
            FOREIGN KEY (MaintenancePersonID) REFERENCES BeingThere.tblMaintenancePerson(MaintenancePersonID)
        )
        CREATE TABLE BeingThere.tblOrderItem (
            [OrderID] INT NOT NULL,
            [PartID] INT NOT NULL,
            [SupplierID] INT NOT NULL,
            PRIMARY KEY(OrderID, PartID, SupplierID),
            FOREIGN KEY (OrderID) REFERENCES BeingThere.tblOrder (OrderID),
            FOREIGN KEY (PartID) REFERENCES BeingThere.tbl(PartID),
            FOREIGN KEY (SupplierID) REFERENCES BeingThere.tblSupplier(SupplierID)
        )
        CREATE TABLE BeingThere.tblZoneCountry ( 
            [ZoneID] INT NOT NULL,
            [CountryID] INT NOT NULL,
            PRIMARY KEY(ZoneID, CountryID),
            FOREIGN KEY (ZoneID) REFERENCES BeingThere.tblZone (ZoneID),
            FOREIGN KEY (CountryID) REFERENCES BeingThere.tblCountry(CountryID)
        )

        CREATE TABLE BeingThere.tblZoneCondition (
            [ZoneID] INT NOT NULL,
            [ConditionID] INT NOT NULL,
            PRIMARY KEY(ZoneID, ConditionID),
            FOREIGN KEY (ZoneID) REFERENCES BeingThere.tblZone (ZoneID),
            FOREIGN KEY (ConditionID) REFERENCES BeingThere.tblCondition(ConditionID)
        )
        CREATE TABLE BeingThere.tblSubscriptionZone (
            [SubscriptionID] INT NOT NULL,
            [ZoneID] INT NOT NULL,
            PRIMARY KEY(SubscriptionID, ZoneID),
            FOREIGN KEY (SubscriptionID) REFERENCES BeingThere.tblSubscription (SubscriptionID),
            FOREIGN KEY (ZoneID) REFERENCES BeingThere.tblZone(ZoneID)
        )
    
        CREATE TABLE BeingThere.tblSubscriptionBTDatabox (
            [SubscriptionID] INT NOT NULL,
            [BTDataboxID] INT NOT NULL,
            PRIMARY KEY(SubscriptionID, BTDataboxID),
            FOREIGN KEY (SubscriptionID) REFERENCES BeingThere.tblSubscription (SubscriptionID),
            FOREIGN KEY (BTDataboxID) REFERENCES BeingThere.tblBTDatabox(BTDataboxID)
        ) 
    
        CREATE TABLE BeingThere.tblContract (
            [ContractID] INT IDENTITY PRIMARY KEY,
            [StartDate] DATE NOT NULL,
            [EndDate] DATE,
            [Value] INT NOT NULL,
            [Contractee] INT NOT NULL,
            [EnteredByAdmin] INT NOT NULL,
            FOREIGN KEY (Contractee) REFERENCES BeingThere.tblContractee (AccountID),
            FOREIGN KEY (EnteredByAdmin) REFERENCES BeingThere.tblAdministrationExecutive(AdminExecID)
        )
    
        CREATE TABLE BeingThere.tblContractedBTDatabox (
            [ContractID] INT NOT NULL,
            [BTDataboxID] INT NOT NULL,
            PRIMARY KEY(ContractID, BTDataboxID),
            FOREIGN KEY (ContractID) REFERENCES BeingThere.tblContract (ContractID),
            FOREIGN KEY (BTDataboxID) REFERENCES BeingThere.tblBTDatabox(BTDataboxID)
        )
    
        CREATE TABLE BeingThere.tblContractedZone (
            [ContractID] INT NOT NULL,
            [ZoneID] INT NOT NULL,
            PRIMARY KEY(ContractID, BTDataboxID),
            FOREIGN KEY (ContractID) REFERENCES BeingThere.tblContract (ContractID),
            FOREIGN KEY (ZoneID) REFERENCES BeingThere.tblZone(ZoneID)
        )
    
        CREATE TABLE BeingThere.tblContractScientificData (
            [ContractID] INT NOT NULL,
            [ScientificDataID] INT NOT NULL,
            PRIMARY KEY(ContractID, BTDataboxID),
            FOREIGN KEY (ContractID) REFERENCES BeingThere.tblContract (ContractID),
            FOREIGN KEY (ScientificDataID) REFERENCES BeingThere.tblScientificData(ScientificDataID)
        )
    
        CREATE TABLE BeingThere.tblStaffRole (
            [AccountID] INT NOT NULL,
            [RoleID] INT NOT NULL,
            PRIMARY KEY(AccountID, RoleID),
            FOREIGN KEY (AccountID) REFERENCES BeingThere.tblAccount (AccountID),
            FOREIGN KEY (RoleID) REFERENCES BeingThere.tblBTDatabox(RoleID)
        )
    
        CREATE TABLE BeingThere.tblOwnsDataRights (
            [ScientificDataID] INT NOT NULL,
            [SubscriptionID] INT NOT NULL,
            PRIMARY KEY(ScientificDataID, SubscriptionID),
            FOREIGN KEY (ScientificDataID) REFERENCES BeingThere.tblScientificData (ScientificDataID),
            FOREIGN KEY (SubscriptionID) REFERENCES BeingThere.tblPlatinum(SubscriptionID)
        )
    
        CREATE TABLE BeingThere.tblOwnsVideoRights (
            [StreamID] INT NOT NULL,
            [SubscriptionID] INT NOT NULL,
            PRIMARY KEY(StreamID, SubscriptionID),
            FOREIGN KEY (StreamID) REFERENCES BeingThere.tblVideoStream (StreamID),
            FOREIGN KEY (SubscriptionID) REFERENCES BeingThere.tblSuperPlatinum(SubscriptionID)
        )
    
END;

-- 1. A sales person subscribes to a new standard subscription to a BT Databox . 
-- The transaction receives the sales person Id, a discount %, all subscriber details, and a BT Databox ID. 
DROP PROCEDURE IF EXISTS newStandardSubscription;
CREATE PROCEDURE newStandardSubscription (pSalesPersonID INT, pDiscount REAL, pName VARCHAR(255), pPassword VARCHAR(64), pPhoneNumber VARCHAR(64), pAddressPrefix VARCHAR(16), pStreetNumber VARCHAR(64), pStreetName VARCHAR(64), pPostCode VARCHAR(16), pCity VARCHAR(64), pCountry VARCHAR(64))
AS
BEGIN
    -- IF NOT EXISTS(SELECT * FROM tblAccount WHERE [Name] = pName AND (SELECT * FROM tblAddress WHERE [Prefix] = pAddressPrefix AND [StreetNumber] = pStreetNumber) AND [STREETNAME] = pStreetName AND (''))
    IF NOT EXISTS(SELECT * FROM tblCountry WHERE [Country] = pCountry)
    THEN
        BEGIN
            INSERT INTO tblCountry ([Country])
            VALUES (pCountry);
        END;
    END IF; 
    IF NOT EXISTS(SELECT * FROM tblPostCode WHERE [PostCode] = pPostCode)
    THEN    
        BEGIN
            INSERT INTO tblPostCode ([PostCode], [City], [Country])
            VALUES (pPostCode, pCity, (SELECT LAST INSERT INDEX?????TODO));
        END;
    END IF;
    INSERT INTO tblAddress([Prefix], [StreetNumber], [StreetName], [PostCodeID])
    VALUES (pAddressPrefix, pStreetNumber, pStreetName, (SELECT LAST INSERT INDEX?????TODO))

    INSERT INTO tblAccount([Name], [Password], [AddressID], [PhoneNumber])
    VALUES (pName, pPassword, (Select last insert index???TODO), pPhoneNumber);

    INSERT INTO tblCustomer
    VALUES (SELECT LAST insert index);

    INSERT INTO tblSubscriber
    Values (SELECT LAST insert index);

    INSERT INTO tblSubscription ([AccountID], )
END;

-- 2. For each sales person list the subscribers they have sold a subscription to. The transaction receives the sales person's name as input, 
-- and presents each subscriber's name, address, and the % they were discounted.
DROP PROCEDURE IF EXISTS salesPersonCustomers;
CREATE PROCEDURE salesPersonCustomers()
AS
BEGIN
    SELECT 
    FROM tblAccount AS StaffAccount, tblAccount AS CustomerAccount, tblCustomer, 
END;


-- 3. List the location in latitude, longitude coordinates, of each BT Databox that is currently in a contract. 
-- The transaction presents the Contracting organisation's name, a BT DataboxID, a Latitude, and a Longitude.
DROP PROCEDURE IF EXISTS allBTDataboxInContract;
CREATE PROCEDURE allBTDataboxInContract()
AS
BEGIN

END;

-- 4. For a contract list all the data collected. The transaction receives the contracting organisation's name 
-- and presents for each collected data record, the contracting organisation's name, a BT Databox ID, Temperature, Humidity and Ambient light strength.
DROP PROCEDURE IF EXISTS allContractData;
CREATE PROCEDURE allContractData()
AS
BEGIN

END;

-- 5. For each BT Databox present the list of subscribers who are viewing a live 3D video stream. The transaction lists BT Databox ID, Subscriber Name, Stream ID.
DROP PROCEDURE IF EXISTS allVideoStreamViewers;
CREATE PROCEDURE allVideoStreamViewers()
AS
BEGIN

END;

-- 6. For a given BT Databox list all the suppliers of parts. The transaction receives the  BT Databox ID, and presents the Supplier Name and, Part Name.
DROP PROCEDURE IF EXISTS getBTDataboxPartSuppliers;
CREATE PROCEDURE allVideoStreamViewers()
AS
BEGIN

END;

-- 	7. Update the location and Zone of a  BT Databox. The transaction receives the  BT Databox ID, a location and a Zone expressed as a list of coordinates 
-- in latitude, longitude pairs. It updates the location of the  BT Databox and its corresponding Zone. (This transaction may require more than one update query.)
DROP PROCEDURE IF EXISTS updateBTDataboxLocation;
CREATE PROCEDURE updateBTDataboxLocation()
AS
BEGIN

END;

-- 8.  Delete the data collected for a given Contract. The transaction receives a Contract ID, the data collected for a Contract is deleted.
DROP PROCEDURE IF EXISTS deleteContractData;
CREATE PROCEDURE deleteContractData()
AS
BEGIN

END;

-- 9. Write a query to be used to Insert data from a  BT Databox to its stored data on the Being There database. The transaction receives the  BT Databox ID.
DROP PROCEDURE IF EXISTS insertBTDataboxData;
CREATE PROCEDURE allVideoStreamViewers()
AS
BEGIN

END;
-- Call createDBBeingThere();

-- discount REAL CHECK ( Discount >+ 0.0 and Discount <+ 100.00)

-- procedure sales from tblsalespersonName
-- @psalesname varchar(50)
-- as begin select
-- from sbufirstname, subsecondname, subscripber addresss, discount
-- tblsalesperson as sp join
-- tblsubscription as sub on sp.salesid = salesid = sbu.salesidwhere 
-- where sp.name = @psalesname

-- exec showsales Jane