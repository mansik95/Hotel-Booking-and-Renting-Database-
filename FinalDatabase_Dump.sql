-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: mydb
-- ------------------------------------------------------
-- Server version	5.7.19-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `airbnb earnings`
--

DROP TABLE IF EXISTS `airbnb earnings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `airbnb earnings` (
  `PAYMENT_PaymentID` int(11) NOT NULL,
  `EarningsAmount` double NOT NULL,
  PRIMARY KEY (`PAYMENT_PaymentID`),
  CONSTRAINT `fk_AIRBNB EARNINGS_PAYMENT1` FOREIGN KEY (`PAYMENT_PaymentID`) REFERENCES `payment` (`PaymentID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airbnb earnings`
--

LOCK TABLES `airbnb earnings` WRITE;
/*!40000 ALTER TABLE `airbnb earnings` DISABLE KEYS */;
INSERT INTO `airbnb earnings` VALUES (1,140),(2,140),(3,280),(4,105),(5,116.19999999999999);
/*!40000 ALTER TABLE `airbnb earnings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `booking` (
  `BookingID` int(11) NOT NULL,
  `BookingStartDate` date NOT NULL,
  `BookingEndDate` date NOT NULL,
  `BookingStatus` enum('OPEN','CANCELLED') NOT NULL,
  `HouseID` int(11) NOT NULL,
  `CustomerID` int(11) NOT NULL,
  `FinalCost` double DEFAULT NULL,
  `TimeStamp` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`BookingID`),
  KEY `fk_BOOKING_HOUSE1_idx` (`HouseID`),
  KEY `fk_BOOKING_CUSTOMER1_idx` (`CustomerID`),
  CONSTRAINT `fk_BOOKING_CUSTOMER1` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_BOOKING_HOUSE1` FOREIGN KEY (`HouseID`) REFERENCES `house` (`HouseID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES (1,'2017-12-08','2017-12-12','OPEN',1,1,200,'2017-12-12 02:31:02.000000'),(2,'2018-01-01','2018-01-03','OPEN',1,1,200,'2017-12-12 02:43:19.000000'),(3,'2018-03-08','2018-03-12','OPEN',2,2,400,'2017-12-12 02:45:41.000000'),(4,'2017-12-23','2017-12-25','OPEN',3,3,150,'2017-12-12 02:46:39.000000'),(5,'2017-12-29','2017-12-31','OPEN',6,4,166,'2017-12-12 02:54:13.000000'),(6,'2018-02-08','2018-02-14','CANCELLED',5,4,120,'2017-12-12 02:55:11.000000');
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger booking_validation
after insert
on booking
for each row
begin
if (new.HouseID in (select BookingID from booking))
then
if ((new.BookingstartDate < any (select BookingEndDate from Booking)) and (new.BookingStartDate > any(select BookingStartDAte from booking)))
then
set @bookingID=new.BookingID;
end if;
end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger refund_policy
after update
on booking
for each row 
begin
if new.bookingStatus= 'cancelled'
then
insert into refund (payment_paymentID) select (paymentID)from payment where payment.bookingID=new.bookingID ;
end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `booking_dummy`
--

DROP TABLE IF EXISTS `booking_dummy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `booking_dummy` (
  `BookingID` int(11) DEFAULT NULL,
  `BookingStartDate` date DEFAULT NULL,
  `BookingEndDate` date DEFAULT NULL,
  `BookingStatus` varchar(20) DEFAULT NULL,
  `HouseID` int(11) DEFAULT NULL,
  `CustomerID` int(11) DEFAULT NULL,
  `FinalCost` double DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_dummy`
--

