DROP DATABASE IF EXISTS AbsloutlyBeingThere;
GO
CREATE DATABASE AbsloutlyBeingThere;
GO
USE AbsloutlyBeingThere;
GO

DROP PROCEDURE IF EXISTS createDBAbsloutlyBeingThere;
GO

CREATE PROCEDURE createDBAbsloutlyBeingThere
AS
BEGIN
DROP TABLE IF EXISTS tblOwnsVideoRights;
DROP TABLE IF EXISTS tblOwnsDataRights;
DROP TABLE IF EXISTS tblStaffRole;
DROP TABLE IF EXISTS tblContractScientificData;
DROP TABLE IF EXISTS tblContractedZone;
DROP TABLE IF EXISTS tblContractedBTDatabox;
DROP TABLE IF EXISTS tblContract;
DROP TABLE IF EXISTS tblSubscriptionDatabox;
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
DROP TABLE IF EXISTS tblBTDataboxData;
DROP TABLE IF EXISTS tblBTDataboxStream;
DROP TABLE IF EXISTS tblPriceChange;
DROP TABLE IF EXISTS tblSuperPlatinum;
DROP TABLE IF EXISTS tblPlatinum;
DROP TABLE IF EXISTS tblGold;
DROP TABLE IF EXISTS tblSubscription;
DROP TABLE IF EXISTS tblSubscriber;
DROP TABLE IF EXISTS tblContractee;
DROP TABLE IF EXISTS tblDrone;
DROP TABLE IF EXISTS tblDroneOwner;
DROP TABLE IF EXISTS tblPayment;
DROP TABLE IF EXISTS tblCustomer;
DROP TABLE IF EXISTS tblMaintenanceperson;
DROP TABLE IF EXISTS tblSalesperson;
DROP TABLE IF EXISTS tblAdministrationExecutive;
DROP TABLE IF EXISTS tblDirector;
DROP TABLE IF EXISTS tblStaff;
DROP TABLE IF EXISTS tblAccount;
DROP TABLE IF EXISTS tblSupplier;
DROP TABLE IF EXISTS tblAddress;
DROP TABLE IF EXISTS tblPostCode;
DROP TABLE IF EXISTS tblVideoStream;
DROP TABLE IF EXISTS tblPart;
DROP TABLE IF EXISTS tblBTDatabox;
DROP TABLE IF EXISTS tblScientificData;
DROP TABLE IF EXISTS tblCondition;
DROP TABLE IF EXISTS tblZone;
DROP TABLE IF EXISTS tblCountry;

CREATE TABLE tblCountry ( 
    [CountryID] INT IDENTITY PRIMARY KEY,
    [Country] VARCHAR(64) NOT NULL
);
CREATE TABLE tblZone ( 
    [ZoneID] INT IDENTITY PRIMARY KEY,
    [MinimumLatitude] Decimal(10, 7) NOT NULL,
    [MaximumLatitude] Decimal (10, 7) NOT NULL,
    [MinimumLongitude] Decimal (10, 7) NOT NULL,
    [MaximumLongitude] Decimal (10, 7) NOT NULL
);
CREATE TABLE tblCondition (
    [ConditionID] INT IDENTITY PRIMARY KEY,
    [ConditionName] VARCHAR(32) NOT NULL,
    [ConditionDescription] VARCHAR(255) NOT NULL
);
CREATE TABLE tblScientificData (
    [ScientificDataID] INT IDENTITY PRIMARY KEY,
    [Longitude] Decimal(10, 7) NOT NULL,
    [Latitude] Decimal(10, 7) NOT NULL,
    [Altitude] INT NOT NULL,
    [Temperature] Decimal(5, 2) NOT NULL,
    [AmbientLightStrength] Decimal(11, 4) NOT NULL,
    [RecordingTime] DATETIME NOT NULL
);
CREATE TABLE tblBTDatabox ( 
    [BTDataboxID] INT IDENTITY PRIMARY KEY,
    [FirstOperated] DATE,
    [NextScheduledMaintanence] DATE,
    [IPRating] VARCHAR(2) NOT NULL
);
CREATE TABLE tblPart (
    [PartID] INT IDENTITY PRIMARY KEY,
    [Partname] VARCHAR(64) NOT NULL,
    [Description] VARCHAR(64) NOT NULL,
    [Cost] MONEY NOT NULL
);
CREATE TABLE tblVideoStream (
    [StreamID] INT IDENTITY PRIMARY KEY,
    [StartTime] DATETIME NOT NULL,
    [EndTime] DATETIME,
    [Length] INT
);
CREATE TABLE tblPostCode (
    [PostCodeID] INT IDENTITY PRIMARY KEY,
    [PostCode] VARCHAR(16) NOT NULL,
    [City] VARCHAR(64) NOT NULL,
    [CountryID] Int NOT NULL,
    FOREIGN KEY (CountryID) REFERENCES tblCountry (CountryID)
);
CREATE TABLE tblAddress (
    [AddressID] INT IDENTITY PRIMARY KEY,
    [Prefix] VARCHAR(16),
    [StreetNumber] VARCHAR(16) NOT NULL,
    [StreetName] VARCHAR(64) NOT NULL,
    [PostCodeID] INT NOT NULL,
    FOREIGN KEY (PostCodeID) REFERENCES tblPostCode (PostCodeID)
);
CREATE TABLE tblSupplier (
    [SupplierID] INT IDENTITY PRIMARY KEY,
    [SupplierName] VARCHAR(64) NOT NULL,
    [ContactPerson] VARCHAR(64) NOT NULL,
    [Email] VARCHAR(64) NOT NULL,
    [Address] INT NOT NULL,
    [PhoneNumber] VARCHAR(64) NOT NULL,
    FOREIGN KEY (Address) REFERENCES tblAddress (AddressID)
);
CREATE TABLE tblAccount ( 
    [AccountID] INT IDENTITY PRIMARY KEY,
    [Name] VARCHAR(255) NOT NULL,
    [Password] VARCHAR(64) NOT NULL,
    [AddressID] INT NOT NULL,
    [PhoneNumber] VARCHAR(64),
    FOREIGN KEY (AddressID) REFERENCES tblAddress (AddressID)
);
CREATE TABLE tblStaff (
    [StaffID] INT IDENTITY PRIMARY KEY,
    [AccountID] INT NOT NULL,
    [Salary] MONEY NOT NULL,
    [NextOfKin] VARCHAR(64) NOT NULL,
    [BeganEmployment] DATE NOT NULL,
    [EndedEmployment] DATE,
    FOREIGN KEY (AccountID) REFERENCES tblAccount(AccountID)
);
CREATE TABLE tblDirector (
    [DirectorID] INT IDENTITY PRIMARY KEY,
    [StaffID] INT NOT NULL,
    FOREIGN KEY (StaffID) REFERENCES tblStaff (StaffID) 
);
CREATE TABLE tblAdministrationExecutive (
    [AdminExecID] INT IDENTITY PRIMARY KEY,
    [StaffID] INT NOT NULL,
    FOREIGN KEY (StaffID) REFERENCES tblStaff (StaffID) 
);
CREATE TABLE tblSalesperson (
    [SalespersonID] INT IDENTITY PRIMARY KEY,
    [StaffID] INT NOT NULL,
    FOREIGN KEY (StaffID) REFERENCES tblStaff (StaffID) 
);
CREATE TABLE tblMaintenancePerson ( 
    [MaintencepersonID] INT IDENTITY PRIMARY KEY,
    [StaffID] INT NOT NULL,
    FOREIGN KEY (StaffID) REFERENCES tblStaff (StaffID) 
);
CREATE TABLE tblCustomer ( 
    [CustomerID] INT IDENTITY PRIMARY KEY,
    [AccountID] INT NOT NULL,
    FOREIGN KEY (AccountID) REFERENCES tblAccount (AccountID)
);
CREATE TABLE tblPayment (
    [PaymentID] INT IDENTITY PRIMARY KEY,
    [Type] VARCHAR(16) NOT NULL,
    [PaymentDate] DATE NOT NULL,
    [Amount] MONEY NOT NULL,
    [CustomerID] INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES tblCustomer(CustomerID)
);
CREATE TABLE tblDroneOwner (
    [DroneOwnerID] INT IDENTITY PRIMARY KEY,
    [AccountID] INT NOT NULL,
    FOREIGN KEY (AccountID) REFERENCES tblAccount(AccountID),
);
CREATE TABLE tblDrone (
    [DroneID] INT IDENTITY PRIMARY KEY,
    [DroneOwnerID] INT NOT NULL,
    [BTDataboxID] INT NOT NULL,
    [Description] VARCHAR(255) NOT NULL,
    [OperationTime] INT NOT NULL,
    FOREIGN KEY (DroneOwnerID) REFERENCES tblDroneOwner (DroneOwnerID),
    FOREIGN KEY (BTDataboxID) REFERENCES tblBTDatabox (BTDataboxID)
);
CREATE TABLE tblContractee (
    [ContracteeID] INT IDENTITY PRIMARY KEY
    [CustomerID] INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES tblAccount (CustomerID)
);
CREATE TABLE tblSubscriber ( 
    [SubscriberID] INT IDENTITY PRIMARY KEY,
    [CustomerID] INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES tblCustomer (CustomerID)
);
CREATE TABLE tblSubscription (
    [SubscriptionID] INT IDENTITY PRIMARY KEY,
    [SubscriberID] INT NOT NULL,
    [TotalPrice] MONEY NOT NULL,
    FOREIGN KEY (SubscriberID) REFERENCES tblAccount (SubscriberID)
);
CREATE TABLE tblGold ( 
    [GoldID] INT IDENTITY PRIMARY KEY,
    [SubscriptionID] INT NOT NULL,
    [GoldPrice] MONEY NOT NULL,
    FOREIGN KEY (SubscriptionID) REFERENCES tblSubscription (SubscriptionID)
);
CREATE TABLE tblPlatinum (
    [PlatinumID] INT IDENTITY PRIMARY KEY,
    [GoldID] INT NOT NULL,
    [PlatinumPrice] MONEY NOT NULL,
    FOREIGN KEY (GoldID) REFERENCES tblGold (GoldID)
);
CREATE TABLE tblSuperPlatinum (
    [SuperPlatinumID] INT IDENTITY PRIMARY KEY,
    [PlatinumID] INT NOT NULL,
    [SuperPlatinumPrice] MONEY NOT NULL,
    FOREIGN KEY (PlatinumID) REFERENCES tblPlatinum (PlatinumID)
);
CREATE TABLE tblPriceChange (
    [PriceChangeID] INT IDENTITY PRIMARY KEY,
    [DirectorID] INT NOT NULL,
    [SubscriptionID] INT NOT NULL,
    [GoldID] INT NOT NULL,
    [PlatinumID] INT NOT NULL,
    [SuperPlatinumID] INT NOT NULL,
    [Date] DATE NOT NULL,
    [PreviousPrice] MONEY NOT NULL,
    [NewPrice] MONEY NOT NULL,
    FOREIGN KEY (DirectorID) REFERENCES tblDirector (DirectorID),
    FOREIGN KEY (SubscriptionID) REFERENCES tblSubscription (SubscriptionID),
    FOREIGN KEY (GoldID) REFERENCES tblGold (GoldID),
    FOREIGN KEY (PlatinumID) REFERENCES tblPlatinum (PlatinumID),
    FOREIGN KEY (SuperPlatinumID) REFERENCES tblSuperPlatinum (SuperPlatinumID)
);
CREATE TABLE tblBTDataboxStream ( 
    [BTDataboxID] INT NOT NULL,
    [StreamID] INT NOT NULL,
    PRIMARY KEY(BTDataboxID, StreamID),
    FOREIGN KEY (BTDataboxID) REFERENCES tblBTDatabox (BTDataboxID),
    FOREIGN KEY (StreamID) REFERENCES tblVideoStream (StreamID)
);
CREATE TABLE tblBTDataboxData (
    [BTDataboxID] INT NOT NULL,
    [ScientificDataID] INT NOT NULL,
    PRIMARY KEY(BTDataboxID, ScientificDataID),
    FOREIGN KEY (BTDataboxID) REFERENCES tblBTDatabox (BTDataboxID),
    FOREIGN KEY (ScientificDataID) REFERENCES tblScientificData (ScientificDataID)
);
CREATE TABLE tblBTDataboxPart (
    [BTDataboxID] INT NOT NULL,
    [PartID] INT NOT NULL,
    PRIMARY KEY(BTDataboxID, PartID),
    FOREIGN KEY (BTDataboxID) REFERENCES tblBTDatabox (BTDataboxID),
    FOREIGN KEY (PartID) REFERENCES tblPart (PartID)
);
CREATE TABLE tblBTDataboxZone (
    [BTDataboxID] INT NOT NULL,
    [ZoneID] INT NOT NULL,
    PRIMARY KEY(BTDataboxID, ZoneID),
    FOREIGN KEY (BTDataboxID) REFERENCES tblBTDatabox (BTDataboxID),
    FOREIGN KEY (ZoneID) REFERENCES tblZone (ZoneID)
);
CREATE TABLE tblStore (
    [StoreID] INT IDENTITY PRIMARY KEY,
    [Name] VARCHAR(64) NOT NULL,
    [AddressID] INT NOT NULL,
    [PhoneNumber] VARCHAR(32) NOT NULL,
    FOREIGN KEY (AddressID) REFERENCES tblAddress (AddressID)
);
CREATE TABLE tblStoreSalesPerson ( 
    [StoreID] INT NOT NULL,
    [SalespersonID] INT NOT NULL,
    PRIMARY KEY(StoreID, SalespersonID),
    FOREIGN KEY (StoreID) REFERENCES tblStore (StoreID),
    FOREIGN KEY (SalespersonID) REFERENCES tblSalesperson (SalespersonID)
);
CREATE TABLE tblSale (
    [SalesPersonID] INT NOT NULL,
    [SubscriptionID] INT NOT NULL,
    [DiscountID] REAL NOT NULL CHECK ( Discount >= 0.0 and Discount <= 2.00), --check max discount amount TODO
    PRIMARY KEY(SalesPersonID, SubscriptionID),
    FOREIGN KEY (SalesPersonID) REFERENCES tblSalesperson (SalesPersonID)
);
CREATE TABLE tblVideoStreamViewer (
    [StreamID] INT NOT NULL,
    [SubscriptionID] INT NOT NULL,
    PRIMARY KEY(StreamID, SubscriptionID),
    FOREIGN KEY (StreamID) REFERENCES tblVideoStream (StreamID),
    FOREIGN KEY (SubscriptionID) REFERENCES tblSubscription (SubscriptionID)
);
CREATE TABLE tblVideoStreamController (
    [GoldID] INT NOT NULL,
    [StreamID] INT NOT NULL,
    [Pan] Decimal(6, 3) NOT NULL,
    [Tilt] Decimal(6, 3) NOT NULL,
    [Zoom] Decimal(6, 3) NOT NULL,
    FOREIGN KEY (GoldID) REFERENCES tblGold (GoldID),
    FOREIGN KEY (StreamID) REFERENCES tblVideoStream(StreamID)
    );
