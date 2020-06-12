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
            [DiscountAmount] FLOAT IDENTITY PRIMARY KEY
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
            [DiscountAmount] FLOAT,
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
    
end;
Call createDBBeingThere();

discount REAL CHECK ( Discount >+ 0.0 and Discount <+ 100.00)

procedure sales from tblsalespersonName
@psalesname varchar(50)
as begin select
from sbufirstname, subsecondname, subscripber addresss, discount
tblsalesperson as sp join
tblsubscription as sub on sp.salesid = salesid = sbu.salesidwhere 
where sp.name = @psalesname

exec showsales Jane