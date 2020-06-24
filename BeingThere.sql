use master
go
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
DROP TABLE IF EXISTS tblContractScientificData;
DROP TABLE IF EXISTS tblContractedZone;
DROP TABLE IF EXISTS tblContractedBTDatabox;
DROP TABLE IF EXISTS tblContract;
DROP TABLE IF EXISTS tblSubscriptionBTDatabox;
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
DROP TABLE IF EXISTS tblStoreSalesPerson;
DROP TABLE IF EXISTS tblStore;
DROP TABLE IF EXISTS tblBTDataboxZone;
DROP TABLE IF EXISTS tblBTDataboxPart;
DROP TABLE IF EXISTS tblSuperPlatinumPriceChange;
DROP TABLE IF EXISTS tblPlatinumPriceChange;
DROP TABLE IF EXISTS tblGoldPriceChange;
DROP TABLE IF EXISTS tblSubscriptionPriceChange;
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
CREATE TABLE tblBTDatabox ( 
    [BTDataboxID] INT IDENTITY PRIMARY KEY,
    [FirstOperated] DATE,
    [NextScheduledMaintanence] DATE,
    [IPRating] VARCHAR(2) NOT NULL,
    [Latitude] Decimal(10, 7) NOT NULL,
    [Longitude] Decimal(10, 7) NOT NULL -- I am very very very unhappy about stroing latitude in 2 places but this is as per the requirements of the tranactions so.... whatever here is the stupid lat/long .... Marks unhappy and writing a long commen in anger of this. I mena why??? its in the data? The databox is seperate from the data it generates. Its not the same thing. 
);
CREATE TABLE tblScientificData (
    [ScientificDataID] INT IDENTITY PRIMARY KEY,
    [BTDataboxID] INT NOT NULL,
    [Longitude] Decimal(10, 7) NOT NULL,
    [Latitude] Decimal(10, 7) NOT NULL,
    [Altitude] INT NOT NULL,
    [Humidity] Decimal(4, 2) NOT NULL,
    [Temperature] Decimal(5, 2) NOT NULL,
    [AmbientLightStrength] Decimal(11, 4) NOT NULL,
    [RecordingTime] DATETIME NOT NULL,
    FOREIGN KEY (BTDataBoxID) REFERENCES tblBTDatabox (BTDataBoxID)
);
CREATE TABLE tblPart (
    [PartID] INT IDENTITY PRIMARY KEY,
    [Partname] VARCHAR(64) NOT NULL,
    [Description] VARCHAR(255) NOT NULL,
    [Cost] MONEY NOT NULL
);
CREATE TABLE tblVideoStream (
    [StreamID] INT IDENTITY PRIMARY KEY,
    [BTDataboxID] INT NOT NULL,
    [StartTime] DATETIME NOT NULL,
    [EndTime] DATETIME,
    [Length] INT
    FOREIGN KEY (BTDataboxID) REFERENCES tblBTDatabox (BTDataboxID)
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
    [ContracteeID] INT IDENTITY PRIMARY KEY,
    [CustomerID] INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES tblCustomer (CustomerID)
);
CREATE TABLE tblSubscriber ( 
    [SubscriberID] INT IDENTITY PRIMARY KEY,
    [CustomerID] INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES tblCustomer (CustomerID)
);
CREATE TABLE tblSubscription (
    [SubscriptionID] INT IDENTITY PRIMARY KEY,
    [SubscriberID] INT NOT NULL,
    FOREIGN KEY (SubscriberID) REFERENCES tblSubscriber (SubscriberID)
);
CREATE TABLE tblGold ( 
    [GoldID] INT IDENTITY PRIMARY KEY,
    [SubscriptionID] INT NOT NULL,
    FOREIGN KEY (SubscriptionID) REFERENCES tblSubscription (SubscriptionID)
);
CREATE TABLE tblPlatinum (
    [PlatinumID] INT IDENTITY PRIMARY KEY,
    [GoldID] INT NOT NULL,
    FOREIGN KEY (GoldID) REFERENCES tblGold (GoldID)
);
CREATE TABLE tblSuperPlatinum (
    [SuperPlatinumID] INT IDENTITY PRIMARY KEY,
    [PlatinumID] INT NOT NULL,
    FOREIGN KEY (PlatinumID) REFERENCES tblPlatinum (PlatinumID)
);
CREATE TABLE tblSubscriptionPriceChange (
    [PriceChangeID] INT IDENTITY PRIMARY KEY,
    [DirectorID] INT NOT NULL,
    [SubscriptionID] INT,
    [Date] DATE NOT NULL,
    [PreviousPrice] MONEY NOT NULL,
    [NewPrice] MONEY NOT NULL,
    FOREIGN KEY (DirectorID) REFERENCES tblDirector (DirectorID),
    FOREIGN KEY (SubscriptionID) REFERENCES tblSubscription (SubscriptionID)
);
CREATE TABLE tblGoldPriceChange (
    [PriceChangeID] INT IDENTITY PRIMARY KEY,
    [DirectorID] INT NOT NULL,
    [GoldID] INT,
    [Date] DATE NOT NULL,
    [PreviousPrice] MONEY NOT NULL,
    [NewPrice] MONEY NOT NULL,
    FOREIGN KEY (DirectorID) REFERENCES tblDirector (DirectorID),
    FOREIGN KEY (GoldID) REFERENCES tblGold (GoldID)
);
CREATE TABLE tblPlatinumPriceChange (
    [PriceChangeID] INT IDENTITY PRIMARY KEY,
    [DirectorID] INT NOT NULL,
    [PlatinumID] INT,
    [Date] DATE NOT NULL,
    [PreviousPrice] MONEY NOT NULL,
    [NewPrice] MONEY NOT NULL,
    FOREIGN KEY (DirectorID) REFERENCES tblDirector (DirectorID),
    FOREIGN KEY (PlatinumID) REFERENCES tblPlatinum (PlatinumID)
);
CREATE TABLE tblSuperPlatinumPriceChange (
    [PriceChangeID] INT IDENTITY PRIMARY KEY,
    [DirectorID] INT NOT NULL,
    [SuperPlatinumID] INT,
    [Date] DATE NOT NULL,
    [PreviousPrice] MONEY NOT NULL,
    [NewPrice] MONEY NOT NULL,
    FOREIGN KEY (DirectorID) REFERENCES tblDirector (DirectorID),
    FOREIGN KEY (SuperPlatinumID) REFERENCES tblSuperPlatinum (SuperPlatinumID)
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
    [Discount] REAL NOT NULL CHECK ( Discount >= 0.0 and Discount <= 2.00), --check max discount amount TODO
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
    [isDeleted] BIT NOT NULL DEFAULT 0, -- Check this line TODO
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
    [SuperPlatinumID] INT NOT NULL,
    PRIMARY KEY(StreamID, SuperPlatinumID),
    FOREIGN KEY (StreamID) REFERENCES tblVideoStream (StreamID),
    FOREIGN KEY (SuperPlatinumID) REFERENCES tblSuperPlatinum(SuperPlatinumID)
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
('Andorra'),('United Arab Emirates'),('Afghanistan'),('Antigua and Barbuda'),('Anguilla'),('Albania'),('Armenia'),('Netherlands Antilles'),('Angola'),('Antarctica'),('Argentina'),('American Samoa'),('Austria'),('Australia'),('Aruba'),('Azerbaijan'),('Bosnia and Herzegovina'),('Barbados'),('Bangladesh'),('Belgium'),('Burkina Faso'),('Bulgaria'),('Bahrain'),('Burundi'),('Benin'),('Bermuda'),('Brunei'),('Bolivia'),('Brazil'),('Bahamas'),('Bhutan'),('Bouvet Island'),('Botswana'),('Belarus'),('Belize'),('Canada'),('Cocos [Keeling] Islands'),('Congo [DRC]'),('Central African Republic'),('Congo [Republic]'),('Switzerland'),('Côte d Ivoire'),('Cook Islands'),('Chile'),('Cameroon'),('China'),('Colombia'),('Costa Rica'),('Cuba'),('Cape Verde'),('Christmas Island'),('Cyprus'),('Czech Republic'),('Germany'),('Djibouti'),('Denmark'),('Dominica'),('Dominican Republic'),('Algeria'),('Ecuador'),('Estonia'),('Egypt'),('Western Sahara'),('Eritrea'),('Spain'),('Ethiopia'),('Finland'),('Fiji)'),('Falkland Islands [Islas Malvinas]'),('Micronesia'),('Faroe Islands'),('France'),('Gabon'),('United Kingdom'),('Grenada'),('Georgia'),('French Guiana'),('Guernsey'),('Ghana'),('Gibraltar'),('Greenland'),('Gambia'),('Guinea'),('Guadeloupe'),('Equatorial Guinea'),('Greece'), ('South Georgia and the South Sandwich Islands'),('Guatemala'),('Guam'),('GuineaBissau'),('Guyana'),('Gaza Strip'),('Hong Kong'),('Heard Island and McDonald Islands'),('Honduras'),('Croatia'),('Haiti'),('Hungary'),('Indonesia'),('Ireland'),('Israel'),('Isle of Man'),('India'),('British Indian Ocean Territory'),('Iraq'),('Iran'),('Iceland'),('Italy'),('Jersey'),('Jamaica'),('Jordan'),('Japan'),('Kenya'),('Kyrgyzstan'),('Cambodia'),('Kiribati'),('Comoros'),('Saint Kitts and Nevis'),('North Korea'),('South Korea'),('Kuwait'),('Cayman Islands'),('Kazakhstan'),('Laos'),('Lebanon'),('Saint Lucia'),('Liechtenstein'),('Sri Lanka'),('Liberia'),('Lesotho'),('Lithuania'),('Luxembourg'),('Latvia'),('Libya'),('Morocco'),('Monaco'),('Moldova'),('Montenegro'),('Madagascar'),('Marshall Islands'),('Macedonia [FYROM]'),('Mali'),('Myanmar [Burma]'),('Mongolia'),('Macau'),('Northern Mariana Islands'),('Martinique'),('Mauritania'),('Montserrat'),('Malta'),('Mauritius'),('Maldives'),('Malawi'),('Mexico'),('Malaysia'),('Mozambique'),('Namibia'),('New Caledonia'),('Niger'),('Norfolk Island'),('Nigeria'),('Nicaragua'),('Netherlands'),('Norway'),('Nepal'),('Nauru'),('Niue'),('New Zealand'),('Oman'),('Panama'),('Peru'),('French Polynesia'),('Papua New Guinea'),('Philippines'),('Pakistan'),('Poland'),('Saint Pierre and Miquelon'),('Pitcairn Islands'),('Puerto Rico'),('Palestinian Territories'),('Portugal'),('Palau'),('Paraguay'),('Qatar'),('Réunion'),('Romania'),('Serbia'),('Russia'),('Rwanda'),('Saudi Arabia'),('Solomon Islands'),('Seychelles'),('Sudan'),('Sweden'),('Singapore'),('Saint Helena'),('Slovenia'),('Svalbard and Jan Mayen'),('Slovakia'),('Sierra Leone'),('San Marino'),('Senegal'),('Somalia'),('Suriname'),('São Tomé and Príncipe'),('El Salvador'),('Syria'),('Swaziland'),('Turks and Caicos Islands'),('Chad'),('French Southern Territories'),('Togo'),('Thailand'),('Tajikistan'),('Tokelau'),('TimorLeste'),('Turkmenistan'),('Tunisia'),('Tonga'),('Turkey'),('Trinidad and Tobago'),('Tuvalu'),('Taiwan'),('Tanzania'),('Ukraine'),('Uganda'),('U.S. Minor Outlying Islands'),('United States'),('Uruguay'),('Uzbekistan'),('Vatican City'),('Saint Vincent and the Grenadines'),('Venezuela'),('British Virgin Islands'),('U.S. Virgin Islands'),('Vietnam'),('Vanuatu'),('Wallis and Futuna'),('Samoa'),('Kosovo'),('Yemen'),('Mayotte'),('South Africa'),('Zambia'),('Zimbabwe');

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

INSERT INTO tblBTDatabox
VALUES 
('20191125', '20210526', '67', 61.344385, 15.388447),
('20190810', '20210730', '53', 40.685430, 14.556065),
('20200124', '20210803', '33', 111.87498, 33.307008),
('20191226', '20211028', '24', 121.01436, 14.587472),
('20191222', '20201102', '44', 126.09611, 39.149925),
('20200531', '20220118', '43', 17.586039, 52.818616),
('20190625', '20210104', '34', 103.50839, 16.411476),
('20190809', '20200626', '66', 36.019945, 52.820161),
('20190814', '20210530', '48', 43.292397, 52.079571),
('20190821', '20220311', '28', 87.021819, 13.649619),
('20190704', '20200704', '48', 16.630410, 55.687831),
('20200527', '20220219', '47', 99.178830, 10.258482),
('20191203', '20220418', '66', 111.79107, 23.421682),
('20191009', '20220408', '24', 117.22337, 39.109563),
('20190629', '20200702', '44', 138.90999, 37.633531),
('20200310', '20220512', '33', 18.905275, 39.847755),
('20200514', '20210608', '55', 12.879714, 42.692642),
('20200507', '20201118', '56', 77.499999, 10.916667),
('20200610', '20210117', '32', 109.07711, 70.509156),
('20200512', '20220612', '22', 97.358024, 57.442483),
('20200426', '20220430', '45', 34.641964, 52.381357),
('20200326', '20210703', '43', 27.993441, 80.303998),
('20190718', '20211129', '42', 87.271781, 26.666381),
('20200111', '20200929', '44', 116.33977, 39.947462),
('20190710', '20200624', '66', 117.11686, 36.189557),
('20200406', '20200828', '68', 121.63709, 16.990258),
('20190629', '20210307', '44', 20.448921, 44.786568),
('20200430', '20201127', '55', 118.86550, 80.609738),
('20190726', '20210304', '67', 69.144708, 35.401071),
('20180202', '20220202', '11', -18.90527, -10.91666);

INSERT INTO tblScientificData
VALUES 
(1, 61.344385, 15.388447, 0613, 95.86, 33.61, 33.8391, '20191106 11:41:47'),
(2, 40.685430, 14.556065, 1785, 24.78, 35.0, 56.4677, '20191001 21:04:52'),
(3, 111.87498, 33.307008, 3836, 4.09, 37.57, 65.1923, '20200406 15:19:02'),
(4, 121.01436, 14.587472, 3146, 63.44, 37.95, 99.9618, '20190621 01:04:13'),
(5, 126.09611, 39.149925, 1891, 95.12, 4.61, 36.111, '20190801 13:42:54'),
(6, 17.586039, 52.818616, 3897, 39.65, 21.61, 47.1164, '20190928 11:56:18'),
(7, 103.50839, 16.411476, 3422, 14.48, 15.35, 44.6682, '20190419 20:03:57'),
(8, 36.019945, 52.820161, 2548, 77.01, 36.7, 80.1538, '20191024 01:16:09'),
(9, 43.292397, 52.079571, 2584, 30.65, 43.79, 4.9143, '20200122 07:46:55'),
(10, 114.88641, 87.735418, 1500, 70.17, 30.77, 47.8682, '20200425 02:25:10'),
(11, 87.021819, 13.649619, 1421, 19.51, 30.55, 20.2546, '20191010 19:21:38'),
(12, 16.630410, 55.687831, 3779, 5.71, 44.37, 38.3524, '20200109 20:34:11'),
(13, 99.178830, 10.258482, 2142, 86.28, 32.82, 11.4071, '20191217 08:06:41'),
(14, 111.79107, 23.421682, 0673, 30.7, 31.41, 5.6212, '20191226 05:29:09'),
(15, 117.22337, 39.109563, 0609, 33.39, 30.34, 29.6488, '20200103 14:05:59'),
(16, 138.90999, 37.633531, 0093, 93.02, 15.46, 59.0069, '20191124 06:07:36'),
(17, 18.905275, 39.847755, 2232, 60.98, 43.72, 18.567, '20190918 14:58:46'),
(18, 12.879714, 42.692642, 0040, 91.92, 2.43, 13.5799, '20191112 21:27:20'),
(19, 77.499999, 10.916667, 3256, 20.9, 35.29, 23.4515, '20200327 22:04:52'),
(20, 109.07711, 70.509156, 2040, 26.25, 17.61, 64.3759, '20200606 21:28:54'),
(21, 97.358024, 57.442483, 3704, 10.0, 22.64, 60.5233, '20190419 13:40:49'),
(22, 34.641964, 52.381357, 2052, 29.44, 44.57, 57.4696, '20200221 11:14:28'),
(23, 27.993441, 80.303998, 1076, 65.49, 14.64, 21.0222, '20191103 14:34:38'),
(24, 87.271781, 26.666381, 0712, 85.89, 43.44, 12.1456, '20200412 08:44:50'),
(25, 116.33977, 39.947462, 2764, 65.42, 29.56, 72.3546, '20191016 03:00:36'),
(26, 117.11686, 36.189557, 0415, 85.83, 20.49, 19.0755, '20191012 00:26:32'),
(27, 121.63709, 16.990258, 1692, 37.78, 18.66, 83.5346, '20200411 22:15:23'),
(28, 20.448921, 44.786568, 0777, 50.26, 20.05, 27.1383, '20190624 22:26:30'),
(29, 118.86550, 80.609738, 1488, 62.25, 2.77, 0.9739, '20200527 03:41:21'),
(30, 69.144708, 35.401071, 3342, 21.15, 15.49, 76.9254, '20200429 15:21:04'),
(1, 42.191799, 21.418052, 3881, 42.08, 7.57, 8.8044, '20191021 10:13:01'),
(2, 54.006819, 46.991061, 0064, 14.98, 41.36, 20.2835, '20191021 22:11:18'),
(3, 22.395693, 39.729085, 1349, 20.87, 40.03, 41.6449, '20200410 07:18:13'),
(4, 66.808197, 20.700604, 2184, 46.04, 20.14, 16.8153, '20190808 22:10:36'),
(5, 35.205790, 70.257125, 2180, 89.35, 43.84, 88.0093, '20190724 09:58:57'),
(6, 106.56183, 60.244343, 3901, 35.76, 20.74, 8.9846, '20200111 12:13:27'),
(7, 111.06541, 65.618462, 1115, 91.65, 11.24, 70.8874, '20190710 06:45:52'),
(8, 113.12873, 29.356803, 3226, 99.17, 38.28, 75.6498, '20191104 23:26:13'),
(9, 50.807649, 59.319146, 3448, 91.29, 18.07, 40.9941, '20200320 17:59:01'),
(10, 84.336869, 99.834321, 3657, 62.0, 1.53, 1.111, '20190914 22:37:10'),
(11, 135.11454, 44.266981, 3327, 72.49, 36.13, 71.7755, '20200201 00:34:05'),
(12, 133.93268, 44.348809, 2595, 48.59, 4.78, 63.9479, '20190430 21:07:12'),
(13, 106.01552, 60.385073, 1708, 50.29, 19.13, 2.9182, '20190810 20:28:27'),
(14, 77.142764, 38.822689, 2774, 35.43, 41.12, 57.6838, '20200224 04:16:15'),
(15, 10.207574, 48.885087, 1127, 38.05, 37.62, 97.554, '20200321 03:18:32'),
(16, 71.658925, 37.641379, 3589, 62.08, 26.69, 42.0944, '20200505 03:45:49'),
(17, 71.534575, 41.228624, 0441, 60.2, 41.79, 13.7593, '20191225 15:31:27'),
(18, 57.157682, 55.556613, 0793, 11.17, 25.21, 15.8915, '20190715 03:10:15'),
(19, 90.090978, 38.926594, 0855, 88.03, 41.13, 36.2168, '20190621 21:48:24'),
(20, 14.271615, 55.858675, 1523, 36.79, 9.98, 54.3289, '20190702 02:56:17'),
(21, 20.281825, 48.726331, 3690, 73.28, 14.54, 21.1736, '20190701 14:06:50'),
(22, 114.28807, 80.405528, 2336, 82.36, 24.04, 80.8521, '20190623 08:36:59'),
(23, 61.344385, 15.380447, 0613, 64.48, 33.61, 33.8391, '20191106 11:41:47'),
(24, 40.685439, 14.556065, 1785, 44.72, 35.0, 56.4677, '20191001 21:04:52'),
(25, 111.87492, 33.310008, 3836, 47.74, 37.57, 65.1923, '20200406 15:19:02'),
(26, 121.01430, 14.578472, 3146, 31.41, 37.95, 99.9618, '20190621 01:04:13'),
(27, 126.09611, 39.140025, 1891, 4.86, 4.61, 36.111, '20190801 13:42:54'),
(28, 17.586039, 52.818616, 3897, 66.66, 21.61, 47.1164, '20190928 11:56:18'),
(29, 103.50839, 16.411476, 3422, 96.99, 15.35, 44.6682, '20190419 20:03:57'),
(30, 36.019945, 52.280161, 2548, 97.88, 36.7, 80.1538, '20191024 01:16:09'),
(1, 43.292397, 52.379571, 2584, 91.1, 43.79, 4.9143, '20200122 07:46:55'),
(2, 114.88641, 89.275418, 1500, 5.45, 30.77, 47.8682, '20200425 02:25:10'),
(3, 119.99684, 29.454189, 1918, 46.21, 3.92, 72.5993, '20190910 09:08:56'),
(4, 13.277242, 49.700481, 1499, 56.21, 6.35, 3.3953, '20190619 03:44:12'),
(5, 122.79244, 78.835214, 2395, 18.72, 3.7, 20.9331, '20200123 19:17:28'),
(6, 120.30895, 38.372662, 0561, 84.53, 15.85, 64.6498, '20190711 13:29:08'),
(7, 70.555236, 37.101088, 2605, 34.95, 8.43, 33.3975, '20190831 11:06:07'),
(8, 104.10050, 10.259553, 3209, 37.59, 5.73, 26.7796, '20190724 09:22:37'),
(9, 56.766484, 27.435718, 0448, 10.84, 27.5, 33.5449, '20191106 20:11:00'),
(10, 49.316413, 25.160913, 1435, 9.83, 23.07, 19.116, '20190928 08:06:15'),
(11, 15.437722, 53.165674, 1176, 20.87, 36.79, 48.3454, '20190823 14:02:55'),
(12, 73.840258, 80.588397, 0237, 51.63, 20.23, 72.8114, '20200416 22:12:00'),
(13, 89.982425, 29.222417, 2105, 48.82, 6.62, 97.1202, '20191122 17:26:15'),
(14, 113.36690, 22.948016, 0874, 73.49, 12.81, 34.4266, '20200428 15:48:54'),
(15, 18.154392, 50.137056, 3978, 32.02, 27.34, 37.4493, '20190702 23:21:23'),
(16, 51.323827, 30.090924, 2240, 66.8, 7.16, 57.9138, '20191112 13:38:13'),
(17, 50.887546, 49.663957, 3630, 62.89, 22.66, 44.2508, '20191123 19:36:16'),
(18, 50.868937, 45.644535, 1004, 51.3, 14.31, 3.5978, '20190924 14:05:05'),
(19, 43.651050, 52.918299, 3310, 66.49, 22.02, 75.9979, '20190702 21:19:45'),
(20, 128.25792, 35.474465, 0797, 59.61, 24.11, 55.1669, '20190605 10:46:10'),
(21, 116.34265, 26.540915, 2568, 80.79, 17.57, 71.9358, '20200326 19:47:08'),
(22, 44.051975, 40.106025, 0290, 58.21, 4.83, 53.9396, '20190530 15:55:10'),
(23, 37.292090, 53.111077, 2569, 58.99, 36.55, 38.0644, '20200316 09:02:31'),
(24, 16.018026, 45.458598, 0679, 16.95, 18.84, 10.969, '20200207 07:30:21'),
(25, 73.343691, 45.257774, 3503, 24.06, 37.77, 15.9893, '20190919 11:20:19'),
(26, 124.42398, 87.600716, 3319, 56.24, 18.72, 7.1388, '20200414 10:51:52'),
(27, 114.75830, 27.859517, 3012, 61.78, 11.65, 67.6484, '20190910 04:06:07'),
(28, 38.409402, 46.704507, 3653, 71.28, 27.85, 30.5747, '20200117 20:12:51'),
(29, 123.59836, 13.187371, 0933, 69.51, 14.11, 22.1995, '20200127 07:08:15'),
(30, 87.607529, 14.676215, 3004, 22.44, 9.02, 83.071, '20200104 14:24:20'),
(1, 15.235997, 46.542793, 2810, 31.56, 44.26, 29.0655, '20191221 03:44:10'),
(2, 73.638661, 54.559873, 2005, 76.2, 15.7, 96.2824, '20191224 01:33:30'),
(3, 35.084003, 32.433378, 1193, 34.6, 11.99, 68.1125, '20190826 09:24:32'),
(4, 25.578380, 49.520136, 0107, 29.25, 4.59, 74.0914, '20190531 22:19:46'),
(5, 11.331760, 24.514272, 0834, 79.3, 39.44, 17.7495, '20190923 17:11:35'),
(6, 60.692338, 32.925798, 1833, 41.91, 42.69, 27.8569, '20191023 02:18:31'),
(7, 110.18122, 22.654032, 1462, 14.22, 15.08, 76.5179, '20200106 03:15:47'),
(8, 85.693742, 46.089148, 2465, 68.15, 32.34, 32.826, '20190925 01:15:24'),
(9, 8.6441655, 40.540471, 0035, 4.05, 8.06, 66.2182, '20190916 08:48:33'),
(10, 99.397126, 23.538092, 1326, 17.57, 12.07, 6.3024, '20191230 05:24:31');

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

INSERT INTO tblVideoStream (BTDataboxID, StartTime, EndTime) -- 7
VALUES
(1, '2020-04-01T08:16:59.000', '2019-12-08T17:03:15.000'),
(2, '2019-08-21T07:18:49.000', '2020-04-24T18:13:53.000'),
(3, '2019-09-24T15:09:16.000', '2020-05-18T21:49:41.000'),
(4, '2020-03-12T05:02:06.000', '2020-03-01T18:30:47.000'),
(5, '2020-04-25T08:59:49.000', '2020-05-12T12:52:11.000'),
(6, '2020-04-08T09:44:19.000', '2019-08-21T12:03:47.000'),
(7, '2019-08-11T20:38:30.000', '2019-11-08T22:48:55.000'),
(8, '2019-09-04T12:03:02.000', '2019-08-21T20:19:57.000'),
(9, '2020-03-24T22:03:02.000', '2019-09-12T12:30:45.000'),
(10, '2019-09-11T15:50:39.000', '2019-10-24T22:37:24.000'),
(11, '2020-05-26T06:10:58.000', '2019-08-19T03:19:37.000'),
(12, '2020-04-04T15:52:17.000', '2019-12-12T07:05:48.000'),
(13, '2020-02-25T07:21:05.000', '2019-08-01T17:56:03.000'),
(14, '2019-12-13T23:55:27.000', '2020-02-03T08:17:28.000'),
(15, '2019-09-24T13:21:21.000', '2019-07-16T17:26:49.000'),
(16, '2019-12-09T08:36:07.000', '2019-12-30T20:34:34.000'),
(17, '2020-02-23T19:50:28.000', '2019-07-11T16:21:23.000'),
(18, '2020-06-08T13:57:23.000', '2019-08-23T21:29:32.000'),
(19, '2020-01-28T05:13:47.000', '2020-04-08T15:56:08.000'),
(20, '2020-04-01T14:11:23.000', '2020-01-17T05:34:01.000'),
(21, '2020-01-22T11:11:28.000', '2020-01-04T23:34:22.000'),
(22, '2020-02-27T03:40:58.000', '2020-03-27T05:46:51.000'),
(23, '2019-08-24T17:49:50.000', '2019-08-26T16:55:46.000'),
(24, '2019-12-13T00:18:00.000', '2019-06-26T00:44:18.000'),
(25, '2020-02-02T00:17:20.000', '2020-05-20T18:43:42.000'),
(26, '2019-10-29T00:24:50.000', '2020-01-05T09:39:55.000'),
(27, '2020-03-18T09:21:26.000', '2019-08-06T01:10:57.000'),
(28, '2019-06-10T11:36:02.000', '2020-04-24T10:55:40.000'),
(29, '2019-08-20T22:44:49.000', '2019-11-03T17:36:26.000'),
(30, '2019-10-05T21:03:03.000', '2019-07-06T17:55:27.000');

INSERT INTO tblPostCode -- 8
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

INSERT INTO tblSupplier -- 10
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

INSERT INTO tblAccount -- 11
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
('Natassia Musicka', '9uJIyBv8hqw', 100, '4958884068'),
('Tucker Elward', 'co0VbD', 101, '8605987730'),
('Zerk Butler', 'biVw1si', 102, '8018886799'),
('Mal Tocknell', 'hpaeU4yg9AKK', 103, '3792590138'),
('Dahlia Kristof', 'HCXuvZEk2a35', 104, '9242283417'),
('Traver Fabler', 'YSKR82', 105, '7119263198'),
('Ailene Hazelden', 'ahmZ5tnX', 106, '3137818805'),
('Dieter Mucklow', 'Ja7tBGcv78', 107, '7866798455'),
('Munroe Gossan', 'pa7EO6Ro3', 108, '5181772420'),
('Dolly Good', 'bskkKu', 109, '2397958847'),
('Darin Curror', 'NwgvlWOXDM', 110, '3693034524');

INSERT INTO tblStaff 
VALUES 
(61, '$2059.06', 'Libbey Karpe', '12/24/2019', null),
(62, '$1123.93', 'Brent Siemantel', '9/9/2019', null),
(63, '$3822.34', 'Abigale Kassel', '12/30/2019', null),
(64, '$2394.02', 'Tedie Werner', '9/21/2019', null),
(65, '$3774.69', 'Walther Menco', '4/11/2020', null),
(66, '$2621.30', 'Idelle Rathjen', '11/19/2019', null),
(67, '$2040.69', 'Wheeler Imlaw', '1/19/2020', null),
(68, '$3572.57', 'Merrilee Huscroft', '7/11/2019', null),
(69, '$1717.76', 'Samson Merigeau', '2/16/2020', null),
(70, '$1768.98', 'Helen Elders', '7/5/2019', null),
(71, '$3589.03', 'Guillermo Espinoy', '1/9/2020', null),
(72, '$2506.45', 'Jamie Brayn', '3/9/2020', null),
(73, '$1308.20', 'Ferrell Spinola', '8/14/2019', '6/4/2020'),
(74, '$3491.55', 'Zolly Mingame', '9/21/2019', null),
(75, '$2318.56', 'Ashil Crenshaw', '11/19/2019', null),
(76, '$2234.02', 'Lin Nestoruk', '1/5/2020', null),
(77, '$1439.19', 'Codie Croom', '11/11/2019', null),
(78, '$1995.89', 'Meyer Swalteridge', '2/11/2020', null),
(79, '$3855.36', 'Arleyne Weatherley', '3/2/2020', '4/28/2019'),
(80, '$1339.22', 'Rorie Cutill', '10/16/2019', null),
(81, '$3354.00', 'Kellia Mallam', '9/1/2019', null),
(82, '$3289.49', 'Palm Adlem', '10/23/2019', null),
(83, '$3594.88', 'Katina Niesel', '3/29/2020', null),
(84, '$1207.01', 'Maurine Atkirk', '11/8/2019', '7/18/2019'),
(85, '$2006.58', 'Elwira Natte', '3/31/2020', null),
(86, '$3810.86', 'Petronilla Victoria', '1/20/2020', null),
(87, '$1301.19', 'Von Costall', '7/6/2019', '3/20/2020'),
(88, '$2178.34', 'Dolph Purple', '2/20/2020', null),
(89, '$2036.82', 'Redd Sapson', '3/22/2020', null),
(90, '$1697.82', 'Minerva Brownstein', '11/3/2019', '10/24/2019'),
(91, '$2669.64', 'Briano Forsbey', '1/23/2020', '7/8/2019'),
(92, '$3768.56', 'Sydelle Fantonetti', '9/14/2019', null),
(93, '$3596.34', 'Dennie Langelay', '10/6/2019', null),
(94, '$3537.10', 'Arda Hynard', '1/6/2020', null),
(95, '$1695.19', 'Kevan Benezeit', '2020-02-25', '2019-07-17'),
(96, '$2340.05', 'Brenden Ritelli', '2020-06-03', '2019-10-02'),
(97, '$1282.29', 'Theresina Tunesi', '2019-04-19', '2020-04-28'),
(98, '$2563.99', 'Jody Hoyle', '2020-01-09', '2020-02-07'),
(99, '$3006.98', 'Rooney Beddows', '2019-06-30', '2019-09-02'),
(100, '$4793.33', 'Jermain Lowdeane', '2020-06-15', '2019-08-23');

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

INSERT INTO tblDirector
VALUES
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20);