CREATE TABLE tblMaintenance (
    [MaintenanceID] INT IDENTITY PRIMARY KEY,
    [MaintencepersonID] INT NOT NULL,
    [BTdataboxID] INT NOT NULL,
    [Report] VARCHAR(255) NOT NULL,
    [Date] DATE NOT NULL,
    FOREIGN KEY (MaintencepersonID) REFERENCES tblMaintenancePerson (MaintencepersonID),
    FOREIGN KEY (BTdataboxID) REFERENCES tblBTDatabox (BTdataboxID)
);
CREATE TABLE tblMaintenancePart ( 
    [MaintenanceID] INT NOT NULL,
    [PartID] INT NOT NULL,
    PRIMARY KEY(MaintenanceID, PartID),
    FOREIGN KEY (MaintenanceID) REFERENCES tblMaintenance (MaintenanceID),
    FOREIGN KEY (PartID) REFERENCES tblPart (PartID)
);
CREATE TABLE tblPartSupplier ( 
    [PartID] INT NOT NULL,
    [SupplierID] INT NOT NULL,
    PRIMARY KEY(PartID, SupplierID),
    FOREIGN KEY (PartID) REFERENCES tblPart (PartID),
    FOREIGN KEY (SupplierID) REFERENCES tblSupplier (SupplierID)
);
CREATE TABLE tblOrder ( 
    [OrderID] INT PRIMARY KEY IDENTITY,
    [MaintenancePersonID] INT NOT NULL,
    [Date] DATE NOT NULL,
    FOREIGN KEY (MaintenancePersonID) REFERENCES tblMaintenancePerson(MaintencepersonID)
);
CREATE TABLE tblOrderItem (
    [OrderID] INT NOT NULL,
    [PartID] INT NOT NULL,
    [SupplierID] INT NOT NULL,
    PRIMARY KEY(OrderID, PartID, SupplierID),
    FOREIGN KEY (OrderID) REFERENCES tblOrder (OrderID),
    FOREIGN KEY (PartID) REFERENCES tblPart(PartID),
    FOREIGN KEY (SupplierID) REFERENCES tblSupplier(SupplierID)
);
CREATE TABLE tblZoneCountry ( 
    [ZoneID] INT NOT NULL,
    [CountryID] INT NOT NULL,
    PRIMARY KEY(ZoneID, CountryID),
    FOREIGN KEY (ZoneID) REFERENCES tblZone (ZoneID),
    FOREIGN KEY (CountryID) REFERENCES tblCountry(CountryID)
);
CREATE TABLE tblZoneCondition (
    [ZoneID] INT NOT NULL,
    [ConditionID] INT NOT NULL,
    PRIMARY KEY(ZoneID, ConditionID),
    FOREIGN KEY (ZoneID) REFERENCES tblZone (ZoneID),
    FOREIGN KEY (ConditionID) REFERENCES tblCondition(ConditionID)
);
CREATE TABLE tblSubscriptionZone (
    [SubscriptionID] INT NOT NULL,
    [ZoneID] INT NOT NULL,
    PRIMARY KEY(SubscriptionID, ZoneID),
    FOREIGN KEY (SubscriptionID) REFERENCES tblSubscription (SubscriptionID),
    FOREIGN KEY (ZoneID) REFERENCES tblZone(ZoneID)
);
CREATE TABLE tblSubscriptionBTDatabox (
    [SubscriptionID] INT NOT NULL,
    [BTDataboxID] INT NOT NULL,
    PRIMARY KEY(SubscriptionID, BTDataboxID),
    FOREIGN KEY (SubscriptionID) REFERENCES tblSubscription (SubscriptionID),
    FOREIGN KEY (BTDataboxID) REFERENCES tblBTDatabox(BTDataboxID)
);
CREATE TABLE tblContract (
    [ContractID] INT IDENTITY PRIMARY KEY,
    [StartDate] DATE NOT NULL,
    [EndDate] DATE,
    [Value] INT NOT NULL,
    [Contractee] INT NOT NULL,
    [EnteredByAdmin] INT NOT NULL,
    FOREIGN KEY (Contractee) REFERENCES tblContractee (ContracteeID),
    FOREIGN KEY (EnteredByAdmin) REFERENCES tblAdministrationExecutive(AdminExecID)
);
CREATE TABLE tblContractedBTDatabox (
    [ContractID] INT NOT NULL,
    [BTDataboxID] INT NOT NULL,
    PRIMARY KEY(ContractID, BTDataboxID),
    FOREIGN KEY (ContractID) REFERENCES tblContract (ContractID),
    FOREIGN KEY (BTDataboxID) REFERENCES tblBTDatabox(BTDataboxID)
);
CREATE TABLE tblContractedZone (
    [ContractID] INT NOT NULL,
    [ZoneID] INT NOT NULL,
    PRIMARY KEY(ContractID, ZoneID),
    FOREIGN KEY (ContractID) REFERENCES tblContract (ContractID),
    FOREIGN KEY (ZoneID) REFERENCES tblZone(ZoneID)
);
CREATE TABLE tblContractScientificData (
    [ContractID] INT NOT NULL,
    [ScientificDataID] INT NOT NULL,
    PRIMARY KEY(ContractID, ScientificDataID),
    FOREIGN KEY (ContractID) REFERENCES tblContract (ContractID),
    FOREIGN KEY (ScientificDataID) REFERENCES tblScientificData(ScientificDataID)
);
CREATE TABLE tblOwnsDataRights (
    [ScientificDataID] INT NOT NULL,
    [PlatinumID] INT NOT NULL,
    PRIMARY KEY(ScientificDataID, PlatinumID),
    FOREIGN KEY (ScientificDataID) REFERENCES tblScientificData (ScientificDataID),
    FOREIGN KEY (PlatinumID) REFERENCES tblPlatinum(PlatinumID)
);
CREATE TABLE tblOwnsVideoRights (
    [StreamID] INT NOT NULL,
    [SuperPlaintumID] INT NOT NULL,
    PRIMARY KEY(StreamID, SuperPlaintumID),
    FOREIGN KEY (StreamID) REFERENCES tblVideoStream (StreamID),
    FOREIGN KEY (SuperPlaintumID) REFERENCES tblSuperPlatinum(SuperPlaintumID)
);

end;
go

EXEC createDBAbsloutlyBeingThere;

DROP PROCEDURE IF EXISTS InsertTestData;
GO

CREATE PROCEDURE InsertTestData
AS
BEGIN

INSERT INTO tblCountry
VALUES 
('Andorra'),
('United Arab Emirates'),
('Afghanistan'),
('Antigua and Barbuda'),
('Anguilla'),
('Albania'),
('Armenia'),
('Netherlands Antilles'),
('Angola'),
('Antarctica'),
('Argentina'),
('American Samoa'),
('Austria'),
('Australia'),
('Aruba'),
('Azerbaijan'),
('Bosnia and Herzegovina'),
('Barbados'),
('Bangladesh'),
('Belgium'),
('Burkina Faso'),
('Bulgaria'),
('Bahrain'),
('Burundi'),
('Benin'),
('Bermuda'),
('Brunei'),
('Bolivia'),
('Brazil'),
('Bahamas'),
('Bhutan'),
('Bouvet Island'),
('Botswana'),
('Belarus'),
('Belize'),
('Canada'),
('Cocos [Keeling] Islands'),
('Congo [DRC]'),
('Central African Republic'),
('Congo [Republic]'),
('Switzerland'),
('Côte d Ivoire'),
('Cook Islands'),
('Chile'),
('Cameroon'),
('China'),
('Colombia'),
('Costa Rica'),
('Cuba'),
('Cape Verde'),
('Christmas Island'),
('Cyprus'),
('Czech Republic'),
('Germany'),
('Djibouti'),
('Denmark'),
('Dominica'),
('Dominican Republic'),
('Algeria'),
('Ecuador'),
('Estonia'),
('Egypt'),
('Western Sahara'),
('Eritrea'),
('Spain'),
('Ethiopia'),
('Finland'),
('Fiji)'),
('Falkland Islands [Islas Malvinas]'),
('Micronesia'),
('Faroe Islands'),
('France'),
('Gabon'),
('United Kingdom'),
('Grenada'),
('Georgia'),
('French Guiana'),
('Guernsey'),
('Ghana'),
('Gibraltar'),
('Greenland'),
('Gambia'),
('Guinea'),
('Guadeloupe'),
('Equatorial Guinea'),
('Greece'), 
('South Georgia and the South Sandwich Islands'),
('Guatemala'),
('Guam'),
('GuineaBissau'),
('Guyana'),
('Gaza Strip'),
('Hong Kong'),
('Heard Island and McDonald Islands'),
('Honduras'),
('Croatia'),
('Haiti'),
('Hungary'),
('Indonesia'),
('Ireland'),
('Israel'),
('Isle of Man'),
('India'),
('British Indian Ocean Territory'),
('Iraq'),
('Iran'),
('Iceland'),
('Italy'),
('Jersey'),
('Jamaica'),
('Jordan'),
('Japan'),
('Kenya'),
('Kyrgyzstan'),
('Cambodia'),
('Kiribati'),
('Comoros'),
('Saint Kitts and Nevis'),
('North Korea'),
('South Korea'),
('Kuwait'),
('Cayman Islands'),
('Kazakhstan'),
('Laos'),
('Lebanon'),
('Saint Lucia'),
('Liechtenstein'),
('Sri Lanka'),
('Liberia'),
('Lesotho'),
('Lithuania'),
('Luxembourg'),
('Latvia'),
('Libya'),
('Morocco'),
('Monaco'),
('Moldova'),
('Montenegro'),
('Madagascar'),
('Marshall Islands'),
('Macedonia [FYROM]'),
('Mali'),
('Myanmar [Burma]'),
('Mongolia'),
('Macau'),
('Northern Mariana Islands'),
('Martinique'),
('Mauritania'),
('Montserrat'),
('Malta'),
('Mauritius'),
('Maldives'),
('Malawi'),
('Mexico'),
('Malaysia'),
('Mozambique'),
('Namibia'),
('New Caledonia'),
('Niger'),
('Norfolk Island'),
('Nigeria'),
('Nicaragua'),
('Netherlands'),
('Norway'),
('Nepal'),
('Nauru'),
('Niue'),
('New Zealand'),
('Oman'),
('Panama'),
('Peru'),
('French Polynesia'),
('Papua New Guinea'),
('Philippines'),
('Pakistan'),
('Poland'),
('Saint Pierre and Miquelon'),
('Pitcairn Islands'),
('Puerto Rico'),
('Palestinian Territories'),
('Portugal'),
('Palau'),
('Paraguay'),
('Qatar'),
('Réunion'),
('Romania'),
('Serbia'),
('Russia'),
('Rwanda'),
('Saudi Arabia'),
('Solomon Islands'),
('Seychelles'),
('Sudan'),
('Sweden'),
('Singapore'),
('Saint Helena'),
('Slovenia'),
('Svalbard and Jan Mayen'),
('Slovakia'),
('Sierra Leone'),
('San Marino'),
('Senegal'),
('Somalia'),
('Suriname'),
('São Tomé and Príncipe'),
('El Salvador'),
('Syria'),
('Swaziland'),
('Turks and Caicos Islands'),
('Chad'),
('French Southern Territories'),
('Togo'),
('Thailand'),
('Tajikistan'),
('Tokelau'),
('TimorLeste'),
('Turkmenistan'),
('Tunisia'),
('Tonga'),
('Turkey'),
('Trinidad and Tobago'),
('Tuvalu'),
('Taiwan'),
('Tanzania'),
('Ukraine'),
('Uganda'),
('U.S. Minor Outlying Islands'),
('United States'),
('Uruguay'),
('Uzbekistan'),
('Vatican City'),
('Saint Vincent and the Grenadines'),
('Venezuela'),
('British Virgin Islands'),
('U.S. Virgin Islands'),
('Vietnam'),
('Vanuatu'),
('Wallis and Futuna'),
('Samoa'),
('Kosovo'),
('Yemen'),
('Mayotte'),
('South Africa'),
('Zambia'),
('Zimbabwe');