LOCK TABLES `booking_dummy` WRITE;
/*!40000 ALTER TABLE `booking_dummy` DISABLE KEYS */;
INSERT INTO `booking_dummy` VALUES (1,'2017-12-08','2017-12-12','OPEN',1,1,200,'2017-12-12 02:31:02'),(2,'2018-01-01','2018-01-03','OPEN',1,1,200,'2017-12-12 02:43:19'),(3,'2018-03-08','2018-03-12','OPEN',2,2,400,'2017-12-12 02:45:41'),(4,'2017-12-23','2017-12-25','OPEN',3,3,150,'2017-12-12 02:46:39'),(5,'2017-12-29','2017-12-31','OPEN',6,4,166,'2017-12-12 02:54:13'),(6,'2018-02-08','2018-02-14','OPEN',5,4,120,'2017-12-12 02:55:11');
/*!40000 ALTER TABLE `booking_dummy` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger insert_into_paymenttable
after insert
on booking_dummy
for each row
begin
insert into payment(paymentAmount, timeStamp,BookingID) values (new.finalCost,now(),new.BookingID);
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `create_person_table_logs`
--

DROP TABLE IF EXISTS `create_person_table_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `create_person_table_logs` (
  `LOGID` int(11) NOT NULL AUTO_INCREMENT,
  `PersonID` int(11) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `TimeStamp` datetime DEFAULT NULL,
  PRIMARY KEY (`LOGID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `create_person_table_logs`
--

LOCK TABLES `create_person_table_logs` WRITE;
/*!40000 ALTER TABLE `create_person_table_logs` DISABLE KEYS */;
INSERT INTO `create_person_table_logs` VALUES (1,11,'rituja.gupte@gmail.com','6581cf9c91b7a002dfbbe8536e8f57b3','2017-12-13 17:11:51');
/*!40000 ALTER TABLE `create_person_table_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `CustomerID` int(11) NOT NULL,
  `PaymentType` enum('CREDIT CARD','DEBIT CARD') NOT NULL,
  `CardNumber` varchar(20) NOT NULL,
  `SecurityCode` varchar(5) NOT NULL,
  `NameOnCard` varchar(100) NOT NULL,
  PRIMARY KEY (`CustomerID`),
  CONSTRAINT `fk_CUSTOMER_PERSON1` FOREIGN KEY (`CustomerID`) REFERENCES `person` (`PersonID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'CREDIT CARD','1234567887654321','234','Sanika Bhagat'),(2,'DEBIT CARD','4779967699739193','436','Gauri Chavan'),(3,'CREDIT CARD','3623807819164948','293','Vikas Singh'),(4,'DEBIT CARD','1234567887654321','236','Himanshu Bhagat'),(5,'CREDIT CARD','8341245715421217','987','Sadhana Bhagat'),(6,'DEBIT CARD','1748590099750292','679','Sambhaji Bhagat'),(7,'CREDIT CARD','2345678912345678','762','Preshita Chaudhari');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `customer_good_ratings_by_host`
--

DROP TABLE IF EXISTS `customer_good_ratings_by_host`;
/*!50001 DROP VIEW IF EXISTS `customer_good_ratings_by_host`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `customer_good_ratings_by_host` AS SELECT 
 1 AS `customerID`,
 1 AS `firstName`,
 1 AS `lastName`,
 1 AS `hostComments`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `customer_not_written_review`
--

DROP TABLE IF EXISTS `customer_not_written_review`;
/*!50001 DROP VIEW IF EXISTS `customer_not_written_review`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `customer_not_written_review` AS SELECT 
 1 AS `CUSTOMERID`,
 1 AS `FirstName`,
 1 AS `LastName`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `facilities`
--

DROP TABLE IF EXISTS `facilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facilities` (
  `FacilityID` int(11) NOT NULL AUTO_INCREMENT,
  `FacilityName` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`FacilityID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facilities`
--

LOCK TABLES `facilities` WRITE;
/*!40000 ALTER TABLE `facilities` DISABLE KEYS */;
INSERT INTO `facilities` VALUES (1,'Wifi'),(2,'AC'),(3,'Closet/Drawer'),(4,'TV'),(5,'Heat'),(6,'Breakfast'),(7,'Workspace');
/*!40000 ALTER TABLE `facilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feedback` (
  `FeedbackID` int(11) NOT NULL AUTO_INCREMENT,
  `FeedbackDescription` mediumtext NOT NULL,
  `FeedbackDate` datetime(6) NOT NULL,
  `PersonID` int(11) NOT NULL,
  PRIMARY KEY (`FeedbackID`),
  KEY `fk_FEEDBACK_PERSON1_idx` (`PersonID`),
  CONSTRAINT `fk_FEEDBACK_PERSON1` FOREIGN KEY (`PersonID`) REFERENCES `person` (`PersonID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` VALUES (1,'AirBNB is good','2017-12-13 01:26:57.000000',1),(2,'AirBNB is the best renting website','2017-12-13 01:26:57.000000',1),(3,'AirBNB is moderate','2017-12-13 01:26:57.000000',2),(4,'AirBNB provides good services','2017-12-13 01:26:57.000000',3),(5,'AirBNB is good','2017-12-13 01:26:57.000000',1),(6,'AirBNB is bad','2017-12-13 01:26:57.000000',6),(7,'AirBNB service is worse than many other websites','2017-12-13 01:26:57.000000',5);
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host`
--

DROP TABLE IF EXISTS `host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host` (
  `HostID` int(11) NOT NULL,
  `BankName` varchar(100) NOT NULL,
  `AccountTYpe` enum('CHECKING','SAVINGS') NOT NULL,
  `AccountNumber` varchar(20) NOT NULL,
  `RoutingNumber` varchar(20) NOT NULL,
  PRIMARY KEY (`HostID`),
  CONSTRAINT `fk_HOST_PERSON1` FOREIGN KEY (`HostID`) REFERENCES `person` (`PersonID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host`
--

LOCK TABLES `host` WRITE;
/*!40000 ALTER TABLE `host` DISABLE KEYS */;
INSERT INTO `host` VALUES (1,'Santander','CHECKING','36552587167','75908686'),(2,'BOFA','CHECKING','02812679024','38051212'),(3,'Citi','CHECKING','97487333861','65388827');
/*!40000 ALTER TABLE `host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host earnings`
--

DROP TABLE IF EXISTS `host earnings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host earnings` (
  `PAYMENT_PaymentID` int(11) NOT NULL,
  `EarningsAmount` double NOT NULL,
  PRIMARY KEY (`PAYMENT_PaymentID`),
  CONSTRAINT `fk_HOST EARNINGS_PAYMENT1` FOREIGN KEY (`PAYMENT_PaymentID`) REFERENCES `payment` (`PaymentID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host earnings`
--

LOCK TABLES `host earnings` WRITE;
/*!40000 ALTER TABLE `host earnings` DISABLE KEYS */;
INSERT INTO `host earnings` VALUES (1,60),(2,60),(3,120),(4,45),(5,49.8);
/*!40000 ALTER TABLE `host earnings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `host_bad_ratings_by_customer`
--

DROP TABLE IF EXISTS `host_bad_ratings_by_customer`;
/*!50001 DROP VIEW IF EXISTS `host_bad_ratings_by_customer`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `host_bad_ratings_by_customer` AS SELECT 
 1 AS `hostID`,
 1 AS `firstName`,
 1 AS `lastName`,
 1 AS `customerComments`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `house`
--

DROP TABLE IF EXISTS `house`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `house` (
  `HouseID` int(11) NOT NULL AUTO_INCREMENT,
  `StreetNumber` varchar(10) NOT NULL,
  `StreetName` varchar(100) NOT NULL,
  `AptNumber` varchar(10) NOT NULL,
  `Availability` enum('AVAILABLE','BOOKED') NOT NULL,
  `CostPerNight` double NOT NULL,
  `LocationID` int(11) NOT NULL,
  `HostID` int(11) NOT NULL,
  PRIMARY KEY (`HouseID`),
  KEY `fk_HOUSE_LOCATION1_idx` (`LocationID`),
  KEY `fk_HOUSE_HOST1_idx` (`HostID`),
  CONSTRAINT `fk_HOUSE_HOST1` FOREIGN KEY (`HostID`) REFERENCES `host` (`HostID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_HOUSE_LOCATION1` FOREIGN KEY (`LocationID`) REFERENCES `location` (`LocationID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `house`
--

LOCK TABLES `house` WRITE;
/*!40000 ALTER TABLE `house` DISABLE KEYS */;
INSERT INTO `house` VALUES (1,'19','Saint Germain Street','6','AVAILABLE',50,112,1),(2,'10','May Street','8','AVAILABLE',100,110,1),(3,'53','BLack Canyon','54','AVAILABLE',75,111,2),(4,'23','Arizona Grand','2','AVAILABLE',120,111,3),(5,'27','Cave Creek','1024','AVAILABLE',20,111,2),(6,'75','Cityview','612','AVAILABLE',83,112,2);
/*!40000 ALTER TABLE `house` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `house_facilities`
--

DROP TABLE IF EXISTS `house_facilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `house_facilities` (
  `FacilityID` int(11) NOT NULL,
  `HouseID` int(11) NOT NULL,
  PRIMARY KEY (`FacilityID`,`HouseID`),
  KEY `fk_FACILITIES_has_HOUSE_HOUSE1_idx` (`HouseID`),
  KEY `fk_FACILITIES_has_HOUSE_FACILITIES1_idx` (`FacilityID`),
  CONSTRAINT `fk_FACILITIES_has_HOUSE_FACILITIES1` FOREIGN KEY (`FacilityID`) REFERENCES `facilities` (`FacilityID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_FACILITIES_has_HOUSE_HOUSE1` FOREIGN KEY (`HouseID`) REFERENCES `house` (`HouseID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `house_facilities`
--

LOCK TABLES `house_facilities` WRITE;
/*!40000 ALTER TABLE `house_facilities` DISABLE KEYS */;
INSERT INTO `house_facilities` VALUES (1,1),(2,1),(4,1),(5,1),(1,2),(2,2),(3,2),(4,2),(5,2),(6,2),(7,2),(1,3),(5,4),(6,4),(1,5),(5,5),(6,5),(7,5),(1,6),(4,6),(5,6);
/*!40000 ALTER TABLE `house_facilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location` (
  `LocationID` int(11) NOT NULL AUTO_INCREMENT,
  `Country` varchar(100) NOT NULL,
  `State` varchar(100) DEFAULT NULL,
  `City` varchar(100) DEFAULT NULL,
  `Zipcode` varchar(10) NOT NULL,
  PRIMARY KEY (`LocationID`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (110,'US','New York','Huntington Station','11746'),(111,'US','Arizona','Pheonix','85001'),(112,'US','Massachusetts','Boston','2115');
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message` (
  `messagename` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment` (
  `PaymentID` int(11) NOT NULL AUTO_INCREMENT,
  `PaymentAmount` double NOT NULL,
  `TimeStamp` datetime(6) NOT NULL,
  `BookingID` int(11) NOT NULL,
  PRIMARY KEY (`PaymentID`),
  KEY `fk_PAYMENT_BOOKING1_idx` (`BookingID`),
  CONSTRAINT `fk_PAYMENT_BOOKING1` FOREIGN KEY (`BookingID`) REFERENCES `booking` (`BookingID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,200,'2017-12-12 02:33:20.000000',1),(2,200,'2017-12-12 02:43:37.000000',2),(3,400,'2017-12-12 02:46:27.000000',3),(4,150,'2017-12-12 02:47:01.000000',4),(5,166,'2017-12-12 02:54:40.000000',5),(6,120,'2017-12-12 02:55:29.000000',6);
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger airbnb_trigger
after insert
on payment
for each row
begin
insert into `airbnb earnings` values (new.paymentID,new.paymentAmount*0.7);
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger host_earnings_trigger
after insert
on payment
for each row
begin
insert into `host earnings` values (new.paymentID,new.paymentAmount*0.3);
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person` (
  `PersonID` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `EmailID` varchar(100) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `Photo` tinyblob NOT NULL,
  `BirthDate` date NOT NULL,
  `PhoneNumber` varchar(20) NOT NULL,
  `Gender` enum('MALE','FEMALE') DEFAULT NULL,
  `AccountStatus` enum('ACTIVE','INACTIVE') NOT NULL DEFAULT 'ACTIVE',
  PRIMARY KEY (`PersonID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (1,'Sanika','Bhagat','sanika.s.bhagat@gmail.com','a384b6463fc216a5f8ecb6670f86456a','C:UserssanikDesktopNEU SubjectsDMDDER1.png','1993-12-08','8578004072','MALE','ACTIVE'),(2,'Gauri','Chavan','gauri.chavan@gmail.com','eb89f40da6a539dd1b1776e522459763','C:UserssanikDesktopNEU SubjectsDMDDER1.png','1992-09-05','5186704072','FEMALE','ACTIVE'),(3,'Vikas','Singh','vikas.singh@gmail.com','79f7d5a51acf11c304f1fd19ca867252','C:UserssanikDesktopNEU SubjectsDMDDER1.png','1993-12-08','8576534689','MALE','ACTIVE'),(4,'Himanshu','Bhagat','himanshu.s.bhagat@gmail.com','ba6cfb78f61e303e7ee3ff5ff9d3059d','C:UserssanikDesktopNEU SubjectsDMDDER1.png','1989-05-12','8572688090','MALE','ACTIVE'),(5,'Sadhana','Bhagat','sadhana.s.bhagat@gmail.com','bd1f3803edf501d1dc74f78eb2168164','C:UserssanikDesktopNEU SubjectsDMDDER1.png','1964-09-23','9967307187','FEMALE','ACTIVE'),(6,'Sambhaji','Bhagat','sambhaji.s.bhagat@gmail.com','72bf8bfbf1c2a6aa0a7681a4b29e7005','C:UserssanikDesktopNEU SubjectsDMDDER1.png','1962-07-14','9820251011','MALE','ACTIVE'),(7,'Preshita','Chaudhari','preshita.chaudhari@gmail.com','a0a587339e6b88886f002c4246ad759c','C:UserssanikDesktopNEU SubjectsDMDDER1.png','1993-11-26','9969169369','FEMALE','ACTIVE'),(8,'Tanmayee','Varpe','tanmayee.varpe@gmail.com','971ea053d62af841c6ab93c12763893b','C:UserssanikDesktopNEU SubjectsDMDDER1.png','1993-12-31','9833304498','FEMALE','ACTIVE'),(9,'Mohit','Nangare','mohit.nangare@gmail.com','8158abc12bffcea65c27539643d216b5','C:UserssanikDesktopNEU SubjectsDMDDER1.png','1993-10-23','9324022277','MALE','ACTIVE'),(10,'Rituja','Gupte','rituja.gupte@gmail.com','62b30838aeeba59e3564193d6b65501c','C:UserssanikDesktopNEU SubjectsDMDDER1.png','1992-12-12','9773424474','FEMALE','ACTIVE'),(11,'Rituja','Gupte','rituja.gupte@gmail.com','62b30838aeeba59e3564193d6b65501c','C:UserssanikDesktopNEU SubjectsDMDDER1.png','1992-12-12','9773424474','FEMALE','ACTIVE');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger create_person_log
		after insert
		on person
		for each row
		begin
		insert into create_person_table_logs(personid,email,password,timestamp) values (new.personID,new.emailID,md5(new.password),now());
		end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger update_person_record
after update
on person
for each row
begin 
if(new.firstName!=old.firstName) then
insert into person_table_update_logs(PersonId,OldFirstName,NewFirstName,TimeStamp)
values (new.personID,old.firstName,new.firstName,now());
end if;

if(new.lastName!=old.lastName) then
insert into person_table_update_logs(PersonId,OldLastName,NewLastName,TimeStamp)
values (new.personID,old.lastName,new.lastName,now());
end if;

if(new.emailID!=old.emailID) then
insert into person_table_update_logs(PersonId,Oldemail,Newemail,TimeStamp)
values (new.personID,old.emailID,new.emailID,now());
end if;

if(new.password!=old.password) then
insert into person_table_update_logs(PersonId,Oldpassword,Newpassword,TimeStamp)
values (new.personID,md5(old.password),md5(new.password),now());
end if;

if(new.photo!=old.photo) then
insert into person_table_update_logs(PersonId,Oldphoto,Newphoto,TimeStamp)
values (new.personID,old.photo,new.photo,now());
end if;

if(new.birthDate!=old.birthDate) then
insert into person_table_update_logs(PersonId,OldbirthDate,NewbirthDate,TimeStamp)
values (new.personID,old.birthDate,new.birthDate,now());
end if;

if(new.phoneNumber!=old.phoneNumber) then
insert into person_table_update_logs(PersonId,OldphoneNumber,NewphoneNumber,TimeStamp)
values (new.personID,old.phoneNumber,new.phoneNumber,now());
end if;

if(new.gender!=old.gender) then
insert into person_table_update_logs(PersonId,Oldgender,Newgender,TimeStamp)
values (new.personID,old.gender,new.gender,now());
end if;

if(new.accountStatus!=old.accountStatus) then
insert into person_table_update_logs(PersonId,OldaccountStatus,NewaccountStatus,TimeStamp)
values (new.personID,old.accountStatus,new.accountStatus,now());
end if;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger delete_house_of_host
after update
on person
for each row
begin
if new.accountStatus= 'inactive'
then
delete from house where house.hostID=new.personID;
end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger delete_customer_without_booking
after update
on person
for each row
begin
if new.accountStatus= 'inactive'
then
if (new.personID in (Select customerID from booking))
then 
insert into message values ('Cannot delete customer');
end if;
else
delete from booking where booking.customerID=new.personID;
end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `person_table_update_logs`
--

DROP TABLE IF EXISTS `person_table_update_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_table_update_logs` (
  `LogID` int(11) NOT NULL AUTO_INCREMENT,
  `PersonID` int(11) DEFAULT NULL,
  `OldFirstName` varchar(50) DEFAULT NULL,
  `NewFirstName` varchar(50) DEFAULT NULL,
  `OldLastName` varchar(50) DEFAULT NULL,
  `NewLastName` varchar(50) DEFAULT NULL,
  `OldEmail` varchar(50) DEFAULT NULL,
  `NewEmail` varchar(50) DEFAULT NULL,
  `OldPassword` varchar(50) DEFAULT NULL,
  `NewPassword` varchar(50) DEFAULT NULL,
  `OldPhoto` tinyblob,
  `NewPhoto` tinyblob,
  `OldBirthDate` date DEFAULT NULL,
  `NewBirthDate` date DEFAULT NULL,
  `OldPhoneNumber` varchar(15) DEFAULT NULL,
  `NewPhoneNumber` varchar(15) DEFAULT NULL,
  `OldGender` enum('MALE','FEMALE') DEFAULT NULL,
  `NewGender` enum('MALE','FEMALE') DEFAULT NULL,
  `OldAccountStatus` enum('ACTIVE','INACTIVE') DEFAULT NULL,
  `NewAccountStatus` enum('ACTIVE','INACTIVE') DEFAULT NULL,
  `TimeStamp` datetime DEFAULT NULL,
  PRIMARY KEY (`LogID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_table_update_logs`
--

LOCK TABLES `person_table_update_logs` WRITE;
/*!40000 ALTER TABLE `person_table_update_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `person_table_update_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rating`
--

DROP TABLE IF EXISTS `rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rating` (
  `RatingID` int(11) NOT NULL AUTO_INCREMENT,
  `CustomerRating` varchar(2) NOT NULL,
  `CustomerComments` mediumtext NOT NULL,
  `HostRating` varchar(2) NOT NULL,
  `HostComments` mediumtext NOT NULL,
  `CustomerID` int(11) NOT NULL,
  `HostID` int(11) NOT NULL,
  `BookingID` int(11) NOT NULL,
  PRIMARY KEY (`RatingID`),
  KEY `fk_RATING_CUSTOMER1_idx` (`CustomerID`),
  KEY `fk_RATING_HOST1_idx` (`HostID`),
  KEY `fk_RATING_BOOKING1_idx` (`BookingID`),
  CONSTRAINT `fk_RATING_BOOKING1` FOREIGN KEY (`BookingID`) REFERENCES `booking` (`BookingID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_RATING_CUSTOMER1` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_RATING_HOST1` FOREIGN KEY (`HostID`) REFERENCES `host` (`HostID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rating`
--

LOCK TABLES `rating` WRITE;
/*!40000 ALTER TABLE `rating` DISABLE KEYS */;
INSERT INTO `rating` VALUES (1,'2','Very Rude and Arrogant','2','Very loud and left the house dirty',1,1,1),(2,'5','Best Host ever','4','Nice Guests',1,1,2),(3,'1','Poor Treatment','2','Good enough',2,2,3),(4,'4','Good','4','Decent People',3,3,4),(5,'3','Boring Host','4','Friendly Guests',4,2,5),(6,'2','Hostile','1','Very ill mannered',4,2,6);
/*!40000 ALTER TABLE `rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `refund`
--

DROP TABLE IF EXISTS `refund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `refund` (
  `PAYMENT_PaymentID` int(11) NOT NULL,
  `RefundDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`PAYMENT_PaymentID`),
  CONSTRAINT `fk_REFUND_PAYMENT1` FOREIGN KEY (`PAYMENT_PaymentID`) REFERENCES `payment` (`PaymentID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refund`
--

LOCK TABLES `refund` WRITE;
/*!40000 ALTER TABLE `refund` DISABLE KEYS */;
INSERT INTO `refund` VALUES (3,'2017-12-12 12:23:06'),(6,'2017-12-13 19:28:11');
/*!40000 ALTER TABLE `refund` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger delete_airbnb_host_earnings
after insert
on refund
for each row
begin
delete from `airbnb earnings` where Payment_paymentID=new.Payment_paymentID;
delete from `host earnings` where Payment_paymentID=new.Payment_paymentID;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review` (
  `ReviewID` int(11) NOT NULL AUTO_INCREMENT,
  `ReviewComments` mediumtext NOT NULL,
  `ReviewDate` datetime(6) DEFAULT NULL,
  `CustomerID` int(11) NOT NULL,
  `HouseID` int(11) NOT NULL,
  PRIMARY KEY (`ReviewID`),
  KEY `fk_REVIEW_CUSTOMER1_idx` (`CustomerID`),
  KEY `fk_REVIEW_HOUSE1_idx` (`HouseID`),
  CONSTRAINT `fk_REVIEW_CUSTOMER1` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_REVIEW_HOUSE1` FOREIGN KEY (`HouseID`) REFERENCES `house` (`HouseID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,'The house is just perfect for a family vacation. Totally enjoyed staying here','2017-10-08 11:00:00.000000',1,6),(2,'The house is the most beautiful house I have ever stayed in','2017-09-08 09:00:00.000000',2,2),(3,'The house lacked the basic amenities such as heat and wifi. Not a good experience','2017-09-08 01:00:00.000000',4,5),(4,'There were no hotels or stores close to this house. I almost died of hunger.','2017-01-01 12:00:00.000000',4,6),(5,'The house has a nice scenic view','2017-08-08 09:00:00.000000',1,1),(6,'Did not enoy staying here.','2016-12-23 09:00:00.000000',3,3),(7,'I can never get bored of this house. Just love staying here.','2017-12-13 02:16:50.000000',2,2),(8,'My parents love this house because it has a country touch to it','2017-09-08 09:00:00.000000',1,4),(9,'Worst place ever','2017-09-08 09:00:00.000000',6,3),(10,'Nice place','2017-09-08 09:00:00.000000',4,2);
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `view_max_customer_booking`
--

DROP TABLE IF EXISTS `view_max_customer_booking`;
/*!50001 DROP VIEW IF EXISTS `view_max_customer_booking`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_max_customer_booking` AS SELECT 
 1 AS `PersonID`,
 1 AS `FirstName`,
 1 AS `lastName`,
 1 AS `NumberofBookings`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_max_houses_host`
--

DROP TABLE IF EXISTS `view_max_houses_host`;
/*!50001 DROP VIEW IF EXISTS `view_max_houses_host`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_max_houses_host` AS SELECT 
 1 AS `hostID`,
 1 AS `FirstName`,
 1 AS `lastName`,
 1 AS `NumberofHouses`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_max_houses_location`
--

DROP TABLE IF EXISTS `view_max_houses_location`;
/*!50001 DROP VIEW IF EXISTS `view_max_houses_location`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_max_houses_location` AS SELECT 
 1 AS `LocationID`,
 1 AS `country`,
 1 AS `state`,
 1 AS `city`,
 1 AS `Number of Houses`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_negative_feedback`
--

DROP TABLE IF EXISTS `view_negative_feedback`;
/*!50001 DROP VIEW IF EXISTS `view_negative_feedback`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_negative_feedback` AS SELECT 
 1 AS `FeedbackID`,
 1 AS `FeedbackDescription`,
 1 AS `FeedbackDate`,
 1 AS `PersonID`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_positive_feedback`
--

DROP TABLE IF EXISTS `view_positive_feedback`;
/*!50001 DROP VIEW IF EXISTS `view_positive_feedback`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_positive_feedback` AS SELECT 
 1 AS `FeedbackID`,
 1 AS `FeedbackDescription`,
 1 AS `FeedbackDate`,
 1 AS `PersonID`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'mydb'
--

--
-- Dumping routines for database 'mydb'
--
/*!50003 DROP PROCEDURE IF EXISTS `facility_selection` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `facility_selection`(in facility1 varchar(20))
begin
select * from house
where houseID in (select houseID from house_facilities where facilityID = all(select facilityID from facilities where facilityName=facility1 ));
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `host_earnings_particular_host` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `host_earnings_particular_host`(in hostID1 int)
begin
select sum(earningsamount) as 'Total Earnings By This Host' from `host earnings` 
where payment_paymentID in(select paymentID from payment where bookingID in(select bookingID from booking where houseID in(select houseID from house where hostID=hostID1)));
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_into_dummy` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_into_dummy`()
begin
insert into booking_dummy 
select * from booking order by timestamp desc limit 1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `p1`()
begin 
delete from booking where bookingID=@bookingID;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_active_person` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_active_person`(in email varchar(200))
begin
update person set accountstatus='active'
where EMailID=email;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_bookingcost_in_booking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_bookingcost_in_booking`()
begin
/*create view view_booking*/
update booking join
(select booking.houseid,(booking.BookingEndDate-booking.BookingStartDate)*house.CostPerNight 
as bookingAmount from booking inner join house on house.houseid=booking.houseid) temp
on booking.houseid=temp.houseid
set finalCost=temp.bookingAmount;
select bookingId,houseID,bookingStartDate,bookingEndDate,finalCost from Booking;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `total_airbnb_earnings` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `total_airbnb_earnings`()
select sum(EarningsAmount) as 'Total AirBNB Earnings' from `airbnb earnings`
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `customer_good_ratings_by_host`
--