INSERT INTO tblSalesperson 
VALUES
(21),
(22),
(23),
(24),
(25),
(26),
(27),
(28),
(29),
(30);

INSERT INTO tblMaintenanceperson 
VALUES
(31),
(32),
(33),
(34),
(35),
(36),
(37),
(38),
(39),
(40);

INSERT INTO tblCustomer 
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
(10), 
(11), 
(12), 
(13), 
(14), 
(15), 
(16), 
(17), 
(18), 
(19), 
(20), 
(21), 
(22), 
(23), 
(24), 
(25), 
(26), 
(27), 
(28), 
(29), 
(30), 
(31), 
(32), 
(33), 
(34), 
(35), 
(36), 
(37), 
(38), 
(39), 
(40), 
(41), 
(42), 
(43), 
(44), 
(45), 
(46), 
(47), 
(48), 
(49), 
(50), 
(51), 
(52), 
(53), 
(54), 
(55), 
(56), 
(57), 
(58), 
(59), 
(60);

INSERT INTO tblPayment 
VALUES
('jcb', '20200114 08:35:42', '$981.16', 1),
('jcb', '20191116 22:42:45', '$406.15', 2),
('jcb', '20191215 16:44:25', '$204.09', 3),
('laser', '20200121 12:52:11', '$690.47', 4),
('mastercard', '20200202 13:31:37', '$190.05', 5),
('laser', '20191015 05:32:55', '$715.47', 6),
('jcb', '20190912 23:55:23', '$937.87', 7),
('switch', '20191031 14:46:47', '$753.14', 8),
('switch', '20190616 07:28:09', '$55.69', 9),
('jcb', '20200206 20:13:03', '$674.86', 10),
('jcb', '20200228 13:25:47', '$432.62', 11),
('jcb', '20190816 13:08:28', '$172.35', 12),
('mastercard', '20200130 15:37:57', '$954.51', 13),
('jcb', '20200614 04:07:09', '$442.89', 14),
('maestro', '20200429 14:39:02', '$289.39', 15),
('americanexpress', '20190630 15:37:26', '$741.89', 16),
('jcb', '20200304 14:28:04', '$548.83', 17),
('mastercard', '20190727 02:28:36', '$515.34', 18),
('jcb', '20200404 22:16:32', '$389.96', 19),
('maestro', '20200110 04:00:02', '$958.22', 20),
('dinerscle', '20190719 20:21:47', '$904.43', 21),
('chinaunionpay', '20191120 03:59:59', '$439.35', 22),
('jcb', '20200310 15:45:47', '$911.89', 23),
('jcb', '20200506 01:08:40', '$269.93', 24),
('dinersclubcarte', '20200201 20:16:51', '$65.68', 25),
('dinersclubee', '20191109 23:03:46', '$572.93', 26),
('dinersclube', '20191020 15:01:19', '$442.47', 27),
('mastercard', '20200120 13:11:00', '$413.96', 28),
('jcb', '20200222 01:04:02', '$664.23', 29),
('mastercard', '20190721 02:57:48', '$137.32', 30),
('switch', '20200319 16:38:10', '$982.49', 31),
('chinaunionpay', '20200101 01:10:59', '$318.58', 32),
('visaelectron', '20200419 12:23:03', '$891.51', 33),
('jcb', '20191119 18:41:45', '$653.82', 34),
('bankcard', '20190616 06:27:50', '$624.57', 35),
('jcb', '20200527 18:37:36', '$716.08', 36),
('jcb', '20190910 19:51:28', '$636.16', 37),
('mastercard', '20190617 12:47:18', '$404.89', 38),
('maestro', '20190828 12:03:17', '$571.82', 39),
('dinerscluboue', '20191027 08:30:43', '$909.42', 40),
('chinaunionpay', '20190828 20:41:08', '$246.98', 41),
('jcb', '20190904 19:40:55', '$884.72', 42),
('laser', '20191017 02:13:16', '$918.63', 43),
('instapayment', '20191021 01:51:38', '$690.14', 44),
('laser', '20191022 02:56:04', '$412.86', 45),
('jcb', '20190831 15:28:24', '$459.53', 46),
('switch', '20200105 16:03:39', '$376.70', 47),
('visaelectron', '20190912 16:40:29', '$230.01', 48),
('switch', '20191229 05:36:52', '$87.65', 49),
('mastercard', '20200405 19:02:07', '$656.42', 50),
('jcb', '20200524 13:12:03', '$406.45', 51),
('switch', '20191105 00:37:00', '$311.90', 52),
('laser', '20200124 20:48:32', '$684.25', 53),
('aaa', '20191223 11:24:32', '$941.58', 54),
('dinersclubusca', '20191022 20:02:30', '$967.23', 55),
('jcb', '20200609 01:37:35', '$483.30', 56),
('bankcard', '20191210 15:24:54', '$368.04', 57),
('jcb', '20190811 05:06:42', '$274.53', 58),
('jcb', '20200515 06:31:38', '$850.23', 59),
('americanexpress', '20190705 16:16:57', '$949.61', 60);