INSERT INTO tblZone
VALUES
(180, 120, 90, 60),
(119, 60, 60, 30),
(59, 0, 30, 0),
(1, 60, 0, 30),
(61, 120, 30, 60),
(121, 180, 60, 90),
(181, 240, 90, 120),
(241, 300, 120, 150),
(301, 360, 150, 180);

INSERT INTO tblCondition
VALUES
('Jungle', 'A jungle is land covered with dense forest and tangled vegetation, usually in hot climates'),
('Forest', 'A forest is a large area dominated by trees'),
('Savannah', 'A savannah is a mixed woodlandgrassland ecosystem characterised by the trees being sufficiently widely spaced so that the canopy does not close. The open canopy allows sufficient light to reach the ground to support a herbaceous layer of grasses'),
('Ice and Snow (extreme cold)', 'burr, cold'),
('Deserts', 'A desert is a barren area of landscape where little precipitation occurs and, consequently, living conditions are hostile for plant and animal life'),
('Urban', 'An urban area, or builtup area, is a human settlement with a high population density and infrastructure of built environment');

INSERT INTO tblDirector
VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10);

INSERT INTO tblAdministrationExecutive
VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10);

INSERT INTO tblSalesperson 
VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10);

INSERT INTO tblMaintenanceperson 
VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10);

INSERT INTO tblStaff 
VALUES 
('$2059.06', 'Libbey Karpe', '12/24/2019', null),
('$1123.93', 'Brent Siemantel', '9/9/2019', null),
('$3822.34', 'Abigale Kassel', '12/30/2019', null),
('$2394.02', 'Tedie Werner', '9/21/2019', null),
('$3774.69', 'Walther Menco', '4/11/2020', null),
('$2621.30', 'Idelle Rathjen', '11/19/2019', null),
('$2040.69', 'Wheeler Imlaw', '1/19/2020', null),
('$3572.57', 'Merrilee Huscroft', '7/11/2019', null),
('$1717.76', 'Samson Merigeau', '2/16/2020', null),
('$1768.98', 'Helen Elders', '7/5/2019', null),
('$3589.03', 'Guillermo Espinoy', '1/9/2020', null),
('$2506.45', 'Jamie Brayn', '3/9/2020', null),
('$1308.20', 'Ferrell Spinola', '8/14/2019', '6/4/2020'),
('$3491.55', 'Zolly Mingame', '9/21/2019', null),
('$2318.56', 'Ashil Crenshaw', '11/19/2019', null),
('$2234.02', 'Lin Nestoruk', '1/5/2020', null),
('$1439.19', 'Codie Croom', '11/11/2019', null),
('$1995.89', 'Meyer Swalteridge', '2/11/2020', null),
('$3855.36', 'Arleyne Weatherley', '3/2/2020', '4/28/2019'),
('$1339.22', 'Rorie Cutill', '10/16/2019', null),
('$3354.00', 'Kellia Mallam', '9/1/2019', null),
('$3289.49', 'Palm Adlem', '10/23/2019', null),
('$3594.88', 'Katina Niesel', '3/29/2020', null),
('$1207.01', 'Maurine Atkirk', '11/8/2019', '7/18/2019'),
('$2006.58', 'Elwira Natte', '3/31/2020', null),
('$3810.86', 'Petronilla Victoria', '1/20/2020', null),
('$1301.19', 'Von Costall', '7/6/2019', '3/20/2020'),
('$2178.34', 'Dolph Purple', '2/20/2020', null),
('$2036.82', 'Redd Sapson', '3/22/2020', null),
('$1697.82', 'Minerva Brownstein', '11/3/2019', '10/24/2019'),
('$2669.64', 'Briano Forsbey', '1/23/2020', '7/8/2019'),
('$3768.56', 'Sydelle Fantonetti', '9/14/2019', null),
('$3596.34', 'Dennie Langelay', '10/6/2019', null),
('$3537.10', 'Arda Hynard', '1/6/2020', null);

INSERT INTO tblScientificData 
VALUES 
(61.344385, 15.38447, 613, 33.61, 33.8391, '20191106 11:41:47'),
(40.6854309, 14.5656065, 1785, 35.0, 56.4677, '20191001 21:04:52'),
(111.8749872, 33.3107008, 3836, 37.57, 65.1923, '20200406 15:19:02'),
(121.0143656, 14.5788472, 3146, 37.95, 99.9618, '20190621 01:04:13'),
(126.09611, 39.1425, 1891, 4.61, 36.111, '20190801 13:42:54'),
(17.5860395, 52.8818616, 3897, 21.61, 47.1164, '20190928 11:56:18'),
(103.5083998, 16.4311476, 3422, 15.35, 44.6682, '20190419 20:03:57'),
(36.0199456, 52.2820161, 2548, 36.7, 80.1538, '20191024 01:16:09'),
(43.2923971, 52.0379571, 2584, 43.79, 4.9143, '20200122 07:46:55'),
(114.8864193, 8.2735418, 1500, 30.77, 47.8682, '20200425 02:25:10'),
(87.0218192, 13.649619, 1421, 30.55, 20.2546, '20191010 19:21:38'),
(6.6304104, 6.6687831, 3779, 44.37, 38.3524, '20200109 20:34:11'),
(99.1788304, 1.6258482, 2142, 32.82, 11.4071, '20191217 08:06:41'),
(111.7910758, 23.1421682, 673, 31.41, 5.6212, '20191226 05:29:09'),
(117.223371, 39.109563, 69, 30.34, 29.6488, '20200103 14:05:59'),
(138.9099913, 37.6533531, 93, 15.46, 59.0069, '20191124 06:07:36'),
(8.9052753, 39.8647755, 2232, 43.72, 18.567, '20190918 14:58:46'),
(2.8797149, 42.6962642, 40, 2.43, 13.5799, '20191112 21:27:20'),
(77.4, 10.116667, 3256, 35.29, 23.4515, '20200327 22:04:52'),
(109.0771185, 7.5109156, 2040, 17.61, 64.3759, '20200606 21:28:54'),
(97.3580243, 57.4492483, 3704, 22.64, 60.5233, '20190419 13:40:49'),
(4.6419648, 52.3811357, 2052, 44.57, 57.4696, '20200221 11:14:28'),
(27.993441, 8.303998, 1076, 14.64, 21.0222, '20191103 14:34:38'),
(87.271781, 26.6646381, 712, 43.44, 12.1456, '20200412 08:44:50'),
(116.3397725, 39.9947462, 2764, 29.56, 72.3546, '20191016 03:00:36'),
(117.1168644, 36.1899557, 415, 20.49, 19.0755, '20191012 00:26:32'),
(121.637093, 16.9905258, 1692, 18.66, 83.5346, '20200411 22:15:23'),
(20.4489216, 44.786568, 777, 20.05, 27.1383, '20190624 22:26:30'),
(118.865506, 8.6965738, 1488, 2.77, 0.9739, '20200527 03:41:21'),
(69.1447081, 35.4018071, 3342, 15.49, 76.9254, '20200429 15:21:04'),
(42.1917995, 21.4138052, 3881, 7.57, 8.8044, '20191021 10:13:01'),
(54.0068191, 46.9691061, 64, 41.36, 20.2835, '20191021 22:11:18'),
(22.3956933, 39.7219085, 1349, 40.03, 41.6449, '20200410 07:18:13'),
(66.8081979, 2.7005604, 2184, 20.14, 16.8153, '20190808 22:10:36'),
(5.2057909, 7.2571325, 2180, 43.84, 88.0093, '20190724 09:58:57'),
(106.5618306, 6.2434343, 3901, 20.74, 8.9846, '20200111 12:13:27'),
(111.0654148, 6.6018462, 1115, 11.24, 70.8874, '20190710 06:45:52'),
(113.12873, 29.356803, 3226, 38.28, 75.6498, '20191104 23:26:13'),
(50.8076496, 59.3119146, 3448, 18.07, 40.9941, '20200320 17:59:01'),
(84.3368699, 9.834321, 3657, 1.53, 1.111, '20190914 22:37:10'),
(135.1145437, 44.2636981, 3327, 36.13, 71.7755, '20200201 00:34:05'),
(133.9326833, 44.348809, 2595, 4.78, 63.9479, '20190430 21:07:12'),
(106.0155278, 6.3855073, 1708, 19.13, 2.9182, '20190810 20:28:27'),
(77.142764, 38.8822689, 2774, 41.12, 57.6838, '20200224 04:16:15'),
(0.2075745, 48.0885087, 1127, 37.62, 97.554, '20200321 03:18:32'),
(7.6589255, 37.6410379, 3589, 26.69, 42.0944, '20200505 03:45:49'),
(7.5345759, 41.2218624, 441, 41.79, 13.7593, '20191225 15:31:27'),
(57.1576821, 55.556613, 793, 25.21, 15.8915, '20190715 03:10:15'),
(9.3964878, 38.9426594, 855, 41.13, 36.2168, '20190621 21:48:24'),
(14.271615, 55.9858675, 1523, 9.98, 54.3289, '20190702 02:56:17'),
(2.281825, 48.7276331, 3690, 14.54, 21.1736, '20190701 14:06:50'),
(114.288097, 8.4425528, 2336, 24.04, 80.8521, '20190623 08:36:59'),
(61.344385, 15.38447, 613, 33.61, 33.8391, '20191106 11:41:47'),
(40.6854309, 14.5656065, 1785, 35.0, 56.4677, '20191001 21:04:52'),
(111.8749872, 33.3107008, 3836, 37.57, 65.1923, '20200406 15:19:02'),
(121.0143656, 14.5788472, 3146, 37.95, 99.9618, '20190621 01:04:13'),
(126.09611, 39.1425, 1891, 4.61, 36.111, '20190801 13:42:54'),
(17.5860395, 52.8818616, 3897, 21.61, 47.1164, '20190928 11:56:18'),
(103.5083998, 16.4311476, 3422, 15.35, 44.6682, '20190419 20:03:57'),
(36.0199456, 52.2820161, 2548, 36.7, 80.1538, '20191024 01:16:09'),
(43.2923971, 52.0379571, 2584, 43.79, 4.9143, '20200122 07:46:55'),
(114.8864193, 8.2735418, 1500, 30.77, 47.8682, '20200425 02:25:10'),
(119.996847, 29.454189, 1918, 3.92, 72.5993, '20190910 09:08:56'),
(13.2772423, 49.7030481, 1499, 6.35, 3.3953, '20190619 03:44:12'),
(122.7924488, 7.8395214, 2395, 3.7, 20.9331, '20200123 19:17:28'),
(120.3089541, 3.3472662, 561, 15.85, 64.6498, '20190711 13:29:08'),
(70.5552362, 37.1017088, 2605, 8.43, 33.3975, '20190831 11:06:07'),
(104.100502, 1.259553, 3209, 5.73, 26.7796, '20190724 09:22:37'),
(56.7664844, 27.1435718, 448, 27.5, 33.5449, '20191106 20:11:00'),
(49.3164138, 25.1860913, 1435, 23.07, 19.116, '20190928 08:06:15'),
(15.4377229, 53.1675674, 1176, 36.79, 48.3454, '20190823 14:02:55'),
(73.840258, 8.588397, 237, 20.23, 72.8114, '20200416 22:12:00'),
(89.982425, 29.222417, 2105, 6.62, 97.1202, '20191122 17:26:15'),
(113.366904, 22.948016, 874, 12.81, 34.4266, '20200428 15:48:54'),
(18.1543922, 50.1327056, 3978, 27.34, 37.4493, '20190702 23:21:23'),
(51.3238273, 30.1090924, 2240, 7.16, 57.9138, '20191112 13:38:13'),
(5.8875346, 49.7663957, 3630, 22.66, 44.2508, '20191123 19:36:16'),
(5.868937, 45.644535, 1004, 14.31, 3.5978, '20190924 14:05:05'),
(43.6510502, 52.9918299, 3310, 22.02, 75.9979, '20190702 21:19:45'),
(128.2579205, 35.474465, 797, 24.11, 55.1669, '20190605 10:46:10'),
(116.3426552, 2.7540915, 2568, 17.57, 71.9358, '20200326 19:47:08'),
(44.0519756, 40.106025, 290, 4.83, 53.9396, '20190530 15:55:10'),
(37.29209, 53.7111077, 2569, 36.55, 38.0644, '20200316 09:02:31'),
(16.018026, 45.1458598, 679, 18.84, 10.969, '20200207 07:30:21'),
(73.3436918, 45.5257774, 3503, 37.77, 15.9893, '20190919 11:20:19'),
(124.423984, 8.2600716, 3319, 18.72, 7.1388, '20200414 10:51:52'),
(114.758301, 27.859517, 3012, 11.65, 67.6484, '20190910 04:06:07'),
(38.4094028, 46.7604507, 3653, 27.85, 30.5747, '20200117 20:12:51'),
(123.5983638, 13.1487371, 933, 14.11, 22.1995, '20200127 07:08:15'),
(87.6075294, 14.6276215, 3004, 9.02, 83.071, '20200104 14:24:20'),
(15.2359979, 46.1542793, 2810, 44.26, 29.0655, '20191221 03:44:10'),
(73.6386612, 54.5859873, 2005, 15.7, 96.2824, '20191224 01:33:30'),
(35.0843, 32.433378, 1193, 11.99, 68.1125, '20190826 09:24:32'),
(25.5783873, 49.5290136, 107, 4.59, 74.0914, '20190531 22:19:46'),
(11.3317605, 2.1514272, 834, 39.44, 17.7495, '20190923 17:11:35'),
(60.6923382, 32.9285798, 1833, 42.69, 27.8569, '20191023 02:18:31'),
(110.18122, 22.654032, 1462, 15.08, 76.5179, '20200106 03:15:47'),
(85.693742, 46.089148, 2465, 32.34, 32.826, '20190925 01:15:24'),
(8.6441655, 40.5740471, 35, 8.06, 66.2182, '20190916 08:48:33'),
(99.397126, 23.538092, 1326, 12.07, 6.3024, '20191230 05:24:31');

