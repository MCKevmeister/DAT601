GO
    DROP DATABASE IF EXISTS BeingThere
GO
    CREATE DATABASE BeingThere
GO
    USE Being There
GO
    CREATE TABLE BeingThere.tblCountry { 
        [Country] VARCHAR(64) IDENTITY 
    }
GO
    CREATE TABLE BeingThere.tblZone { 
        [ZoneID] INT IDENTITY,
        [MinimumLatitude] Decimal(10, 7) NOT NULL,
        [MaximumLatitude] Decimal (10, 7) NOT NULL,
        [MinimumLongitude] Decimal (10, 7) NOT NULL,
        [MaximumLongitude] Decimal (10, 7) NOT NULL
    }
GO
    CREATE TABLE BeingThere.tblCondition {
        [ConditionID] INT IDENTITY,
        [ConditionDescription] VARCHAR(255) NOT NULL
     }
GO
    CREATE TABLE BeingThere.tblDirector {
        [DirectorID] INT IDENTITY
     }
GO
    CREATE TABLE BeingThere.tblAdministrationExecutive {
        [AdminExecID] INT IDENTITY
     }
GO
    CREATE TABLE BeingThere.tblSalesperson {
        [SalespersonID] INT IDENTITY
     }
GO
    CREATE TABLE BeingThere.tblMaintenancePerson { 
        [MaintencepersonID] INT IDENTITY
    }
GO
    CREATE TABLE BeingThere.tblDrone {
        [DroneID] INT IDENTITY,
        [Description] VARCHAR(255) NOT NULL,
        [OperationTime] INT NOT NULL
     }
GO
    CREATE TABLE BeingThere.tblStaff {
        [AccountID] INT IDENTITY,
        [Salary] MONEY NOT NULL,
        [NextOfKin] VARCHAR(64) NOT NULL,
        [BeganEmployment] DATE NOT NULL,
        [EndedEmployment] DATE
     }
GO
    CREATE TABLE BeingThere.tblScientificData {
        [ScientificDataID] INT IDENTITY,
        [Longitude] Decimal(10, 7) NOT NULL,
        [Latitude] Decimal(10, 7) NOT NULL,
        [Altitude] INT NOT NULL,
        [Temperature] Decimal(5, 2) NOT NULL,
        [AmbientLightStrength] Decimal(11, 4) NOT NULL,
        [RecordingTime] TIME NOT NULL
     }
GO
    CREATE TABLE BeingThere.tblBTDatabox { 
        [BTDataboxID] INT IDENTITY,
        [FirstOperated] DATE,
        [NextScheduledMaintanence] DATE,
        [IPRating] VARCHAR(2) NOT NULL
    }
GO
    CREATE TABLE BeingThere.tblPart {
        [PartID] INT IDENTITY,
        [Partname] VARCHAR(64) NOT NULL,
        [Description] VARCHAR(64) NOT NULL,
        [Cost] MONEY NOT NULL
     }
GO
    CREATE TABLE BeingThere.tblSupplier {
        [SupplierID] INT IDENTITY
        [SupplierName] VARCHAR(64) NOT NULL,
        [ContactPerson] VARCHAR(64) NOT NULL,
        [Email] VARCHAR(64) NOT NULL,
        [Address] VARCHAR(64) NOT NULL,
        [PhoneNumber] VARCHAR(64) NOT NULL
     }
GO
    CREATE TABLE BeingThere.tblVideoStream {
        [StreamID] INT IDENTITY
        [StartTime] DATETIME NOT NULL,
        [EndTime] DATETIME
        [Length] INT
     }
GO
    CREATE TABLE BeingThere.tblPostCode {
        [PostCodeID] INT IDENTITY
        [PostCode] VARCHAR(16) NOT NULL,
        [City] VARCHAR(64) NOT NULL,
        [Country] VARCHAR(64) NOT NULL,
        CONSTRAINT FK_country FOREIGN KEY (Country) REFERENCES BeingThere.tblCountry (Country)
     }
GO
    CREATE TABLE BeingThere.tblAddress {
        [AddressID] INT IDENTITY,
        [Prefix] VARCHAR(16),
        [StreetNumber] VARCHAR(16) NOT NULL,
        [StreetName] VARCHAR(64) NOT NULL,
        [PostCodeID] INT NOT NULL,
        CONSTRAINT FK_postcode FOREIGN KEY (PostCodeID) REFERENCES BeingThere.tblPostCode (PostCodeID)
    
     }