INSERT INTO tblDroneOwner 
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
(10),
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20);

INSERT INTO tblDrone 
VALUES 
(1, 1, 'Pellentesque at nulla.', 1810),
(2, 2, 'Aenean sit amet justo.', 1811),
(3, 3, 'Integer ac neque.', 1812),
(4, 4, 'Etiam pretium iaculis justo.', 1813),
(5, 5, 'Etiam vel augue.', 1814),
(6, 6, 'Aenean lectus.', 1815),
(7, 7, 'In hac habitasse platea dictumst.', 1816),
(8, 8, 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc.', 1817),
(9, 9, 'Donec quis orci eget orci vehicula condimentum.', 1818),
(10, 10, 'Nullam porttitor lacus at turpis.', 1819),
(11, 11, 'Donec semper sapien a libero.', 1820),
(12, 12, 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.', 1821),
(13, 13, 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.', 1822),
(14, 14, 'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 1823),
(15, 15, 'Morbi porttitor lorem id ligula.', 1824),
(16, 16, 'Nulla tempus.', 1825),
(17, 17, 'Sed ante.', 1826),
(18, 18, 'Proin risus.', 1827),
(19, 19, 'Vestibulum rutrum rutrum neque.', 1828),
(20, 20, 'Quisque id justo sit amet sapien dignissim vestibulum.', 1829);

INSERT INTO tblContractee 
VALUES
(41),
(42),
(43),
(44),
(45),
(46),
(47),
(48),
(49),
(50),
(51),
(52),
(53),
(54),
(55),
(56),
(57),
(58),
(59),
(60);

INSERT INTO tblSubscriber 
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
(10),
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20),
(21),
(22),
(23),
(24),
(25),
(26),
(27),
(28),
(29),
(30),
(31),
(32),
(33),
(34),
(35),
(36),
(37),
(38),
(39),
(40);

INSERT INTO tblSubscription 
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
(10),
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20),
(21),
(22),
(23),
(24),
(25),
(26),
(27),
(28),
(29),
(30),
(31),
(32),
(33),
(34),
(35),
(36),
(37),
(38),
(39),
(40);

INSERT INTO tblGold 
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
(10),
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20),
(21),
(22),
(23),
(24),
(25),
(26),
(27),
(28),
(29),
(30);

INSERT INTO tblPlatinum 
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
(10),
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20);

