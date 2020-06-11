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
        [MinimumLatitude] Decimal(10, 7),
        [MaximumLatitude] Decimal (10, 7),
        [MinimumLongitude] Decimal (10, 7),
        [MaximumLongitude] Decimal (10, 7)
    }
GO
    CREATE TABLE BeingThere.tblCondition {
        [ConditionID] INT IDENTITY,
        [ConditionDescription] VARCHAR(255)
     }
GO
    CREATE TABLE BeingThere.tblDirector {

     }
GO
    CREATE TABLE BeingThere.tblAdministrationExecutive {

     }
GO
    CREATE TABLE BeingThere.tblSalesperson {

     }
GO
    CREATE TABLE BeingThere.tblMaintenancePerson { 

    }
GO
    CREATE TABLE BeingThere.tblDrone {

     }
GO
    CREATE TABLE BeingThere.tblStaff {

     }
GO
    CREATE TABLE BeingThere.tblScientificData {

     }
GO
    CREATE TABLE BeingThere.tblBTDatabox { 

    }
GO
    CREATE TABLE BeingThere.tblPart {

     }
GO
    CREATE TABLE BeingThere.tblSupplier {

     }
GO
    CREATE TABLE BeingThere.tblVideoStream {

     }
GO
    CREATE TABLE BeingThere.tblPostCode {

     }
GO
    CREATE TABLE BeingThere.tblAddress {

     }
GO
    CREATE TABLE BeingThere.tblAccount { 

    }
GO
    CREATE TABLE BeingThere.tblCustomer { 

    }
GO
    CREATE TABLE BeingThere.tblPayment { 

    }
GO
    CREATE TABLE BeingThere.tblDroneOwner { 

    }
GO
    CREATE TABLE BeingThere.tblContractee {

     }
GO
    CREATE TABLE BeingThere.tblSubscriber { 

    }
GO
    CREATE TABLE BeingThere.tblDiscount {

     }
GO
    CREATE TABLE BeingThere.tblSubscription {

     }
GO
    CREATE TABLE BeingThere.tblGold { 

    }
GO
    CREATE TABLE BeingThere.tblPlatinum {

     }
GO
    CREATE TABLE BeingThere.tblSuperPlatinum {

     }
GO
    CREATE TABLE BeingThere.tblPriceChange {

     }
GO
    CREATE TABLE BeingThere.tblBTDataboxStream { 
        
    }
GO
    CREATE TABLE BeingThere.tblBTDataboxData {

     }
GO
    CREATE TABLE BeingThere.tblBTDataboxPart {

     }
GO
    CREATE TABLE BeingThere.tblBTDataboxZone {

     }
GO
    CREATE TABLE BeingThere.tblSalespersonStore { 

    }
GO
    CREATE TABLE BeingThere.tblSale {

     }
GO
    CREATE TABLE BeingThere.tblVideoStreamViewer {

     }
GO
    CREATE TABLE BeingThere.tblVideoStreamController {

     }
GO
    CREATE TABLE BeingThere.tblMaintenancePart { 

    }
GO
    CREATE TABLE BeingThere.tblPartSupplier { 

    }
GO
    CREATE TABLE BeingThere.tblOrder { 

    }
GO
    CREATE TABLE BeingThere.tblOrderItem {

     }
GO
    CREATE TABLE BeingThere.tblZoneCountry { 

    }
GO
    CREATE TABLE BeingThere.tblZoneCondition {

     }
GO
    CREATE TABLE BeingThere.tblSubscriptionZone {

     }
GO
    CREATE TABLE BeingThere.tblSubscriptionBTDatabox {

     }
GO
    CREATE TABLE BeingThere.tblContract {

     }
GO
    CREATE TABLE BeingThere.tblContractedBTDatabox {

     }
GO
    CREATE TABLE BeingThere.tblContractedZone {

     }
GO
    CREATE TABLE BeingThere.tblContractScientificData {

     }
GO
    CREATE TABLE BeingThere.tblStaffRole {

     }
GO
    CREATE TABLE BeingThere.tblOwnsDataRights {

     }
GO
    CREATE TABLE BeingThere.tblOwnsVideoRights {
        
     }
GO