INSERT INTO tblBTDatabox 
VALUES 
('20191125 12:00:08', '5/26/2021', '67'),
('20190810 20:37:59', '7/30/2021', '53'),
('20200124 11:58:42', '8/3/2021', '33'),
('20191226 02:20:21', '10/28/2021', '24'),
('20191222 13:06:14', '11/2/2020', '44'),
('20200531 08:10:34', '1/18/2022', '43'),
('20190625 18:13:09', '1/4/2021', '34'),
('20190809 18:54:52', '6/26/2020', '66'),
('20190814 15:45:50', '5/30/2021', '48'),
('20190821 00:52:21', '3/11/2022', '28'),
('20190704 15:53:39', '7/4/2020', '48'),
('20200527 05:18:08', '2/19/2022', '47'),
('20191203 19:19:07', '4/18/2022', '66'),
('20191009 13:37:34', '4/8/2022', '24'),
('20190629 01:32:00', '7/2/2020', '44'),
('20200310 13:44:39', '5/12/2022', '33'),
('20200514 22:19:47', '6/8/2021', '55'),
('20200507 08:23:44', '11/18/2020', '56'),
('20200610 12:04:53', '1/17/2021', '32'),
('20200512 14:43:18', '6/12/2022', '22'),
('20200426 22:55:25', '4/30/2022', '45'),
('20200326 15:06:21', '7/3/2021', '43'),
('20190718 10:30:52', '11/29/2021', '42'),
('20200111 01:00:20', '9/29/2020', '44'),
('20190710 17:22:38', '6/24/2020', '66'),
('20200406 06:25:15', '8/28/2020', '68'),
('20190629 03:15:13', '3/7/2021', '44'),
('20200430 06:54:57', '11/27/2020', '55'),
('20190726 19:47:33', '3/4/2021', '67');