INSERT INTO tblSuperPlatinum 
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

INSERT INTO tblSubscriptionPriceChange 
VALUES
(5, 1, '20190619 18:29:30', '$42.06', '$92.34'),
(4, 2, '20200123 22:41:30', '$44.22', '$83.18'),
(4, 3, '20190711 06:27:55', '$46.50', '$56.66'),
(9, 4, '20191109 06:47:59', '$40.82', '$62.84'),
(3, 5, '20200123 19:48:10', '$40.83', '$57.14'),
(6, 6, '20191116 14:14:07', '$49.65', '$78.68'),
(7, 7, '20200606 06:08:47', '$41.86', '$89.00'),
(4, 8, '20200524 18:28:14', '$42.09', '$90.96'),
(5, 9, '20200130 11:28:20', '$43.35', '$71.83'),
(3, 10, '20191008 07:13:41', '$41.74', '$89.66');

INSERT INTO tblGoldPriceChange
VALUES
(6, 1, '2020-02-12 20:56:29', '$54.51', '$82.19'),
(7, 2, '2019-09-26 20:56:03', '$59.34', '$94.62'),
(5, 3, '2020-05-04 10:06:23', '$78.47', '$117.90'),
(5, 4, '2019-10-13 19:28:55', '$75.06', '$109.38'),
(6, 5, '2020-05-05 12:53:26', '$63.05', '$119.73'),
(6, 6, '2020-05-08 01:37:53', '$52.32', '$81.86'),
(8, 7, '2020-05-17 13:05:20', '$64.44', '$103.55'),
(3, 8, '2019-07-29 09:45:22', '$53.19', '$118.65'),
(2, 9, '2020-03-31 03:08:00', '$62.25', '$116.47'),
(2, 10, '2019-11-10 16:46:51', '$51.06', '$97.73');