GO
    CREATE TABLE BeingThere.tblAccount { 
        [AccountID] INT IDENTITY,
        [Name] VARCHAR(255) NOT NULL,
        [Password] VARCHAR(64) NOT NULL,
        [AddressID] INT NOT NULL,
        [PhoneNumber] VARCHAR(64),
        CONSTRAINT FK_address FOREIGN KEY (AddressID) REFERENCES BeingThere.tblAddress (AddressID)
    }
GO
    CREATE TABLE BeingThere.tblCustomer { 
        [AccountID] INT IDENTITY,
        CONSTRAINT FK_account FOREIGN KEY (AccountID) REFERENCES BeingThere.tblAccount (AccountID)
    }
GO
    CREATE TABLE BeingThere.tblPayment { 
        [PaymentID] INT IDENTITY,
        [Type] VARCHAR(16) NOT NULL,
        [PaymentDate] DATE NOT NULL,
        [Amount] MONEY NOT NULL,
        [CustomerID] INT NOT NULL,
        CONSTRAINT FK_customer FOREIGN KEY (CustomerID) REFERENCES BeingThere.tblCustomer(CustomerID)
GO
    CREATE TABLE BeingThere.tblDroneOwner { 
        [AccountID] INT,
        [DroneID] INT,
        CONSTRAINT FK_customer FOREIGN KEY (AccountID) REFERENCES BeingThere.tblAccount(AccountID),
        CONSTRAINT FK_drone FOREIGN KEY (DroneID) REFERENCES BeingThere.tblDrone(DroneID)
    }
GO
    CREATE TABLE BeingThere.tblContractee {
        [AccountID] INT IDENTITY,
        CONSTRAINT FK_account FOREIGN KEY (AccountID) REFERENCES BeingThere.tblAccount (AccountID)
     }
GO
    CREATE TABLE BeingThere.tblSubscriber { 
        [AccountID] INT,
        CONSTRAINT FK_account FOREIGN KEY (AccountID) REFERENCES BeingThere.tblAccount (AccountID)
    }
GO
    CREATE TABLE BeingThere.tblDiscount {
        [DiscountAmount] FLOAT
     }
GO
    CREATE TABLE BeingThere.tblSubscription {
        [SubscriptionID] INT IDENTITY,
        [AccountID] INT NOT NULL,
        [TotalPrice] MONEY,
        CONSTRAINT FK_account FOREIGN KEY (AccountID) REFERENCES BeingThere.tblAccount (AccountID)
     }
GO
    CREATE TABLE BeingThere.tblGold { 
        [SubscriptionID] INT NOT NULL,
        [GoldPrice] MONEY NOT NULL,
        CONSTRAINT FK_subscriptionID FOREIGN KEY (SubscriptionID) REFERENCES BeingThere.tblSubscription (SubscriptionID)
    }
GO
    CREATE TABLE BeingThere.tblPlatinum {
        [SubscriptionID] INT NOT NULL,
        [PlatinumPrice] MONEY NOT NULL,
        CONSTRAINT FK_subscriptionID FOREIGN KEY (SubscriptionID) REFERENCES BeingThere.tblGold (SubscriptionID)
     }
GO
    CREATE TABLE BeingThere.tblSuperPlatinum {
        [SubscriptionID] INT,
        [SuperPlatinumPrice] MONEY NOT NULL,
        CONSTRAINT FK_subscriptionID FOREIGN KEY (SubscriptionID) REFERENCES BeingThere.tblPlatinum (SubscriptionID)
     }
GO
    CREATE TABLE BeingThere.tblPriceChange {
        [PriceChangeID] INT IDENTITY,
        [DirectorID] INT NOT NULL,
        [SubscriptionID] INT NOT NULL,
        [Date] DATE NOT NULL,
        [PreviousPrice] MONEY NOT NULL,
        [NewPrice] MONEY NOT NULL,
        CONSTRAINT FK_directorID FOREIGN KEY (DirectorID) REFERENCES BeingThere.tblDirector (DirectorID),
        CONSTRAINT FK_ FOREIGN KEY (SubscriptionID) REFERENCES BeingThere.tblPlatinum (SubscriptionID)
     }
GO
    CREATE TABLE BeingThere.tblBTDataboxStream { 
        [BTDataboxID] INT NOT NULL,
        [StreamID] INT NOT NULL
    }
GO
    CREATE TABLE BeingThere.tblBTDataboxData {
        [BTDataboxID] INT NOT NULL,
        [ScientificDataID] INT NOT NULL
     }
GO
    CREATE TABLE BeingThere.tblBTDataboxPart {
        [BTDataboxID] INT NOT NULL,
        [PartID] INT NOT NULL
     }
GO
    CREATE TABLE BeingThere.tblBTDataboxZone {
        [BTDataboxID] INT NOT NULL,
        [ZoneID] INT NOT NULL
     }
GO
    CREATE TABLE BeingThere.tblSalespersonStore { 
        [StoreID] INT NOT NULL,
        [SalespersonID] INT NOT NULL
    }
GO
    CREATE TABLE BeingThere.tblSale {
        [SalesPersonID] INT NOT NULL,
        [SubscriptionID] INT NOT NULL,
        [DiscountAmount] FLOAT
     }
GO
    CREATE TABLE BeingThere.tblVideoStreamViewer {
        [StreamID] INT NOT NULL,
        [SubscriptionID] INT NOT NULL
     }
GO
    CREATE TABLE BeingThere.tblVideoStreamController {
        [StreamID] INT NOT NULL,
        [SubscriptionID] INT NOT NULL,
        [Pan] Decimal(6, 3) NOT NULL,
        [Tilt] Decimal(6, 3) NOT NULL,
        [Zoom] Decimal(6, 3) NOT NULL
     }
GO
    CREATE TABLE BeingThere.tblMaintenancePart { 
        [MaintenanceID] INT NOT NULL,
        [PartID] INT NOT NULL
    }
GO
    CREATE TABLE BeingThere.tblPartSupplier { 
        [PartID] INT NOT NULL,
        [SupplierID] INT NOT NULL
    }
GO
    CREATE TABLE BeingThere.tblOrder { 
        [OrderID] INT NOT NULL,
        [MaintenancePersonID] INT NOT NULL
    }
GO
    CREATE TABLE BeingThere.tblOrderItem {
        [OrderID] INT NOT NULL,
        [PartID] INT NOT NULL,
        [SupplierID] INT NOT NULL
     }
GO
    CREATE TABLE BeingThere.tblZoneCountry { 
        [OrderID] INT NOT NULL,
        [PartID] INT NOT NULL,
        [SupplierID] INT NOT NULL
    }
GO
    CREATE TABLE BeingThere.tblZoneCondition {
        [ZoneID] INT NOT NULL,
        [ConditionID] INT NOT NULL
     }
GO
    CREATE TABLE BeingThere.tblSubscriptionZone {
        [SubscriptionID] INT NOT NULL,
        [ZoneID] INT NOT NULL
     }
GO
    CREATE TABLE BeingThere.tblSubscriptionBTDatabox {
        [SubscriptionID] INT NOT NULL,
        [BTDataboxID] INT NOT NULL
     } 
GO
    CREATE TABLE BeingThere.tblContract {
        [ContractID] INT IDENTITY,
        [StartDate] DATE NOT NULL,
        [EndDate] DATE,
        [Value] INT NOT NULL,
        [Contractee] INT NOT NULL,
        [EnteredByAdmin] INT NOT NULL
     }
GO
    CREATE TABLE BeingThere.tblContractedBTDatabox {
        [ContractID] INT NOT NULL,
        [BTDataboxID] INT NOT NULL
     }
GO
    CREATE TABLE BeingThere.tblContractedZone {
        [ContractID] INT NOT NULL,
        [ZoneID] INT NOT NULL
     }
GO
    CREATE TABLE BeingThere.tblContractScientificData {
        [ContractID] INT NOT NULL,
        [ScientificDataID] INT NOT NULL
     }
GO
    CREATE TABLE BeingThere.tblStaffRole {
        [AccountID] INT NOT NULL,
        [RoleID] INT NOT NULL
     }
GO
    CREATE TABLE BeingThere.tblOwnsDataRights {
        [ScientificDataID] INT NOT NULL,
        [SubscriptionID] INT NOT NULL
     }
GO
    CREATE TABLE BeingThere.tblOwnsVideoRights {
        [StreamID] INT NOT NULL,QQQQ
        [SubscriptionID] INT NOT NULL
     }
GO