INSERT INTO tblPart
VALUES 
('dolor', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis. Duis consequat nec nisi volutpat eleifend.', '$241.74'),
('lobortis', 'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget vulputate ut ultrices augue.', '$92.49'),
('in', 'Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue.', '$838.14'),
('ac', 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy.', '$477.70'),
('proin', 'Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.', '$541.06'),
('sapien', 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit.', '$937.18'),
('ac', 'Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', '$116.94'),
('ut', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo.', '$784.87'),
('mi', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.', '$531.67'),
('blandit', 'Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh.', '$464.26'),
('porttitor', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis.', '$163.40'),
('velit', 'Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit.', '$943.32'),
('ut', 'Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh.', '$936.99'),
('nulla', 'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum.', '$646.30'),
('et', 'Etiam vel augue. Vestibulum rutrum rutrum neque.', '$110.91'),
('ridiculus', 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh. In quis justo.', '$448.08'),
('tristique', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc.', '$322.69'),
('eros', 'Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', '$579.91'),
('eu', 'Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum.', '$486.45'),
('diam', 'Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.', '$518.03');

INSERT INTO tblVideoStream (StartTime, EndTime)
VALUES
('2020-04-01T08:16:59.000', '2019-12-08T17:03:15.000'),
('2019-08-21T07:18:49.000', '2020-04-24T18:13:53.000'),
('2019-09-24T15:09:16.000', '2020-05-18T21:49:41.000'),
('2020-03-12T05:02:06.000', '2020-03-01T18:30:47.000'),
('2020-04-25T08:59:49.000', '2020-05-12T12:52:11.000'),
('2020-04-08T09:44:19.000', '2019-08-21T12:03:47.000'),
('2019-08-11T20:38:30.000', '2019-11-08T22:48:55.000'),
('2019-09-04T12:03:02.000', '2019-08-21T20:19:57.000'),
('2020-03-24T22:03:02.000', '2019-09-12T12:30:45.000'),
('2019-09-11T15:50:39.000', '2019-10-24T22:37:24.000'),
('2020-05-26T06:10:58.000', '2019-08-19T03:19:37.000'),
('2020-04-04T15:52:17.000', '2019-12-12T07:05:48.000'),
('2020-02-25T07:21:05.000', '2019-08-01T17:56:03.000'),
('2019-12-13T23:55:27.000', '2020-02-03T08:17:28.000'),
('2019-09-24T13:21:21.000', '2019-07-16T17:26:49.000'),
('2019-12-09T08:36:07.000', '2019-12-30T20:34:34.000'),
('2020-02-23T19:50:28.000', '2019-07-11T16:21:23.000'),
('2020-06-08T13:57:23.000', '2019-08-23T21:29:32.000'),
('2020-01-28T05:13:47.000', '2020-04-08T15:56:08.000'),
('2020-04-01T14:11:23.000', '2020-01-17T05:34:01.000'),
('2020-01-22T11:11:28.000', '2020-01-04T23:34:22.000'),
('2020-02-27T03:40:58.000', '2020-03-27T05:46:51.000'),
('2019-08-24T17:49:50.000', '2019-08-26T16:55:46.000'),
('2019-12-13T00:18:00.000', '2019-06-26T00:44:18.000'),
('2020-02-02T00:17:20.000', '2020-05-20T18:43:42.000'),
('2019-10-29T00:24:50.000', '2020-01-05T09:39:55.000'),
('2020-03-18T09:21:26.000', '2019-08-06T01:10:57.000'),
('2019-06-10T11:36:02.000', '2020-04-24T10:55:40.000'),
('2019-08-20T22:44:49.000', '2019-11-03T17:36:26.000'),
('2019-10-05T21:03:03.000', '2019-07-06T17:55:27.000'),
('2020-04-21T07:48:02.000', '2019-08-10T14:25:39.000'),
('2020-05-27T03:55:16.000', '2020-01-28T11:18:05.000');

INSERT INTO tblPostCode
VALUES 
(67314, 'Karangpete', 11),
(52180, 'San Isidro', 46),
(71712, 'Karasuk', 46),
(83125, 'Sorol', 25),
(53894, 'Valejas', 150),
(49290, 'Paoua', 83),
(84182, 'Trới', 172),
(83986, 'Ja Ela', 141),
(18351, 'Chapelton', 25),
(73295, 'Dawu Chengguanzhen', 47),
(53317, 'Dijon', 88),
(68844, 'Pingyang', 12),
(97441, 'Inanwatan', 158),
(9272, 'Koronadal', 36),
(21108, 'Bistrica ob Sotli', 63),
(29045, 'Maslovka', 159),
(86201, 'Babakan', 28),
(14176, 'Besukrejo', 124),
(55296, 'Huskvarna', 48),
(30667, 'Karlstad', 175),
(65907, 'Maymana', 131),
(31553, 'Tunzhai', 80),
(56429, 'Yunmenling', 58),
(92831, 'Águas Belas', 1),
(54927, 'Xuezhen', 55),
(55308, 'Morbatoh', 174),
(40668, 'Daultāla', 52),
(2092, 'Londiani', 90),
(54717, 'Brody', 151),
(60544, 'Akron', 65),
(80213, 'Shilu', 151),
(45592, 'Kosaya Gora', 158),
(70917, 'Xiaogang', 100),
(3250, 'Selorejo', 166),
(15793, 'Frösön', 142),
(72238, 'Yuetang', 1),
(80506, 'Miami', 145),
(72806, 'Kalidawe', 172),
(12674, 'Colón', 10),
(80447, 'Borovskiy', 163),
(88296, 'Cimalati', 38),
(74508, 'Alah Sāy', 97),
(28508, 'Aleksandrovka', 51),
(46281, 'San Buenaventura', 149),
(56492, 'Dzyatlava', 8),
(7918, 'Macapá', 122),
(31680, 'Baiqiao', 40),
(31604, 'Magok', 52),
(36561, 'Tangchi', 140),
(86451, 'Berlin', 2),
(97488, 'Liangjing', 88),
(27291, 'Simo', 42),
(85744, 'Xinjian', 84),
(5150, 'Sungaipuntik', 4),
(9192, 'Randusari', 28),
(37751, 'Chyżne', 174),
(36223, 'São Torcato', 54),
(7780, 'Douba', 92),
(28799, 'Tongqing', 152),
(40227, 'Phra Phrom', 38),
(15303, 'Biruinţa', 36),
(74392, 'Cisompet', 114),
(54178, 'Mineiros', 25),
(20541, 'Maribong', 35),
(55062, 'CherbourgOcteville', 151),
(83222, 'Erechim', 140),
(38795, 'Dajie', 64),
(32294, 'Chernukha', 79),
(44525, 'Hartford', 115),
(53364, 'Ambo Village', 5),
(97353, 'Yucun', 101),
(65776, 'Łagów', 60),
(15416, 'Saraktash', 82),
(85037, 'Pontivy', 60),
(98722, 'Ujung', 156),
(71517, 'Bamenda', 124),
(29650, 'Baikouquan', 109),
(99921, 'Rogachëvo', 78),
(95503, 'Situbondo', 176),
(40732, 'Jiangti', 55),
(26938, 'Rozkishne', 27),
(64538, 'Dolní Cerekev', 147),
(27298, 'Juigalpa', 123),
(83587, 'Qianpai', 146),
(53556, 'Pasararba', 6),
(1009, 'Khairpur Nathan Shāh', 178),
(29675, 'Pruzhany', 105),
(50061, 'Çlirim', 142),
(33082, 'Ostrožac', 52),
(16102, 'Barwałd Górny', 66),
(42361, 'Diawara', 83),
(81369, 'Hulei', 1),
(23519, 'Wat Sing', 128),
(37410, 'Jammāl', 161),
(6109, 'Martigues', 3),
(67337, 'Anau', 130),
(10607, 'Swift Current', 139),
(1662, 'Abha', 106),
(80745, 'Aserrí', 42),
(9789, 'Canguçu', 69);

INSERT INTO tblAddress 
VALUES
(null, 13, 'Arizona Drive', 1),
(null, 23, 'Granby Terrace', 2),
(null, 26, 'Kingsford Street', 3),
(10, 49, 'Linden Pass', 4),
(8, 75, 'Kedzie Trail', 5),
(null, 92, 'Melody Hill', 6),
(null, 97, 'Scott Trail', 7),
(null, 84, 'Gina Hill', 8),
(null, 68, 'Vera Lane', 9),
(null, 99, 'Magdeline Trail', 10),
(null, 31, 'Sundown Pass', 11),
(6, 3, 'Golf Course Hill', 12),
(null, 84, 'Gale Avenue', 13),
(null, 68, 'Lakewood Alley', 14),
(null, 14, 'Sommers Court', 15),
(null, 11, 'Daystar Hill', 16),
(null, 69, 'Northfield Parkway', 17),
(null, 56, 'Ohio Drive', 18),
(null, 29, 'Loeprich Point', 19),
(null, 65, 'Vahlen Alley', 20),
(null, 26, 'Carberry Center', 21),
(null, 35, 'Center Pass', 22),
(null, 34, 'Superior Circle', 23),
(4, 58, 'Chinook Plaza', 24),
(null, 50, 'Donald Court', 25),
(null, 83, 'Lillian Court', 26),
(null, 44, 'Claremont Crossing', 27),
(null, 30, 'Nobel Plaza', 28),
(null, 31, 'Thierer Pass', 29),
(null, 24, 'Dunning Court', 30),
(null, 36, 'Riverside Crossing', 31),
(null, 24, 'Mitchell Trail', 32),
(null, 48, 'Mayfield Center', 33),
(null, 27, 'Elmside Drive', 34),
(null, 9, 'Bunting Road', 35),
(null, 99, 'Roxbury Way', 36),
(null, 23, 'Eastlawn Alley', 37),
(null, 75, 'Randy Pass', 38),
(2, 80, 'Chinook Terrace', 39),
(null, 12, 'Rutledge Parkway', 40),
(null, 96, 'Esker Junction', 41),
(null, 1, 'Hoffman Park', 42),
(8, 94, 'Marquette Parkway', 43),
(null, 71, 'Clyde Gallagher Hill', 44),
(null, 56, 'Westport Avenue', 45),
(null, 58, 'Butterfield Avenue', 46),
(null, 24, 'Stoughton Plaza', 47),
(5, 50, 'Express Lane', 48),
(null, 41, 'Stoughton Center', 49),
(null, 71, 'Chive Drive', 50),
(3, 52, 'Jay Drive', 51),
(null, 1, 'Mockingbird Pass', 52),
(3, 38, 'Old Shore Street', 53),
(null, 15, 'Iowa Trail', 54),
(null, 90, 'Norway Maple Place', 55),
(null, 14, 'Waxwing Drive', 56),
(null, 22, 'Weeping Birch Alley', 57),
(9, 91, 'Surrey Junction', 58),
(null, 34, 'Schiller Road', 59),
(null, 97, 'Debra Plaza', 60),
(null, 9, 'Washington Point', 61),
(null, 42, 'Comanche Point', 62),
(null, 44, 'Oneill Junction', 63),
(null, 37, 'Clove Court', 64),
(null, 76, 'Miller Trail', 65),
(null, 18, 'Luster Trail', 66),
(null, 23, 'Hoard Circle', 67),
(null, 86, 'Mayer Pass', 68),
(null, 52, 'Ridgeway Drive', 69),
(null, 26, 'Eagle Crest Trail', 70),
(null, 19, 'Duke Point', 71),
(null, 56, 'Schurz Plaza', 72),
(null, 55, 'Fisk Place', 73),
(null, 4, 'Nancy Parkway', 74),
(null, 100, '1st Circle', 75),
(null, 90, 'Mockingbird Way', 76),
(null, 11, 'Johnson Road', 77),
(null, 37, 'Stephen Court', 78),
(null, 45, 'Corry Trail', 79),
(null, 18, 'Westend Trail', 80),
(6, 41, 'Village Green Avenue', 81),
(null, 8, 'Dunning Avenue', 82),
(null, 80, 'Crowley Way', 83),
(null, 22, 'Shoshone Park', 84),
(null, 41, 'Vernon Place', 85),
(1, 41, 'Goodland Way', 86),
(9, 16, 'Northport Hill', 87),
(null, 91, 'Morning Lane', 88),
(4, 47, 'Stoughton Park', 89),
(null, 36, 'Lien Way', 90),
(null, 57, 'Hoepker Court', 91),
(null, 90, 'Loftsgordon Avenue', 92),
(1, 84, 'Brentwood Avenue', 93),
(null, 49, 'Toban Point', 94),
(null, 83, 'Scott Avenue', 95),
(null, 77, 'Algoma Plaza', 96),
(null, 18, 'Little Fleur Crossing', 97),
(null, 68, 'La Follette Circle', 98),
(1, 54, 'Rutledge Terrace', 99),
(null, 33, 'American Place', 100),
(7, 7, 'Memorial Trail', 1),
(null, 22, 'Eliot Junction', 2),
(null, 24, 'Dexter Park', 3),
(null, 26, 'Mcguire Alley', 4),
(9, 4, 'Forest Parkway', 5),
(null, 15, 'Transport Plaza', 6),
(null, 14, 'Butternut Parkway', 7),
(5, 12, 'Sunnyside Trail', 8),
(null, 28, 'Caliangt Alley', 9),
(null, 8, 'Jackson Terrace', 10);

INSERT INTO tblSupplier 
VALUES 
('Green Group', 'Aeriel Muccino', 'amuccino0@nature.com', 1, '277-683-3219'),
('Marvin and Sons', 'Deonne Edinboro', 'dedinboro1@cam.ac.uk', 2, '675-387-2042'),
('Bartell Inc', 'Felice Lukehurst', 'flukehurst2@unicef.org', 3, '696-953-8554'),
('Shanahan-Gaylord', 'Gussie Purchon', 'gpurchon3@usda.gov', 4, '961-603-3930'),
('Gibson Group', 'Valerye Macoun', 'vmacoun4@soundcloud.com', 5, '970-756-5194'),
('Feil-Gibson', 'Skippie Braidley', 'sbraidley5@jiathis.com', 6, '390-239-6923'),
('Marvin LLC', 'Umberto Spink', 'uspink6@ebay.co.uk', 7, '220-162-2016'),
('Collier and Sons', 'Hewe Dametti', 'hdametti7@dot.gov', 8, '492-248-0624'),
('Parisian, Price and Keeling', 'Tamarah Dagwell', 'tdagwell8@mayoclinic.com', 9, '146-874-8866'),
('Becker, Lind and Keebler', 'Rog Stollwerk', 'rstollwerk9@dyndns.org', 10, '411-602-7021');

INSERT INTO tblAccount 
VALUES
('Idalina Innett', 'N4nZGS', 11, '6094099290'),
('Cherish Roches', 'rEhmEG7Q', 12, '1523343646'),
('Rafe Dobbins', '9H2sJ3A', 13, '9805390274'),
('Bird Pettengell', 'ziiuKTix0FH', 14, '6874812487'),
('Rozanne MacGall', '8uo7PdB', 15, '2655827752'),
('Benedikt Lockwood', '7KtxhQP9Ao', 16, '3347054959'),
('Maisey Hemshall', '7FaLgZt', 17, '2137447578'),
('Chrystal Shimony', 'WzY5UrV7', 18, '4136059712'),
('Malorie Saenz', 'YfApzsQhPnRg', 19, '6068283314'),
('Conrado Deelay', 'jzRHa6xh4rrA', 20, '7391668490'),
('Gloriana McSparran', '8mHQueb', 21, '3763695162'),
('Farlee Chaperling', 'iWDnyVnCKPAP', 22, '5911578077'),
('Turner Braidford', '8oXPfXR', 23, '8397077918'),
('Gaynor Baumert', 'xckEf3i', 24, '9207313273'),
('Sidonnie Scampion', '7vugRaZ7M', 25, '4041767670'),
('Ross Hanshaw', '2L6a4nD3rpw', 26, '5071482030'),
('Robbi Lamberti', 'qfXWtw', 27, '6997745510'),
('Cloris Reiach', 'Mcw6I0aD56o', 28, '5457898029'),
('Dominique Loeber', '9qAH4c', 29, '8564659453'),
('Clari Skipworth', 'VXJwYe', 30, '4516678839'),
('Devan McWhin', 'PFtZckWiS2jh', 31, '9569999908'),
('Laughton Kerfod', '6ZDkKvbcwL2', 32, '5484138944'),
('Tanner Mersey', 'vgwC4fjlBX', 33, '9639742360'),
('Bernie Millthorpe', 'HrkPOUXGpp', 34, '3458017119'),
('Hasty Kalberer', 'q9lq0w', 35, '1121271689'),
('Lynnette Boss', 'oH5Uin', 36, '8157563392'),
('Tom Moulden', 'MsEiPD', 37, '9934923717'),
('Major Blanchette', 'UkTPZhndhCR', 38, '1921229465'),
('Edna Vannuccini', 'GimkqJfAd5', 39, '6872067017'),
('Tarrah Wraggs', '1yUbWnPl2z', 40, '3555920270'),
('Brose Kristof', 'WTjDIYxzfDgF', 41, '6772572965'),
('Lonna Whitington', 'AfQf9CP9R', 42, '1508176387'),
('Juieta Vasilmanov', 'qvgxRA', 43, '2212354610'),
('Halette Kittiman', '2MVW2sUn2HEG', 44, '1919902900'),
('Blondelle Penberthy', 'LtL2VfUcCRnK', 45, '7387593765'),
('Hamlen Counihan', 'd3OnRgc6Ez', 46, '4826704066'),
('Deanne Cantillion', '9360WoLYg', 47, '8673060405'),
('Ricki Coopman', '3vyp7z876DlP', 48, '5283816268'),
('Farlee McWilliams', 'n544llFrK7q', 49, '4199116034'),
('Monika Albrook', 'dA4aKq5TA', 50, '4555964397'),
('Carissa Ausiello', 'acQmWuVzNTr', 51, '7629444607'),
('Pincas Mackerness', 'Lf8AJ1Ams6I', 52, '2681037977'),
('Ben Joincey', 'cYSn0COVkzB', 53, '4177465063'),
('Lorne McNeice', '41QQt9Cj9', 54, '4482161815'),
('Loutitia Lagen', 'ZZqKG996', 55, '2131867404'),
('Hollyanne McErlaine', 'AkKl8iYu', 56, '8454159602'),
('Tiphani Hawse', 'uZ6tk7QT', 57, '2805472217'),
('Larry Quarlis', 'KNQfCZKMLnL', 58, '9193406586'),
('Doria Dinsell', 'ZORQun', 59, '3267128911'),
('Ethelda Gogerty', '5tiEls3gxyMs', 60, '1024675646'),
('Charmain Moverley', '1U8txP25rL9H', 61, '1693816884'),
('Rriocard Eacott', 'QA3mnzUQ', 62, '4244093616'),
('Barney Shalders', 'DIZ8CxO', 63, '6142527262'),
('Culley Waggett', 'Vql9M0', 64, '8404422772'),
('Trudey Santon', '5stDaLI5nMW', 65, '1789988474'),
('Ambur Mazzia', 'zn0pBjin', 66, '7849468033'),
('Ogden Molden', 'Db11FF6CQVU', 67, '9162865039'),
('Iorgos O''Keenan', 'olj4lq', 68, '4327573784'),
('Andras Fray', 'bsfZDeEuV', 69, '4828387282'),
('Erek Olivetta', 'bFSXrERO', 70, '4992660812'),
('Alwin Shill', '3lXRe49sz', 71, '9898554398'),
('Norine Walshaw', 'H9zWvpy', 72, '4028926746'),
('Ellissa Brackenbury', 'cZfsiYMWJDs', 73, '4808060240'),
('Mab Castanie', 'XNVCls4XjQ0', 74, '3142606045'),
('Davidson Halladay', 'BMtkLvz7FRss', 75, '5204373048'),
('Lorens Erie', '8695784r1', 76, '4219971437'),
('Ruy Fenech', 'uoJjJ4pXvc', 77, '2005738970'),
('Marlow Geffen', '95rvuwzCU', 78, '7167213435'),
('Tybi Scarbarrow', 'MD54b4i96lDf', 79, '1743497052'),
('Eugen Arnall', 'Y7YZyiiHCL5E', 80, '7964788571'),
('Maddy Reide', 'TBcZK5hJ', 81, '2084984195'),
('Riva Hatwells', 'o4gaCKuHE', 82, '9632511114'),
('Robby Polle', 'R9BgXZ', 83, '3609016455'),
('Rafa Whatson', 'WRVjTp', 84, '3147684029'),
('Sherrie Audus', 'tTRsDrKc', 85, '2099542855'),
('Joe Drysdall', 'YQTAGOOEPxni', 86, '8319428730'),
('Auberta Allott', '4quuZk4', 87, '5202177769'),
('Rosamund Olenchikov', 'P76iziV77', 88, '5479852395'),
('Sherline Azam', 'P8TTzW9F', 89, '6762892784'),
('Edi Raulston', 'Fn2UFEmt2w', 90, '9374577417'),
('Kettie Gegg', 'sePrrjbVCj68', 91, '1758742219'),
('Salmon Figgs', 'toLvdxmDn28', 92, '3949033571'),
('Ingeberg Sapson', 'zajfr0xid', 93, '6963662123'),
('Travers Gurner', 'BWJrbB5OIPio', 94, '4926951337'),
('Ame Brister', 'bxqi94S', 95, '9641737715'),
('Abagail Hizir', 'XfiIFMpY', 96, '1529174892'),
('Pacorro Pratt', 'yIrshlBtHP', 97, '1293855920'),
('Gertie Benneton', 'twpFwi', 98, '6076750596'),
('Agosto Stormonth', '0vPCi4zLO8ed', 99, '7403655663'),
('Natassia Musicka', '9uJIyBv8hqw', 100, '4958884068');

INSERT INTO tblCustomer 
VALUES
('1'), 
('2'), 
('3'), 
('4'), 
('5'), 
('6'), 
('7'), 
('8'), 
('9'), 
('10'), 
('11'), 
('12'), 
('13'), 
('14'), 
('15'), 
('16'), 
('17'), 
('18'), 
('19'), 
('20'), 
('21'), 
('22'), 
('23'), 
('24'), 
('25'), 
('26'), 
('27'), 
('28'), 
('29'), 
('30'), 
('31'), 
('32'), 
('33'), 
('34'), 
('35'), 
('36'), 
('37'), 
('38'), 
('39'), 
('40'), 
('41'), 
('42'), 
('43'), 
('44'), 
('45'), 
('46'), 
('47'), 
('48'), 
('49'), 
('50'), 
('51'), 
('52'), 
('53'), 
('54'), 
('55'), 
('56'), 
('57'), 
('58'), 
('59'), 
('60');

INSERT INTO tblPayment 
VALUES
(1, 'jcb', '20200114 08:35:42', '$981.16', 1),
(2, 'jcb', '20191116 22:42:45', '$406.15', 2),
(3, 'jcb', '20191215 16:44:25', '$204.09', 3),
(4, 'laser', '20200121 12:52:11', '$690.47', 4),
(5, 'mastercard', '20200202 13:31:37', '$190.05', 5),
(6, 'laser', '20191015 05:32:55', '$715.47', 6),
(7, 'jcb', '20190912 23:55:23', '$937.87', 7),
(8, 'switch', '20191031 14:46:47', '$753.14', 8),
(9, 'switch', '20190616 07:28:09', '$55.69', 9),
(10, 'jcb', '20200206 20:13:03', '$674.86', 10),
(11, 'jcb', '20200228 13:25:47', '$432.62', 11),
(12, 'jcb', '20190816 13:08:28', '$172.35', 12),
(13, 'mastercard', '20200130 15:37:57', '$954.51', 13),
(14, 'jcb', '20200614 04:07:09', '$442.89', 14),
(15, 'maestro', '20200429 14:39:02', '$289.39', 15),
(16, 'americanexpress', '20190630 15:37:26', '$741.89', 16),
(17, 'jcb', '20200304 14:28:04', '$548.83', 17),
(18, 'mastercard', '20190727 02:28:36', '$515.34', 18),
(19, 'jcb', '20200404 22:16:32', '$389.96', 19),
(20, 'maestro', '20200110 04:00:02', '$958.22', 20),
(21, 'dinersclubenroute', '20190719 20:21:47', '$904.43', 21),
(22, 'chinaunionpay', '20191120 03:59:59', '$439.35', 22),
(23, 'jcb', '20200310 15:45:47', '$911.89', 23),
(24, 'jcb', '20200506 01:08:40', '$269.93', 24),
(25, 'dinersclubcarteblanche', '20200201 20:16:51', '$65.68', 25),
(26, 'dinersclubenroute', '20191109 23:03:46', '$572.93', 26),
(27, 'dinersclubenroute', '20191020 15:01:19', '$442.47', 27),
(28, 'mastercard', '20200120 13:11:00', '$413.96', 28),
(29, 'jcb', '20200222 01:04:02', '$664.23', 29),
(30, 'mastercard', '20190721 02:57:48', '$137.32', 30),
(31, 'switch', '20200319 16:38:10', '$982.49', 31),
(32, 'chinaunionpay', '20200101 01:10:59', '$318.58', 32),
(33, 'visaelectron', '20200419 12:23:03', '$891.51', 33),
(34, 'jcb', '20191119 18:41:45', '$653.82', 34),
(35, 'bankcard', '20190616 06:27:50', '$624.57', 35),
(36, 'jcb', '20200527 18:37:36', '$716.08', 36),
(37, 'jcb', '20190910 19:51:28', '$636.16', 37),
(38, 'mastercard', '20190617 12:47:18', '$404.89', 38),
(39, 'maestro', '20190828 12:03:17', '$571.82', 39),
(40, 'dinersclubenroute', '20191027 08:30:43', '$909.42', 40),
(41, 'chinaunionpay', '20190828 20:41:08', '$246.98', 41),
(42, 'jcb', '20190904 19:40:55', '$884.72', 42),
(43, 'laser', '20191017 02:13:16', '$918.63', 43),
(44, 'instapayment', '20191021 01:51:38', '$690.14', 44),
(45, 'laser', '20191022 02:56:04', '$412.86', 45),
(46, 'jcb', '20190831 15:28:24', '$459.53', 46),
(47, 'switch', '20200105 16:03:39', '$376.70', 47),
(48, 'visaelectron', '20190912 16:40:29', '$230.01', 48),
(49, 'switch', '20191229 05:36:52', '$87.65', 49),
(50, 'mastercard', '20200405 19:02:07', '$656.42', 50),
(51, 'jcb', '20200524 13:12:03', '$406.45', 51),
(52, 'switch', '20191105 00:37:00', '$311.90', 52),
(53, 'laser', '20200124 20:48:32', '$684.25', 53),
(54, 'dinersclubenroute', '20191223 11:24:32', '$941.58', 54),
(55, 'dinersclubusca', '20191022 20:02:30', '$967.23', 55),
(56, 'jcb', '20200609 01:37:35', '$483.30', 56),
(57, 'bankcard', '20191210 15:24:54', '$368.04', 57),
(58, 'jcb', '20190811 05:06:42', '$274.53', 58),
(59, 'jcb', '20200515 06:31:38', '$850.23', 59),
(60, 'americanexpress', '20190705 16:16:57', '$949.61', 60),
(61, 'jcb', '20200114 13:04:19', '$496.41', 61),
(62, 'dinersclubcarteblanche', '20190625 01:30:45', '$658.89', 62),
(63, 'jcb', '20200228 05:45:44', '$601.38', 63),
(64, 'americanexpress', '20200110 23:52:22', '$659.47', 64),
(65, 'jcb', '20200110 23:34:02', '$350.89', 65),
(66, 'jcb', '20200502 07:07:35', '$197.55', 66),
(67, 'jcb', '20190625 00:21:50', '$53.79', 67),
(68, 'americanexpress', '20200510 12:03:13', '$713.56', 68),
(69, 'dinersclubenroute', '20191129 19:50:20', '$100.76', 69),
(70, 'mastercard', '20200210 13:44:10', '$888.68', 70),
(71, 'dinersclubusca', '20191225 03:42:59', '$235.64', 71),
(72, 'instapayment', '20200402 02:05:27', '$606.87', 72),
(73, 'jcb', '20200529 16:21:12', '$742.54', 73),
(74, 'jcb', '20200308 01:44:08', '$396.96', 74),
(75, 'visa', '20200506 11:31:16', '$576.96', 75),
(76, 'maestro', '20190623 12:30:59', '$79.15', 76),
(77, 'visa', '20200506 23:43:05', '$501.47', 77),
(78, 'jcb', '20190720 15:33:31', '$821.09', 78),
(79, 'jcb', '20190809 07:44:25', '$505.94', 79),
(80, 'jcb', '20200331 22:04:09', '$372.18', 80),
(81, 'dinersclubusca', '20200511 14:31:51', '$487.93', 81),
(82, 'jcb', '20191210 07:34:20', '$234.19', 82),
(83, 'maestro', '20191104 13:41:25', '$202.72', 83),
(84, 'dinersclubusca', '20191003 16:43:47', '$138.30', 84),
(85, 'dinersclubcarteblanche', '20200206 03:23:21', '$366.29', 85),
(86, 'jcb', '20191029 11:01:41', '$906.90', 86),
(87, 'jcb', '20190825 10:20:22', '$857.61', 87),
(88, 'chinaunionpay', '20191012 12:44:44', '$463.03', 88),
(89, 'jcb', '20190822 12:00:46', '$681.11', 89),
(90, 'switch', '20191017 04:39:14', '$327.39', 90),
(91, 'americanexpress', '20200514 21:44:30', '$974.03', 91),
(92, 'mastercard', '20200309 21:18:13', '$585.16', 92),
(93, 'laser', '20200120 07:30:35', '$832.40', 93),
(94, 'jcb', '20190730 01:50:24', '$415.28', 94),
(95, 'dinersclubenroute', '20191017 01:07:40', '$991.63', 95),
(96, 'jcb', '20191023 03:03:51', '$174.74', 96),
(97, 'switch', '20190820 03:23:27', '$658.10', 97),
(98, 'jcb', '20200314 09:56:53', '$270.08', 98),
(99, 'laser', '20190725 02:25:21', '$476.98', 99),
(100, 'jcb', '20190716 06:25:45', '$248.62', 100);

INSERT INTO tblDroneOwner 
VALUES ('101', '1'),
('102', '2'),
('103', '3'),
('104', '4'),
('105', '5'),
('106', '6'),
('107', '7'),
('108', '8'),
('109', '9'),
('110', '10'),
('111', '11'),
('112', '12'),
('113', '13'),
('114', '14'),
('115', '15'),
('116', '16'),
('117', '17'),
('118', '18'),
('119', '19'),
('120', '20');

INSERT INTO tblDrone 
VALUES 
(1, 'Pellentesque at nulla.'),
(2, 'Aenean sit amet justo.'),
(3, 'Integer ac neque.'),
(4, 'Etiam pretium iaculis justo.'),
(5, 'Etiam vel augue.'),
(6, 'Aenean lectus.'),
(7, 'In hac habitasse platea dictumst.'),
(8, 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc.'),
(9, 'Donec quis orci eget orci vehicula condimentum.'),
(10, 'Nullam porttitor lacus at turpis.'),
(11, 'Donec semper sapien a libero.'),
(12, 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.'),
(13, 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.'),
(14, 'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.'),
(15, 'Morbi porttitor lorem id ligula.'),
(16, 'Nulla tempus.'),
(17, 'Sed ante.'),
(18, 'Proin risus.'),
(19, 'Vestibulum rutrum rutrum neque.'),
(20, 'Quisque id justo sit amet sapien dignissim vestibulum.');

INSERT INTO tblContractee 
VALUES
('41'),
('42'),
('43'),
('44'),
('45'),
('46'),
('47'),
('48'),
('49'),
('50'),
('51'),
('52'),
('53'),
('54'),
('55'),
('56'),
('57'),
('58'),
('59'),
('60');

INSERT INTO tblSubscriber 
VALUES
('1'),
('2'),
('3'),
('4'),
('5'),
('6'),
('7'),
('8'),
('9'),
('10'),
('11'),
('12'),
('13'),
('14'),
('15'),
('16'),
('17'),
('18'),
('19'),
('20'),
('21'),
('22'),
('23'),
('24'),
('25'),
('26'),
('27'),
('28'),
('29'),
('30'),
('31'),
('32'),
('33'),
('34'),
('35'),
('36'),
('37'),
('38'),
('39'),
('40');

INSERT INTO tblSubscription 
VALUES ('1'),
('2'),
('3'),
('4'),
('5'),
('6'),
('7'),
('8'),
('9'),
('10'),
('11'),
('12'),
('13'),
('14'),
('15'),
('16'),
('17'),
('18'),
('19'),
('20'),
('21'),
('22'),
('23'),
('24'),
('25'),
('26'),
('27'),
('28'),
('29'),
('30'),
('31'),
('32'),
('33'),
('34'),
('35'),
('36'),
('37'),
('38'),
('39'),
('40');

INSERT INTO tblGold 
VALUES
('11'),
('12'),
('13'),
('14'),
('15'),
('16'),
('17'),
('18'),
('19'),
('20'),
('21'),
('22'),
('23'),
('24'),
('25'),
('26'),
('27'),
('28'),
('29'),
('30'),
('31'),
('32'),
('33'),
('34'),
('35'),
('36'),
('37'),
('38'),
('39'),
('40');

INSERT INTO tblPlatinum 
VALUES
('20'),
('21'),
('22'),
('23'),
('24'),
('25'),
('26'),
('27'),
('28'),
('29'),
('30'),
('31'),
('32'),
('33'),
('34'),
('35'),
('36'),
('37'),
('38'),
('39'),
('40');

INSERT INTO tblSuperPlatinum 
VALUES ('30'),
('31'),
('32'),
('33'),
('34'),
('35'),
('36'),
('37'),
('38'),
('39'),
('40');

INSERT INTO tblPriceChange 
VALUES
(1, 5, 55, '20190619 18:29:30', '$42.06', '$92.34'),
(2, 4, 25, '20200123 22:41:30', '$44.22', '$83.18'),
(3, 4, 35, '20190711 06:27:55', '$46.50', '$56.66'),
(4, 9, 29, '20191109 06:47:59', '$40.82', '$62.84'),
(5, 3, 48, '20200123 19:48:10', '$40.83', '$57.14'),
(6, 6, 8, '20191116 14:14:07', '$49.65', '$78.68'),
(7, 7, 68, '20200606 06:08:47', '$41.86', '$89.00'),
(8, 4, 4, '20200524 18:28:14', '$42.09', '$90.96'),
(9, 5, 44, '20200130 11:28:20', '$43.35', '$71.83'),
(10, 3, 96, '20191008 07:13:41', '$41.74', '$89.66'),
(11, 7, 73, '20191202 01:25:03', '$40.92', '$80.63'),
(12, 6, 19, '20190713 15:43:15', '$49.79', '$99.29'),
(13, 9, 55, '20200307 12:29:58', '$46.29', '$83.48'),
(14, 7, 17, '20200512 21:02:53', '$47.23', '$96.93'),
(15, 4, 56, '20191006 07:51:45', '$46.91', '$58.24'),
(16, 1, 10, '20200125 17:36:11', '$45.70', '$75.14'),
(17, 1, 70, '20200515 02:38:38', '$45.43', '$55.12'),
(18, 1, 85, '20190823 14:03:26', '$43.52', '$62.35'),
(19, 2, 51, '20190923 03:05:43', '$45.10', '$70.18'),
(20, 8, 70, '20200311 03:08:00', '$49.44', '$80.12'),
(21, 5, 38, '20200416 15:22:16', '$47.03', '$51.72'),
(22, 10, 29, '20190717 20:43:33', '$49.79', '$73.38'),
(23, 9, 98, '20200602 13:17:24', '$45.61', '$69.36'),
(24, 10, 36, '20191230 19:03:49', '$48.74', '$82.15'),
(25, 9, 8, '20191117 12:23:18', '$48.97', '$99.04'),
(26, 7, 92, '20200306 08:51:02', '$43.67', '$57.85'),
(27, 8, 57, '20190730 11:54:52', '$40.54', '$81.31'),
(28, 2, 96, '20200123 22:53:11', '$45.14', '$90.58'),
(29, 7, 84, '20191229 10:17:42', '$41.21', '$65.02'),
(30, 10, 78, '20191113 00:28:49', '$46.28', '$80.27'),
(31, 3, 11, '20190626 00:39:53', '$40.39', '$61.46'),
(32, 1, 59, '20190629 11:16:55', '$43.30', '$52.26'),
(33, 5, 17, '20190705 15:26:53', '$46.08', '$72.67'),
(34, 8, 46, '20200216 03:08:53', '$49.44', '$64.26'),
(35, 6, 19, '20190920 06:49:08', '$40.93', '$79.55'),
(36, 5, 49, '20200611 21:07:45', '$44.08', '$64.25'),
(37, 10, 78, '20200103 18:16:23', '$46.25', '$56.77'),
(38, 8, 65, '20200529 08:30:42', '$40.86', '$79.74'),
(39, 2, 99, '20200424 17:54:57', '$45.65', '$68.85'),
(40, 2, 79, '20200215 10:48:11', '$40.86', '$98.73'),
(41, 5, 1, '20200402 18:28:36', '$44.94', '$55.50'),
(42, 8, 21, '20191201 01:15:36', '$41.57', '$90.04'),
(43, 3, 87, '20190624 09:59:47', '$44.64', '$92.06'),
(44, 7, 29, '20200310 04:35:06', '$42.03', '$99.38'),
(45, 7, 20, '20191210 04:43:45', '$47.02', '$73.61'),
(46, 10, 12, '20200609 08:31:24', '$42.19', '$55.14'),
(47, 5, 15, '20200322 01:12:11', '$45.65', '$88.85'),
(48, 6, 52, '20190825 19:10:06', '$42.30', '$79.37'),
(49, 9, 68, '20200123 04:39:10', '$40.19', '$89.39'),
(50, 8, 90, '20200606 13:18:58', '$42.24', '$64.74'),
(51, 5, 43, '20191208 23:41:19', '$44.68', '$87.69'),
(52, 9, 87, '20190630 14:46:40', '$43.70', '$64.68'),
(53, 6, 91, '20200330 09:05:04', '$49.66', '$65.31'),
(54, 10, 75, '20191208 05:33:22', '$48.67', '$58.10'),
(55, 8, 71, '20191218 06:01:24', '$47.45', '$54.21'),
(56, 2, 13, '20191220 05:51:28', '$43.17', '$73.58'),
(57, 4, 42, '20200306 12:29:13', '$44.18', '$62.95'),
(58, 6, 6, '20190908 23:47:47', '$49.23', '$58.21'),
(59, 6, 5, '20190731 09:56:58', '$44.07', '$78.89'),
(60, 8, 92, '20200308 16:21:04', '$40.68', '$64.39'),
(61, 8, 34, '20190917 18:30:30', '$40.38', '$76.31'),
(62, 7, 12, '20200327 16:54:34', '$45.01', '$60.88'),
(63, 8, 6, '20200304 18:06:43', '$41.94', '$58.68'),
(64, 8, 91, '20200526 21:32:01', '$48.01', '$90.41'),
(65, 5, 5, '20191221 15:53:07', '$44.05', '$83.97'),
(66, 3, 92, '20190707 09:55:53', '$40.21', '$61.49'),
(67, 10, 59, '20190720 01:41:31', '$45.28', '$56.98'),
(68, 4, 73, '20190909 08:51:42', '$47.73', '$89.27'),
(69, 8, 70, '20200213 00:59:03', '$46.27', '$84.02'),
(70, 6, 96, '20200121 17:24:56', '$45.44', '$55.07'),
(71, 6, 4, '20200529 12:41:38', '$41.19', '$84.68'),
(72, 4, 92, '20191024 16:59:51', '$41.57', '$59.75'),
(73, 1, 13, '20191024 20:11:41', '$45.49', '$81.16'),
(74, 5, 17, '20191217 14:35:04', '$44.47', '$82.89'),
(75, 6, 98, '20200109 14:33:53', '$46.51', '$86.87'),
(76, 4, 15, '20191104 11:25:27', '$46.07', '$81.06'),
(77, 10, 23, '20190902 07:00:31', '$49.48', '$81.04'),
(78, 9, 92, '20190717 07:14:07', '$45.42', '$94.29'),
(79, 1, 80, '20190728 03:47:37', '$44.20', '$71.78'),
(80, 7, 40, '20200613 03:36:00', '$46.28', '$79.04'),
(81, 4, 58, '20191123 00:29:21', '$48.73', '$96.57'),
(82, 7, 14, '20190716 03:02:39', '$41.18', '$81.75'),
(83, 7, 90, '20191208 08:22:23', '$41.35', '$68.71'),
(84, 6, 81, '20191011 23:24:32', '$45.88', '$87.70'),
(85, 7, 14, '20190621 00:28:40', '$47.78', '$90.22'),
(86, 8, 83, '20200430 14:09:20', '$45.57', '$71.79'),
(87, 10, 4, '20200301 21:54:40', '$45.70', '$74.93'),
(88, 1, 95, '20200108 21:06:07', '$45.53', '$65.14'),
(89, 1, 95, '20200116 23:30:15', '$43.63', '$73.32'),
(90, 5, 12, '20200125 11:15:21', '$40.05', '$91.26'),
(91, 9, 12, '20191110 11:06:07', '$44.98', '$82.06'),
(92, 5, 49, '20200304 15:12:59', '$47.02', '$70.55'),
(93, 9, 13, '20200510 13:37:40', '$47.35', '$97.66'),
(94, 9, 16, '20200607 21:18:25', '$40.66', '$61.61'),
(95, 10, 46, '20200422 20:26:38', '$48.87', '$56.69'),
(96, 9, 50, '20200108 22:50:54', '$43.90', '$51.51'),
(97, 6, 30, '20200129 13:07:10', '$49.37', '$89.77'),
(98, 5, 96, '20190807 05:04:44', '$48.34', '$92.27'),
(99, 6, 7, '20190811 07:25:14', '$41.07', '$77.40'),
(100, 8, 77, '20190729 08:54:47', '$47.39', '$81.31');

INSERT INTO tblBTDataboxStream 
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20),
(21, 21),
(22, 22),
(23, 23),
(24, 24),
(25, 25),
(26, 26),
(27, 27),
(28, 28),
(29, 29),
(30, 30),
(1, 31),
(2, 32),
(3, 33),
(4, 34),
(5, 35),
(6, 36),
(7, 37),
(8, 38),
(9, 39),
(10, 40),
(11, 41),
(12, 42),
(13, 43),
(14, 44),
(15, 45),
(16, 46),
(17, 47),
(18, 48),
(19, 49),
(20, 50),
(21, 51),
(22, 52),
(23, 53),
(24, 54),
(25, 55),
(26, 56),
(27, 57),
(28, 58),
(29, 59),
(30, 60),
(1, 61),
(2, 62),
(3, 63),
(4, 64),
(5, 65),
(6, 66),
(7, 67),
(8, 68),
(9, 69),
(10, 70),
(11, 71),
(12, 72),
(13, 73),
(14, 74),
(15, 75),
(16, 76),
(17, 77),
(18, 78),
(19, 79),
(20, 80),
(21, 81),
(22, 82),
(23, 83),
(24, 84),
(25, 85),
(26, 86),
(27, 87),
(28, 88),
(29, 89),
(30, 90),
(1, 91),
(2, 92),
(3, 93),
(4, 94),
(5, 95),
(6, 96),
(7, 97),
(8, 98),
(9, 99),
(10, 100);

INSERT INTO tblBTDataboxData 
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20),
(21, 21),
(22, 22),
(23, 23),
(24, 24),
(25, 25),
(26, 26),
(27, 27),
(28, 28),
(29, 29),
(30, 30),
(1, 31),
(2, 32),
(3, 33),
(4, 34),
(5, 35),
(6, 36),
(7, 37),
(8, 38),
(9, 39),
(10, 40),
(11, 41),
(12, 42),
(13, 43),
(14, 44),
(15, 45),
(16, 46),
(17, 47),
(18, 48),
(19, 49),
(20, 50),
(21, 51),
(22, 52),
(23, 53),
(24, 54),
(25, 55),
(26, 56),
(27, 57),
(28, 58),
(29, 59),
(30, 60),
(1, 61),
(2, 62),
(3, 63),
(4, 64),
(5, 65),
(6, 66),
(7, 67),
(8, 68),
(9, 69),
(10, 70),
(11, 71),
(12, 72),
(13, 73),
(14, 74),
(15, 75),
(16, 76),
(17, 77),
(18, 78),
(19, 79),
(20, 80),
(21, 81),
(22, 82),
(23, 83),
(24, 84),
(25, 85),
(26, 86),
(27, 87),
(28, 88),
(29, 89),
(30, 90),
(1, 91),
(2, 92),
(3, 93),
(4, 94),
(5, 95),
(6, 96),
(7, 97),
(8, 98),
(9, 99),
(10, 100);

INSERT INTO tblBTDataboxPart 
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20),
(21, 1),
(22, 2),
(23, 3),
(24, 4),
(25, 5),
(26, 6),
(27, 7),
(28, 8),
(29, 9),
(30, 10),
(1, 11),
(2, 12),
(3, 13),
(4, 14),
(5, 15),
(6, 16),
(7, 17),
(8, 18),
(9, 19),
(10, 20),
(11, 1),
(12, 2),
(13, 3),
(14, 4),
(15, 5),
(16, 6),
(17, 7),
(18, 8),
(19, 9),
(20, 10),
(21, 11),
(22, 12),
(23, 13),
(24, 14),
(25, 15),
(26, 16),
(27, 17),
(28, 18),
(29, 19),
(30, 20),
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20);

INSERT INTO tblBTDataboxZone 
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 1),
(12, 2),
(13, 3),
(14, 4),
(15, 5),
(16, 6),
(17, 7),
(18, 8),
(19, 9),
(20, 10),
(21, 1),
(22, 2),
(23, 3),
(24, 4),
(25, 5),
(26, 6),
(27, 7),
(28, 8),
(29, 9),
(30, 10);

INSERT INTO tblStore 
VALUES
(1, 'FramiLockman', 1, '5929530411'),
(2, 'Champlin LLC', 2, '8392196909'),
(3, 'Terry Inc', 3, '6599064589'),
(4, 'Keebler, Thompson and Mills', 4, '8366353595'),
(5, 'Stroman, Wyman and Willms', 5, '2835012426'),
(6, 'Macejkovic and Sons', 6, '5293763945'),
(7, 'Graham Group', 7, '1009899930'),
(8, 'Schinner and Sons', 8, '5116864050'),
(9, 'Braun, Hilll and Lindgren', 9, '6826153886'),
(10, 'Leuschke LLC', 10, '7968079343');

INSERT INTO tblSalespersonStore 
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO tblSale 
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(1, 11),
(2, 12),
(3, 13),
(4, 14),
(5, 15),
(6, 16),
(7, 17),
(8, 18),
(9, 19),
(10, 20),
(1, 21),
(2, 22),
(3, 23),
(4, 24),
(5, 25),
(6, 26),
(7, 27),
(8, 28),
(9, 29),
(10, 30),
(1, 31),
(2, 32),
(3, 33),
(4, 34),
(5, 35),
(6, 36),
(7, 37),
(8, 38),
(9, 39),
(10, 40);

INSERT INTO tblVideoStreamViewer 
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO tblVideoStreamController 
VALUES
(1, 1, 155, 206, 2.8),
(2, 1, 20, 21, 3.72),
(3, 1, 80, 183, 4.22),
(4, 1, 223, 153, 2.59),
(5, 1, 100, 210, 3.74),
(6, 1, 184, 48, 1.44),
(7, 1, 18, 81, 4.49),
(8, 1, 46, 67, 4.83),
(9, 1, 228, 3, 3.48),
(10, 1, 129, 78, 3.2);

INSERT INTO tblMaintenance 
VALUES
(1, 1, 1, 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.', '20200325 08:33:50'),
(2, 2, 2, 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', '20191001 04:28:31'),
(3, 3, 3, 'Donec dapibus.', '20190723 18:15:11'),
(4, 4, 4, 'Maecenas rhoncus aliquam lacus.', '20190905 16:08:39'),
(5, 5, 5, 'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.', '20200315 05:56:25'),
(6, 6, 6, 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.', '20190919 01:15:13'),
(7, 7, 7, 'In blandit ultrices enim.', '20200106 10:54:49'),
(8, 8, 8, 'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.', '20200421 15:51:01'),
(9, 9, 9, 'Morbi ut odio.', '20200408 21:10:43'),
(10, 10, 10, 'Morbi non quam nec dui luctus rutrum.', '20191111 14:48:48');

INSERT INTO tblMaintenancePart 
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);


INSERT INTO tblPartSupplier 
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);


INSERT INTO tblOrder 
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO tblOrderItem 
VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 7),
(8, 8, 8),
(9, 9, 9),
(10, 10, 10);

INSERT INTO tblZoneCountry 
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO tblZoneCondition 
VALUES
(1, 'Jungle'),
(2, 'Forest'),
(3, 'Savannah'),
(4, 'Jungle'),
(5, 'Ice and Snow (extreme cold)'),
(6, 'Urban'),
(7, 'Jungle'),
(8, 'Deserts'),
(9, 'Urban'),
(10, 'Urban');

INSERT INTO tblSubscriptionZone 
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO tblSubscriptionDatabox 
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO tblContract 
VALUES
(1, '20190318 08:23:19', null, 41, 1),
(2, '20200114 15:15:31', null, 42, 2),
(3, '20190929 18:47:50', null, 43, 3),
(4, '20190902 13:36:09', '20190816 00:41:41', 44, 4),
(5, '20190727 05:02:13', '20200612 12:13:13', 45, 5),
(6, '20190430 04:33:32', null, 46, 6),
(7, '20191101 14:18:23', '20190901 06:50:14', 47, 7),
(8, '20190913 15:29:21', null, 48, 8),
(9, '20190613 01:15:51', '20200512 10:57:35', 49, 9),
(10, '20191109 01:22:31', null, 50, 10),
(11, '20190725 14:30:30', '20200409 05:30:39', 51, 1),
(12, '20200324 07:10:33', null, 52, 2),
(13, '20190812 06:21:44', null, 53, 3),
(14, '20200205 22:33:28', null, 54, 4),
(15, '20200204 21:09:01', null, 55, 5),
(16, '20200310 13:42:59', '20190524 08:51:53', 56, 6),
(17, '20190927 06:05:18', null, 57, 7),
(18, '20191203 04:19:33', null, 58, 8),
(19, '20200318 07:25:00', null, 59, 9),
(20, '20190925 19:44:37', null, 60, 10);


INSERT INTO tblContractedBTDatabox 
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20);

INSERT INTO tblContractedZone 
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 1),
(11, 2),
(12, 3),
(13, 4),
(14, 5),
(15, 6),
(16, 7),
(17, 8),
(18, 9),
(19, 1),
(20, 2);

INSERT INTO tblContractScientificData 
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20),
(1, 21),
(2, 22),
(3, 23),
(4, 24),
(5, 25),
(6, 26),
(7, 27),
(8, 28),
(9, 29),
(10, 30),
(11, 31),
(12, 32),
(13, 33),
(14, 34),
(15, 35),
(16, 36),
(17, 37),
(18, 38),
(19, 39),
(20, 40),
(1, 41),
(2, 42),
(3, 43),
(4, 44),
(5, 45),
(6, 46),
(7, 47),
(8, 48),
(9, 49),
(10, 50),
(11, 51),
(12, 52),
(13, 53),
(14, 54),
(15, 55),
(16, 56),
(17, 57),
(18, 58),
(19, 59),
(20, 60),
(1, 61),
(2, 62),
(3, 63),
(4, 64),
(5, 65),
(6, 66),
(7, 67),
(8, 68),
(9, 69),
(10, 70),
(11, 71),
(12, 72),
(13, 73),
(14, 74),
(15, 75),
(16, 76),
(17, 77),
(18, 78),
(19, 79),
(20, 80),
(1, 81),
(2, 82),
(3, 83),
(4, 84),
(5, 85),
(6, 86),
(7, 87),
(8, 88),
(9, 89),
(10, 90),
(11, 91),
(12, 92),
(13, 93),
(14, 94),
(15, 95),
(16, 96),
(17, 97),
(18, 98),
(19, 99),
(20, 100);

INSERT INTO tblStaffRole 
VALUES

(1 , 60, null, 1, null, null),
(2 , 61, null, 2, null, null),
(3 , 62, null, 3, null, null),
(4 , 63, null, 4, null, null),
(5 , 64, null, 5, null, null),
(6 , 65, null, 6, null, null),
(7 , 66, null, 7, null, null),
(8 , 67, null, 8, null, null),
(9 , 69, null, 9, null, null),
(10, 70, null, 10, null, null),
(11, 71, 1, null, null, null),
(12, 72, 2, null, null, null),
(13, 73, 3, null, null, null),
(14, 74, 4, null, null, null),
(15, 75, 5, null, null, null),
(16, 76, 6, null, null, null),
(17, 77, 7, null, null, null),
(18, 78, 8, null, null, null),
(19, 79, 9, null, null, null),
(20, 80, 10, null, null, null),
(21, 81, null, null, 1, null),
(22, 82, null, null, 2, null),
(23, 83, null, null, 3, null),
(24, 84, null, null, 4, null),
(25, 85, null, null, 5, null),
(26, 86, null, null, 6, null),
(27, 87, null, null, 7, null),
(28, 88, null, null, 8, null),
(29, 89, null, null, 9, null),
(30, 90, null, null, 10, null),
(31, 91, null, null, null, 1),
(32, 92, null, null, null, 2),
(33, 93, null, null, null, 3),
(34, 94, null, null, null, 4),
(35, 95, null, null, null, 5),
(36, 96, null, null, null, 6),
(37, 97, null, null, null, 7),
(38, 98, null, null, null, 8),
(39, 99, null, null, null, 9),
(40, 100, null, null, null, 10);

INSERT INTO tblOwnsDataRights 
VALUES
(1, 21),
(2, 22),
(3, 23),
(4, 24),
(5, 25),
(6, 26),
(7, 27),
(8, 28),
(9, 29),
(10, 30),
(11, 31),
(12, 32),
(13, 33),
(14, 34),
(15, 35),
(16, 36),
(17, 37),
(18, 38),
(19, 39),
(20, 40),
(21, 21),
(22, 22),
(23, 23),
(24, 24),
(25, 25),
(26, 26),
(27, 27),
(28, 28),
(29, 29),
(30, 30),
(31, 31),
(32, 32),
(33, 33),
(34, 34),
(35, 35),
(36, 36),
(37, 37),
(38, 38),
(39, 39),
(40, 40),
(41, 21),
(42, 22),
(43, 23),
(44, 24),
(45, 25),
(46, 26),
(47, 27),
(48, 28),
(49, 29),
(50, 30),
(51, 31),
(52, 32),
(53, 33),
(54, 34),
(55, 35),
(56, 36),
(57, 37),
(58, 38),
(59, 39),
(60, 40),
(61, 21),
(62, 22),
(63, 23),
(64, 24),
(65, 25),
(66, 26),
(67, 27),
(68, 28),
(69, 29),
(70, 30),
(71, 31),
(72, 32),
(73, 33),
(74, 34),
(75, 35),
(76, 36),
(77, 37),
(78, 38),
(79, 39),
(80, 40),
(81, 21),
(82, 22),
(83, 23),
(84, 24),
(85, 25),
(86, 26),
(87, 27),
(88, 28),
(89, 29),
(90, 30),
(91, 31),
(92, 32),
(93, 33),
(94, 34),
(95, 35),
(96, 36),
(97, 37),
(98, 38),
(99, 39),
(100, 40);

INSERT INTO tblOwnsVideoRights 
VALUES
(1, 31),
(2, 32),
(3, 33),
(4, 34),
(5, 35),
(6, 36),
(7, 37),
(8, 38),
(9, 39),
(10, 40),
(11, 31),
(12, 32),
(13, 33),
(14, 34),
(15, 35),
(16, 36),
(17, 37),
(18, 38),
(19, 39),
(20, 40),
(21, 31),
(22, 32),
(23, 33),
(24, 34),
(25, 35),
(26, 36),
(27, 37),
(28, 38),
(29, 39),
(30, 40),
(31, 31),
(32, 32),
(33, 33),
(34, 34),
(35, 35),
(36, 36),
(37, 37),
(38, 38),
(39, 39),
(40, 40),
(41, 31),
(42, 32),
(43, 33),
(44, 34),
(45, 35),
(46, 36),
(47, 37),
(48, 38),
(49, 39),
(50, 40),
(51, 31),
(52, 32),
(53, 33),
(54, 34),
(55, 35),
(56, 36),
(57, 37),
(58, 38),
(59, 39),
(60, 40),
(61, 31),
(62, 32),
(63, 33),
(64, 34),
(65, 35),
(66, 36),
(67, 37),
(68, 38),
(69, 39),
(70, 40),
(71, 31),
(72, 32),
(73, 33),
(74, 34),
(75, 35),
(76, 36),
(77, 37),
(78, 38),
(79, 39),
(80, 40),
(81, 31),
(82, 32),
(83, 33),
(84, 34),
(85, 35),
(86, 36),
(87, 37),
(88, 38),
(89, 39),
(90, 40),
(91, 31),
(92, 32),
(93, 33),
(94, 34),
(95, 35),
(96, 36),
(97, 37),
(98, 38),
(99, 39),
(100, 40);
end;
go

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

-- 1. A sales person subscribes to a new standard subscription to a BT Databox . 
-- The transaction receives the sales person Id, a discount %, all subscriber details, and a BT Databox ID. 
DROP PROCEDURE IF EXISTS newStandardSubscription;
Go;
CREATE PROCEDURE newStandardSubscription @pSalesPersonID AS INTEGER, @pDiscount AS REAL, 
                                         @pName AS VARCHAR(255), @pPassword AS VARCHAR(64), 
                                         @pPhoneNumber AS VARCHAR(64), @pAddressPrefix AS VARCHAR(16), 
                                         @pStreetNumber AS VARCHAR(64), @pStreetName AS VARCHAR(64), 
                                         @pPostCode AS VARCHAR(16), @pCity AS VARCHAR(64), @pCountry AS VARCHAR(64)
AS
BEGIN
    DECLARE @tblID TABLE ( SUBID INTEGER);
     IF NOT EXISTS(SELECT * FROM tblAccount WHERE [Name] = pName AND (SELECT * FROM tblAddress WHERE [Prefix] = pAddressPrefix AND [StreetNumber] = pStreetNumber) AND [STREETNAME] = pStreetName AND (''))
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
            OUTPUT INSERTED.SubID INTO @tblID
            VALUES (@pPostCode, @pCity, @pCountry);
        END;
    END IF;
    INSERT INTO tblAddress([Prefix], [StreetNumber], [StreetName], [PostCodeID])
    VALUES (pAddressPrefix, pStreetNumber, pStreetName, (SELECT LAST INSERT INDEX?????TODO))

    INSERT INTO tblAccount([Name], [Password], [AddressID], [PhoneNumber])
    VALUES (pName, pPassword, (Select last INSERT index???TODO), pPhoneNumber);

    INSERT INTO tblCustomer
    VALUES (SELECT LAST INSERT index);

    INSERT INTO tblSubscriber
    Values (SELECT LAST INSERT index);

    INSERT INTO tblSubscription ([AccountID], )
END;

-- 2. For each sales person list the subscribers they have sold a subscription to. The transaction receives the sales person's name as input, 
-- and presents each subscriber's name, address, and the % they were discounted.
DROP PROCEDURE IF EXISTS salesPersonCustomers;
GO;
CREATE PROCEDURE salesPersonCustomers
AS
BEGIN
    SELECT 
    FROM tblAccount AS StaffAccount, tblAccount AS CustomerAccount, tblCustomer, 
END;


-- 3. List the location in latitude, longitude coordinates, of each BT Databox that is currently in a contract. 
-- The transaction presents the Contracting organisation's name, a BT DataboxID, a Latitude, and a Longitude.
DROP PROCEDURE IF EXISTS allBTDataboxInContract;
GO;
CREATE PROCEDURE allBTDataboxInContract
AS
BEGIN

END;
GO;
-- 4. For a contract list all the data collected. The transaction receives the contracting organisation's name 
-- and presents for each collected data record, the contracting organisation's name, a BT Databox ID, Temperature, Humidity and Ambient light strength.
DROP PROCEDURE IF EXISTS allContractData;
GO;
CREATE PROCEDURE allContractData
AS
BEGIN
SELECT * FROM tblUser;
END;
GO;

-- 5. For each BT Databox present the list of subscribers who are viewing a live 3D video stream. 
-- The transaction lists BT Databox ID, Subscriber Name, Stream ID.
DROP PROCEDURE IF EXISTS allVideoStreamViewers;
CREATE PROCEDURE allVideoStreamViewers()
AS
BEGIN

END;

-- 6. For a given BT Databox list all the suppliers of parts.
-- The transaction receives the  BT Databox ID, and presents the Supplier Name and, Part Name.
DROP PROCEDURE IF EXISTS getBTDataboxPartSuppliers;
CREATE PROCEDURE allVideoStreamViewers()
AS
BEGIN

END;

 	7. Update the location and Zone of a  BT Databox. The transaction receives the  BT Databox ID, a location and a Zone expressed as a list of coordinates 
 in latitude, longitude pairs. It updates the location of the  BT Databox and its corresponding Zone. (This transaction may require more than one update query.)
DROP PROCEDURE IF EXISTS updateBTDataboxLocation;
CREATE PROCEDURE updateBTDataboxLocation()
AS
BEGIN

END;

 8.  Delete the data collected for a given Contract. The transaction receives a Contract ID, the data collected for a Contract is deleted.
DROP PROCEDURE IF EXISTS deleteContractData;
CREATE PROCEDURE deleteContractData()
AS
BEGIN

END;

 9. Write a query to be used to INSERT data from a  BT Databox to its stored data on the Being There database. The transaction receives the  BT Databox ID.
DROP PROCEDURE IF EXISTS INSERTBTDataboxData;
CREATE PROCEDURE allVideoStreamViewers()
AS
BEGIN

END;

EXEC createDBBeingThere();
EXEC InsertPoinlessDataThatIsRidiclious();

--  
-- 
--  procedure sales from tblsalespersonName
--  @psalesname varchar(50)
--  as begin select
--  from sbufirstname, subsecondname, subscripber addresss, discount
--  tblsalesperson as sp join
--  tblsubscription as sub on sp.salesid = salesid = sbu.salesidwhere 
--  where sp.name = @psalesname
-- 
--  exec showsales Jane



























 Transaction A 
 INCLUDE Text from brief about the transaction

 TESTING A  Thomas Salesperson ID 1 sells a subscription to Jane Doe at a discount of 3% to DATABOX 1
exec SubscribeToDatabox 1,'Jane','Doe','t','t',3.0,1;
select * from tblSubscription;
select * from tblSubDatabox;
go

 Transaction B
 Put the description of Transaction B here
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
 TESTING B
EXEC ShowSales 'Thomas';
go 

 Transaction C
 Put the text describing transaction C here

 Transaction A 
 INCLUDE Text from brief about the transaction
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

	   INSERT INTO tblSubScription(SalesID ,SubFirstName,SubSecondName ,SubscriberAddress, Subphone, Discount) 
	   OUTPUT INSERTED.SubID INTO @tblID
	   VALUES ( @pSalesID ,@pSubFirstName,@pSubSecondName ,@pSubscriberAddress, @pSubphone, @pDiscount);

	   INSERT INTO tblSubDatabox VALUES ( (SELECT SUbID from @tblID),@pDataboxID); 
end;
GO

 Transaction B
 Put the description of Transaction B here
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

 TESTING B
go 

 Transaction C
 Put the text describing transaction C here
 List the location in latitude, longitude coordinates, 
 of each BT Databox that is currently in a contract. 
 The transaction presents the Contracting organisation's name, 
 a BT DataboxID, a Latitude, and a Longitude.

DROP PROCEDURE IF EXISTS ListDataBoxesByOrganisation;
go
CREATE PROCEDURE ListDataBoxesByOrganisation
AS
BEGIN
  select[Name], DBNum, Long, Lat
  From
		tblContract ct join tblContractZone Ctz on ct.id = ctz.ContractID
		join tblZone tz on tz.ID = ctz.ZoneID 
		JOIN tblDataBoxZone on tblDataBoxZone.ZoneID = tz.ID 
		JOIN tblDatabox ON tblDatabox.DBNUM = tblDataboxZone.DataBoxID
		JOIN tblOrganisation ON ct.ContractingOrg = TblOrganisation.[Name]; 

END;
go
exec ListDataBoxesByOrganisation;