INSERT INTO tblPlatinumPriceChange
VALUES
(7, 1, '2020-02-24 10:19:43', '$197.89', '$212.70'),
(6, 2, '2020-05-01 23:46:31', '$133.71', '$206.00'),
(9, 3, '2019-10-20 05:37:05', '$132.72', '$236.23'),
(7, 4, '2019-07-24 23:58:55', '$129.34', '$216.90'),
(5, 5, '2019-07-19 23:04:22', '$124.56', '$232.09'),
(10, 6, '2020-05-17 00:59:54', '$141.85', '$217.30'),
(9, 7, '2019-07-14 15:20:43', '$151.67', '$245.32'),
(8, 8, '2019-06-29 05:44:25', '$190.76', '$213.04'),
(7, 9, '2019-10-24 07:50:34', '$154.42', '$235.88'),
(1, 10, '2019-10-22 02:35:47', '$140.65', '$204.38');

INSERT INTO tblSuperPlatinumPriceChange
VALUES
(4, 1, '2020-05-30 12:39:03', '$264.20', '$348.13'),
(10, 2, '2020-06-16 08:17:36', '$242.24', '$334.31'),
(10, 3, '2020-03-11 07:15:12', '$218.75', '$332.46'),
(10, 4, '2019-08-20 10:43:45', '$240.44', '$327.86'),
(3, 5, '2020-05-26 05:34:41', '$278.05', '$325.93'),
(7, 6, '2020-05-09 18:09:59', '$280.74', '$310.14'),
(10, 7, '2019-10-16 15:00:17', '$253.55', '$331.91'),
(10, 8, '2020-03-28 21:59:48', '$239.09', '$312.76'),
(3, 9, '2020-02-05 14:26:53', '$232.04', '$334.26'),
(7, 10, '2019-07-21 18:00:45', '$277.25', '$308.35');

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
(30, 20);