/*!50001 DROP VIEW IF EXISTS `customer_good_ratings_by_host`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `customer_good_ratings_by_host` AS select `rating`.`CustomerID` AS `customerID`,`person`.`FirstName` AS `firstName`,`person`.`LastName` AS `lastName`,`rating`.`HostComments` AS `hostComments` from (`rating` join `person` on((`rating`.`CustomerID` = `person`.`PersonID`))) where (`rating`.`CustomerRating` > 2) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `customer_not_written_review`
--

/*!50001 DROP VIEW IF EXISTS `customer_not_written_review`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `customer_not_written_review` AS select `c`.`CustomerID` AS `CUSTOMERID`,`p`.`FirstName` AS `FirstName`,`p`.`LastName` AS `LastName` from (`customer` `c` join `person` `p` on((`c`.`CustomerID` = `p`.`PersonID`))) where (not(`c`.`CustomerID` in (select `r`.`CustomerID` from `review` `r`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `host_bad_ratings_by_customer`
--

/*!50001 DROP VIEW IF EXISTS `host_bad_ratings_by_customer`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `host_bad_ratings_by_customer` AS select `rating`.`HostID` AS `hostID`,`person`.`FirstName` AS `firstName`,`person`.`LastName` AS `lastName`,`rating`.`CustomerComments` AS `customerComments` from (`rating` join `person` on((`rating`.`HostID` = `person`.`PersonID`))) where (`rating`.`CustomerRating` < 3) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_max_customer_booking`
--

/*!50001 DROP VIEW IF EXISTS `view_max_customer_booking`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_max_customer_booking` AS select `person`.`PersonID` AS `PersonID`,`person`.`FirstName` AS `FirstName`,`person`.`LastName` AS `lastName`,count(0) AS `NumberofBookings` from (`booking` join `person` on((`booking`.`CustomerID` = `person`.`PersonID`))) group by `booking`.`CustomerID` order by `NumberofBookings` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_max_houses_host`
--

/*!50001 DROP VIEW IF EXISTS `view_max_houses_host`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_max_houses_host` AS select `house`.`HostID` AS `hostID`,`person`.`FirstName` AS `FirstName`,`person`.`LastName` AS `lastName`,count(0) AS `NumberofHouses` from (`house` join `person` on((`house`.`HostID` = `person`.`PersonID`))) group by `house`.`HostID` order by `NumberofHouses` desc limit 1 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_max_houses_location`
--

/*!50001 DROP VIEW IF EXISTS `view_max_houses_location`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_max_houses_location` AS select `house`.`LocationID` AS `LocationID`,`location`.`Country` AS `country`,`location`.`State` AS `state`,`location`.`City` AS `city`,count(0) AS `Number of Houses` from (`house` join `location` on((`house`.`LocationID` = `location`.`LocationID`))) group by `house`.`LocationID` order by 'Maximum Houses' */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_negative_feedback`
--

/*!50001 DROP VIEW IF EXISTS `view_negative_feedback`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_negative_feedback` AS select `feedback`.`FeedbackID` AS `FeedbackID`,`feedback`.`FeedbackDescription` AS `FeedbackDescription`,`feedback`.`FeedbackDate` AS `FeedbackDate`,`feedback`.`PersonID` AS `PersonID` from `feedback` where ((`feedback`.`FeedbackDescription` like '%bad%') or (`feedback`.`FeedbackDescription` like '%worse%')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_positive_feedback`
--

/*!50001 DROP VIEW IF EXISTS `view_positive_feedback`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_positive_feedback` AS select `feedback`.`FeedbackID` AS `FeedbackID`,`feedback`.`FeedbackDescription` AS `FeedbackDescription`,`feedback`.`FeedbackDate` AS `FeedbackDate`,`feedback`.`PersonID` AS `PersonID` from `feedback` where ((`feedback`.`FeedbackDescription` like '%good%') or (`feedback`.`FeedbackDescription` like '%best%')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-12-13 21:10:10