INSERT INTO tblBTDataboxZone 
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 1),
(8, 2),
(9, 3),
(10, 4),
(11, 5),
(12, 6),
(13, 1),
(14, 2),
(15, 3),
(16, 4),
(17, 5),
(18, 6),
(19, 1),
(20, 2),
(21, 3),
(22, 4),
(23, 5),
(24, 6),
(25, 1),
(26, 2),
(27, 3),
(28, 4),
(29, 5),
(30, 6);

INSERT INTO tblStore 
VALUES
('FramiLockman', 1, '5929530411'),
('Champlin LLC', 2, '8392196909'),
('Terry Inc', 3, '6599064589'),
('Keebler, Thompson and Mills', 4, '8366353595'),
('Stroman, Wyman and Willms', 5, '2835012426'),
('Macejkovic and Sons', 6, '5293763945'),
('Graham Group', 7, '1009899930'),
('Schinner and Sons', 8, '5116864050'),
('Braun, Hilll and Lindgren', 9, '6826153886'),
('Leuschke LLC', 10, '7968079343');

INSERT INTO tblStoreSalesPerson 
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
(1, 1, 0.16),
(2, 2, 0.26),
(3, 3, 0.26),
(4, 4, 1.65),
(5, 5, 1.8),
(6, 6, 1.36),
(7, 7, 0.26),
(8, 8, 0.08),
(9, 9, 1.23),
(10, 10, 0.96),
(1, 11, 0.51),
(2, 12, 0.8),
(3, 13, 0.92),
(4, 14, 1.5),
(5, 15, 0.14),
(6, 16, 1.82),
(7, 17, 0.55),
(8, 18, 0.79),
(9, 19, 0.01),
(10, 20, 0.67),
(1, 21, 0.3),
(2, 22, 1.94),
(3, 23, 0.49),
(4, 24, 1.73),
(5, 25, 0.2),
(6, 26, 0.09),
(7, 27, 1.86),
(8, 28, 0.09),
(9, 29, 1.45),
(10, 30, 1.35),
(1, 31, 0.98),
(2, 32, 1.96),
(3, 33, 1.5),
(4, 34, 1.99),
(5, 35, 0.3),
(6, 36, 0.69),
(7, 37, 1.67),
(8, 38, 1.76),
(9, 39, 1.5),
(10, 40, 1.73);

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
(1, 1, 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.', '20200325 08:33:50'),
(2, 2, 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', '20191001 04:28:31'),
(3, 3, 'Donec dapibus.', '20190723 18:15:11'),
(4, 4, 'Maecenas rhoncus aliquam lacus.', '20190905 16:08:39'),
(5, 5, 'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.', '20200315 05:56:25'),
(6, 6, 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.', '20190919 01:15:13'),
(7, 7, 'In blandit ultrices enim.', '20200106 10:54:49'),
(8, 8, 'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.', '20200421 15:51:01'),
(9, 9, 'Morbi ut odio.', '20200408 21:10:43'),
(10, 10, 'Morbi non quam nec dui luctus rutrum.', '20191111 14:48:48');

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
(1, '20200606'),
(2, '20200309'),
(3, '20200226'),
(4, '20190726'),
(5, '20191108'),
(6, '20190815'),
(7, '20191231'),
(8, '20190715'),
(9, '20200423'),
(10, '20191007');

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

INSERT INTO tblSubscriptionBTDatabox 
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
('20190318 08:23:19', null, '$90172.92', 41, 1),
('20200114 15:15:31', null, '$70456.76', 42, 2),
('20190929 18:47:50', null, '$37425.77', 43, 3),
('20190902 13:36:09', '20190816 00:41:41', '$75614.02', 44, 4),
('20190727 05:02:13', '20200612 12:13:13', '$86513.33', 45, 5),
('20190430 04:33:32', null, '$44513.32', 46, 6),
('20191101 14:18:23', '20190901 06:50:14', '$21789.05', 47, 7),
('20190913 15:29:21', null, '$12056.26', 48, 8),
('20190613 01:15:51', '20200512 10:57:35', '$98477.69', 49, 9),
('20191109 01:22:31', null,  '$31641.35',50, 10),
('20190725 14:30:30', '20200409 05:30:39', '$11732.61', 51, 1),
('20200324 07:10:33', null, '$47907.09', 52, 2),
('20190812 06:21:44', null, '$47837.06', 53, 3),
('20200205 22:33:28', null, '$49366.52', 54, 4),
('20200204 21:09:01', null, '$89598.24', 55, 5),
('20200310 13:42:59', '20190524 08:51:53', '$17463.48', 56, 6),
('20190927 06:05:18', null, '$28736.09', 57, 7),
('20191203 04:19:33', null, '$27161.86', 58, 8),
('20200318 07:25:00', null, '$40889.14', 59, 9),
('20190925 19:44:37', null,  '$25788.11',60, 10);

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

INSERT INTO tblContractScientificData -- Check these inserts TODO
VALUES 
(1, 1, 0),
(2, 2, 0),
(3, 3, 0),
(4, 4, 0),
(5, 5, 0),
(6, 6, 0),
(7, 7, 0),
(8, 8, 0),
(9, 9, 0),
(10, 10, 0),
(11, 11, 0),
(12, 12, 0),
(13, 13, 0),
(14, 14, 0),
(15, 15, 0),
(16, 16, 0),
(17, 17, 0),
(18, 18, 0),
(19, 19, 0),
(20, 20, 0),
(1, 21, 0),
(2, 22, 0),
(3, 23, 0),
(4, 24, 0),
(5, 25, 0),
(6, 26, 0),
(7, 27, 0),
(8, 28, 0),
(9, 29, 0),
(10, 30, 0),
(11, 31, 0),
(12, 32, 0),
(13, 33, 0),
(14, 34, 0),
(15, 35, 0),
(16, 36, 0),
(17, 37, 0),
(18, 38, 0),
(19, 39, 0),
(20, 40, 0),
(1, 41, 0),
(2, 42, 0),
(3, 43, 0),
(4, 44, 0),
(5, 45, 0),
(6, 46, 0),
(7, 47, 0),
(8, 48, 0),
(9, 49, 0),
(10, 50, 0),
(11, 51, 0),
(12, 52, 0),
(13, 53, 0),
(14, 54, 0),
(15, 55, 0),
(16, 56, 0),
(17, 57, 0),
(18, 58, 0),
(19, 59, 0),
(20, 60, 0),
(1, 61, 0),
(2, 62, 0),
(3, 63, 0),
(4, 64, 0),
(5, 65, 0),
(6, 66, 0),
(7, 67, 0),
(8, 68, 0),
(9, 69, 0),
(10, 70, 0),
(11, 71, 0),
(12, 72, 0),
(13, 73, 0),
(14, 74, 0),
(15, 75, 0),
(16, 76, 0),
(17, 77, 0),
(18, 78, 0),
(19, 79, 0),
(20, 80, 0),
(1, 81, 0),
(2, 82, 0),
(3, 83, 0),
(4, 84, 0),
(5, 85, 0),
(6, 86, 0),
(7, 87, 0),
(8, 88, 0),
(9, 89, 0),
(10, 90, 0),
(11, 91, 0),
(12, 92, 0),
(13, 93, 0),
(14, 94, 0),
(15, 95, 0),
(16, 96, 0),
(17, 97, 0),
(18, 98, 0),
(19, 99, 0),
(20, 100, 0);

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
exec InsertTestData;
go
-- 1. A sales person subscribes to a new standard subscription to a BT Databox . 
-- The transaction receives the sales person Id, a discount %, all subscriber details, and a BT Databox ID. 
DROP PROCEDURE IF EXISTS newStandardSubscription;
Go
CREATE PROCEDURE newStandardSubscription @pSalesPersonID AS INTEGER, 
                                         @pDiscount AS REAL, 
                                         @pName AS VARCHAR(255), 
                                         @pPassword AS VARCHAR(64), 
                                         @pPhoneNumber AS VARCHAR(64),
                                         @pAddressPrefix AS VARCHAR(16), 
                                         @pStreetNumber AS VARCHAR(64), 
                                         @pStreetName AS VARCHAR(64), 
                                         @pPostCode AS VARCHAR(16), 
                                         @pCity AS VARCHAR(64), 
                                         @pCountry AS VARCHAR(64)
AS
BEGIN
    DECLARE @tblID TABLE (SubscriptionID INTEGER, SubscriberID INTEGER, CustomerID INTEGER, AccountID INTEGER, AddressID INTEGER, PostCodeID INTEGER, SalesPersonID INTEGER);
    INSERT INTO tblID (SalesPersonID) VALUES (pSalesPersonID);
    SELECT SC.SubscriptionID, SB.SubscriberID, C.CustomerID, A.AccountID, AD.AddressID, P.PostCodeID 
    INTO tblID 
    FROM tblSubscription as SC 
    JOIN tblSubscriber AS SB ON SC.SubscriberID = SB.SubcriberID
    JOIN tblCustomer AS C ON SB.CustomerID = C.CustomerID
    JOIN tblAccount AS A ON C.AccountID = A.AccountID
    JOIN tblAddress AS AD ON A.AddressID = AD.AddressID
    JOIN tblPostCode AS P ON AD.PostCodeID = P.PostCodeID
    JOIN tblCountry AS CO ON P.CountryID = CO.CountryID
    WHERE SalesPersonID = pSalesPerson;

    IF tblID.PostCodeID IS NULL
        INSERT INTO tblPostCode OUTPUT INSERTED.ID INTO tblID.PostCodeID VALUES (pPostCode, pCity, (SELECT [CountryID] FROM tblCountry WHERE [Country] = pCountry));
    IF tblID.AddressID IS NULL
        INSERT INTO tblAddress OUTPUT INSERTED.ID INTO tblID.AddressID VALUES (pAddressPrefix, pStreetNumber, pStreetName, (SELECT PostCodeID FROM tblID));
    IF tblID.AccountID IS NULL
        INSERT INTO tblAccount OUTPUT INSERTED.ID INTO tblID.AccountID VALUES (pName, pPassword, (Select AddressID FROM tblID), pPhoneNumber);
    IF tblID.CustomerID IS NULL
        INSERT INTO tblCustomer OUTPUT INSERTED.ID INTO tblID.CustomerID VALUES ((SELECT AccountID FROM tblID));
    IF tblID.SubscriberID IS NULL
        INSERT INTO tblSubscriber OUTPUT INSERTED.ID INTO tblID.SubscriberID VALUES ((SELECT CustomerID FROM tblID));
    INSERT INTO tblSubscription OUTPUT INSERTED.ID INTO tblID.SubscriberID VALUES ((SELECT SubscriberID FROM tblID));
    INSERT INTO tblSale VALUES (pSalesPersonID, tblID.SubscriptionID, pDiscount);
END;
GO

-- 2. For each sales person list the subscribers they have sold a subscription to. The transaction receives the sales person's name as input, 
-- and presents each subscriber'sname, address, and the % they were discounted.
DROP PROCEDURE IF EXISTS salesPersonCustomers;
GO;
CREATE PROCEDURE salesPersonCustomers
@pSalesPersonName VARCHAR (255) 
AS
BEGIN
    SELECT CA.Name, AD.Prefix, AD.StreetNumber, AD.StreetName, S.Discount
    FROM tblAccount AS SPA 
    JOIN tblStaff AS ST ON SPA.AccountID = ST.AccountID
    JOIN tblSalesPerson SP ON ST.StaffID = SP.StaffID
    JOIN tblSale S ON SP.SalesPersonID = S.SalesPersonID
    JOIN tblSubscription SC ON S.SubscriptionID = SC.SubscriptionID
    JOIN tblSubscriber SB ON SC.SubscriberID = SB.SubscriberID
    JOIN tblCustomer C ON SB.CustomerID = C.CustomerID
    JOIN tblAccount CA ON C.AccountID = CA.AccountID
    JOIN tblAddress AD ON CA.AddressID = AD.AddressID
    JOIN tblPostCode P ON AD.PostCodeID = P.PostCodeID
    JOIN tblCountry CY ON P.CountryID = CY.CountryID
    -- WHERE SPA.Name = pSalesPersonName;
END;

-- 3. List the location in latitude, longitude coordinates, of each BT Databox that is currently in a contract. 
-- The transaction presents the Contracting organisation's name, a BT DataboxID, a Latitude, and a Longitude.
DROP PROCEDURE IF EXISTS lastLocationOfBTDataboxInContract;
GO;
CREATE PROCEDURE allBTDataboxInContract
AS
BEGIN
    SELECT A.Name AS "Contracting Organisation", BTDB.BTDataboxID, BTDB.Latitude, BTDB.Longitude
    FROM tblAccount AS A
    JOIN tblCustomer AS CM ON A.AccountID = CM.AccountID
    JOIN tblContractee AS CE ON CM.CustomerID = CE.CustomerID
    JOIN tblContract AS C ON C.Contractee = CE.ContracteeID
    JOIN tblContractedBTDatabox AS CBTDB ON C.ContractID = CBTDB.ContractID
    JOIN tblBTDatabox AS BTDB ON CBTDB.BTDataboxID = BTDB.BTDataboxID
    JOIN tblScientificData AS SD ON BTDB.BTDataboxID = SD.BTDataboxID
    WHERE A.Name IS NOT NULL;
END;
GO
-- 4. For a contract list all the data collected. The transaction receives the contracting organisation's name 
-- and presents for each collected data record, the contracting organisation's name, a BT Databox ID, Temperature, Humidity and Ambient light strength.
DROP PROCEDURE IF EXISTS allContractData;
GO;
CREATE PROCEDURE allContractData
@pContractingOrg VARCHAR(255)
AS
BEGIN
    SELECT A.Name AS "Contracting Organisation", Temperature, Humidity, AmbientLightStrength AS "Ambient Light Strenght"
    FROM tblAccount AS A
    JOIN tblCustomer AS CM ON A.AccountID = CM.AccountID
    JOIN tblContractee AS CE ON CM.CustomerID = CE.CustomerID
    JOIN tblContract AS C ON C.Contractee = CE.ContracteeID
    JOIN tblContractedBTDatabox AS CBTDB ON C.ContractID = CBTDB.ContractID
    JOIN tblBTDatabox AS BTDB ON CBTDB.BTDataboxID = BTDB.BTDataboxID
    JOIN tblScientificData AS SD ON BTDB.BTDataboxID = SD.BTDataboxID
END;
GO

-- 5. For each BT Databox present the list of subscribers who are viewing a live 3D video stream. 
-- The transaction lists BT Databox ID, Subscriber Name, Stream ID.
DROP PROCEDURE IF EXISTS allVideoStreamViewers;
GO
CREATE PROCEDURE allVideoStreamViewers
AS
BEGIN
    SELECT BT.BTDataboxID, CA.Name AS "Subscriber nAmE", VS.StreamID
    FROM tblBTDatabox AS BT 
    JOIN tblBTDataboxStream AS BTDBS ON BT.DataboxID = BTDBS.BTdataboxID
    JOIN tblVideoStream AS VS ON BTDBS.StreamID = VS.StreamID
    JOIN tblVideoStreamViewer AS VSV ON VS.StreamID = VSV.StreamID
    JOIN tblSubscription SC ON VSV.SubscriptionID = SC.SubscriptionID
    JOIN tblSubscriber SB ON SC.SubscriberID = SB.SubscriberID
    JOIN tblCustomer C ON SB.CustomerID = C.CustomerID
    JOIN tblAccount CA ON C.AccountID = CA.AccountID
END;
GO

-- 6. For a given BT Databox list all the suppliers of parts.
-- The transaction receives the  BT Databox ID, and presents the Supplier Name and, Part Name.
DROP PROCEDURE IF EXISTS getBTDataboxPartSuppliers;
GO
CREATE PROCEDURE getBTDataboxPartSuppliers @pBTDBID INTEGER
AS
BEGIN
    SELECT S.SupplierName AS "Supplier Name", P.Partname AS "Part Name"
    FROM tblBTDatabox as BTDB
    JOIN tblBTDataboxPart AS BTDBP ON BTDB.BTDataboxID = BTDBP.BTDataboxID
    JOIN tblPart AS P ON BTDBP.PartID = P.PartID
    JOIN tblPartSuppplier AS PS ON P.PartID = PS.PartID
    JOIN tblSupplier AS S ON PS.SupplierID = S.SupplierID
END;
GO

-- 7. Update the location and Zone of a BT Databox. The transaction receives the BT Databox ID, a location and a Zone expressed as a list of coordinates 
--  in latitude, longitude pairs. It updates the location of the  BT Databox and its corresponding Zone. (This transaction may require more than one update query.)
DROP PROCEDURE IF EXISTS updateBTDataboxLocation;
GO
CREATE PROCEDURE updateBTDataboxLocation @pBTDataboxID INTEGER, @pLat DECIMAL(10, 7), @pLOOONG DECIMAL(10, 7)
AS
BEGIN
    
END;
GO

--8.  Delete the data collected for a given Contract. 
-- The transaction receives a Contract ID, the data collected for a Contract is deleted.
DROP PROCEDURE IF EXISTS deleteContractData;
GO
CREATE PROCEDURE deleteContractData @pContractID INTEGER
AS
BEGIN
    UPDATE tblContractedScientifcData
    SET isDeleted = 1
    WHERE ContractID = pContractID;
END;
GO

-- 9. Write a query to be used to INSERT data from a BT Databox to 
-- its stored data on the Being There database. The transaction receives the  BTDataboxID.
DROP PROCEDURE IF EXISTS insertBTDataboxData;
GO
CREATE PROCEDURE insertBTDataboxData @pBTDataboxID INTEGER, @pLongitude Decimal(10, 7), @pLatitude Decimal(10, 7), @pAltitude Integer, @pHumidity Decimal(4, 2), @pTempearture Decimal(5, 2), @pAmbientLightStrenght Decimal(11, 4), @pRecordingTime DATETIME 
AS
BEGIN
    INSERT INTO tblScientificData INTO tblID.ID VALUES (pBTDataboxID, pLongitude, pLatitude, pAltitude, pHumidity, pTempearture, pAmbientLightStrenght, pRecordingTime);
END;
GO

EXEC createDBBeingThere();

--  procedure sales from tblsalespersonName
--  @psalesname varchar(50)
--  as begin select
--  from sbufirstname, subsecondname, subscripber addresss, discount
--  tblsalesperson as sp join
--  tblsubscription as sub on sp.salesid = salesid = sbu.salesidwhere 
--  where sp.name = @psalesname
-- 
--  exec showsales Jane
