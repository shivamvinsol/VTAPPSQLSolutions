-- MySQL dump 10.13  Distrib 5.6.28, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: DVDRentals
-- ------------------------------------------------------
-- Server version	5.6.28-0ubuntu0.15.04.1

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
-- Table structure for table `AuthorBook`
--

DROP TABLE IF EXISTS `AuthorBook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AuthorBook` (
  `AuthID` smallint(6) NOT NULL,
  `BookID` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`AuthID`,`BookID`),
  KEY `BookID` (`BookID`),
  CONSTRAINT `AuthorBook_ibfk_1` FOREIGN KEY (`AuthID`) REFERENCES `Authors` (`AuthID`),
  CONSTRAINT `AuthorBook_ibfk_2` FOREIGN KEY (`BookID`) REFERENCES `Books` (`BookID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AuthorBook`
--

LOCK TABLES `AuthorBook` WRITE;
/*!40000 ALTER TABLE `AuthorBook` DISABLE KEYS */;
INSERT INTO `AuthorBook` VALUES (1009,12786),(1006,14356),(1008,15729),(1011,15729),(1014,16284),(1010,17695),(1012,19264),(1012,19354);
/*!40000 ALTER TABLE `AuthorBook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Authors`
--

DROP TABLE IF EXISTS `Authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Authors` (
  `AuthID` smallint(6) NOT NULL,
  `AuthFN` varchar(20) DEFAULT NULL,
  `AuthMN` varchar(20) DEFAULT NULL,
  `AuthLN` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`AuthID`),
  KEY `AuthID` (`AuthID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Authors`
--

LOCK TABLES `Authors` WRITE;
/*!40000 ALTER TABLE `Authors` DISABLE KEYS */;
INSERT INTO `Authors` VALUES (1006,'Hunter','S.','Thompson'),(1007,'Joyce','Carol','Oates'),(1008,'Black',NULL,'Elk'),(1009,'Rainer','Maria','Rilke'),(1010,'John','Kennedy','Toole'),(1011,'John','G.','Neihardt'),(1012,'Annie',NULL,'Proulx'),(1013,'Alan',NULL,'Watts'),(1014,'Nelson',NULL,'Algren');
/*!40000 ALTER TABLE `Authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Books`
--

DROP TABLE IF EXISTS `Books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Books` (
  `BookID` smallint(5) unsigned NOT NULL,
  `BookTitle` varchar(50) NOT NULL,
  `Copyright` year(4) NOT NULL,
  PRIMARY KEY (`BookID`),
  KEY `BookID` (`BookID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Books`
--

LOCK TABLES `Books` WRITE;
/*!40000 ALTER TABLE `Books` DISABLE KEYS */;
INSERT INTO `Books` VALUES (11223,'ok',0000),(12345,'Kite Runner',1998),(12346,'Agatha',2000),(12786,'Letters to',1934),(13331,'Winesburg,',1919),(13348,'Harper',2010),(14356,'Hell\'s Ang',1966),(15729,'Black Elk ',1932),(16284,'Noncomform',1996),(17695,'A Confeder',1980),(19264,'Postcards',1992),(19354,'The Shippi',1993),(32340,'Chetan',1953),(65535,'Khaleed',1993);
/*!40000 ALTER TABLE `Books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CDs`
--

DROP TABLE IF EXISTS `CDs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CDs` (
  `CDID` smallint(6) NOT NULL AUTO_INCREMENT,
  `CDName` varchar(50) NOT NULL,
  `InStock` smallint(5) unsigned NOT NULL,
  `OnOrder` smallint(5) unsigned NOT NULL,
  `Reserved` smallint(5) unsigned NOT NULL,
  `Department` enum('Classical','Popular') NOT NULL,
  `Category` varchar(20) NOT NULL,
  `RowUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`CDID`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CDs`
--

LOCK TABLES `CDs` WRITE;
/*!40000 ALTER TABLE `CDs` DISABLE KEYS */;
INSERT INTO `CDs` VALUES (1,'Bloodshot',10,5,3,'Popular','Rock','2017-09-06 08:35:40'),(2,'The Most Favorite Opera Duets',10,5,3,'Classical','Opera','2017-09-06 08:35:40'),(3,'New Orleans Jazz',17,4,1,'Popular','Jazz','2017-09-06 08:35:40'),(4,'Music for Ballet Class',9,4,2,'Classical','Dance','2017-09-06 08:35:40'),(5,'Music for Solo Violin',24,2,5,'Classical','General','2017-09-06 08:35:40'),(6,'Cie li di Toscana',16,6,8,'Classical','Vocal','2017-09-06 08:35:40'),(7,'Mississippi Blues',2,25,6,'Popular','Blues','2017-09-06 08:35:40'),(8,'Pure',32,3,10,'Popular','Jazz','2017-09-06 08:35:40'),(9,'Mud on the Tires',12,15,13,'Popular','Country','2017-09-06 08:35:40'),(10,'The Essence',5,20,10,'Popular','New Age','2017-09-06 08:35:40'),(11,'Embrace',24,11,14,'Popular','New Age','2017-09-06 08:35:40'),(12,'The Magic of Satie',42,17,17,'Classical','General','2017-09-06 08:35:40'),(13,'Swan Lake',25,44,28,'Classical','Dance','2017-09-06 08:35:40'),(14,'25 Classical Favorites',32,15,12,'Classical','General','2017-09-06 08:35:40'),(15,'La Boheme',20,10,5,'Classical','Opera','2017-09-06 08:35:40'),(16,'Bach Cantatas',23,12,8,'Classical','General','2017-09-06 08:35:40'),(17,'Golden Road',23,10,17,'Popular','Country','2017-09-06 08:35:40'),(18,'Live in Paris',18,20,10,'Popular','Jazz','2017-09-06 08:35:40'),(19,'Richland Woman Blues',22,5,7,'Popular','Blues','2017-09-06 08:35:40');
/*!40000 ALTER TABLE `CDs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Customers`
--

DROP TABLE IF EXISTS `Customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Customers` (
  `CustID` smallint(6) NOT NULL AUTO_INCREMENT,
  `CustFN` varchar(20) NOT NULL,
  `CustMN` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`CustID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customers`
--

LOCK TABLES `Customers` WRITE;
/*!40000 ALTER TABLE `Customers` DISABLE KEYS */;
/*!40000 ALTER TABLE `Customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `InStock`
--

DROP TABLE IF EXISTS `InStock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `InStock` (
  `PID` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `InStock`
--

LOCK TABLES `InStock` WRITE;
/*!40000 ALTER TABLE `InStock` DISABLE KEYS */;
/*!40000 ALTER TABLE `InStock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MovieTypes`
--

DROP TABLE IF EXISTS `MovieTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MovieTypes` (
  `MTypeID` varchar(4) NOT NULL,
  `MTypeDescrip` varchar(30) NOT NULL,
  PRIMARY KEY (`MTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MovieTypes`
--

LOCK TABLES `MovieTypes` WRITE;
/*!40000 ALTER TABLE `MovieTypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `MovieTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Orders`
--

DROP TABLE IF EXISTS `Orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Orders` (
  `OrderID` smallint(5) unsigned DEFAULT NULL,
  `ModelID` smallint(6) DEFAULT NULL,
  UNIQUE KEY `OrderID` (`OrderID`,`ModelID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Orders`
--

LOCK TABLES `Orders` WRITE;
/*!40000 ALTER TABLE `Orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `Orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ratings`
--

DROP TABLE IF EXISTS `Ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ratings` (
  `RatingID` varchar(4) NOT NULL,
  `RatingDescrip` varchar(30) NOT NULL,
  PRIMARY KEY (`RatingID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ratings`
--

LOCK TABLES `Ratings` WRITE;
/*!40000 ALTER TABLE `Ratings` DISABLE KEYS */;
/*!40000 ALTER TABLE `Ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Roles`
--

DROP TABLE IF EXISTS `Roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Roles` (
  `RoleID` varchar(4) NOT NULL,
  `RoleDescrip` varchar(30) NOT NULL,
  PRIMARY KEY (`RoleID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Roles`
--

LOCK TABLES `Roles` WRITE;
/*!40000 ALTER TABLE `Roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `Roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Status`
--

DROP TABLE IF EXISTS `Status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Status` (
  `StatID` char(3) NOT NULL,
  `StatDescrip` varchar(20) NOT NULL,
  PRIMARY KEY (`StatID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Status`
--

LOCK TABLES `Status` WRITE;
/*!40000 ALTER TABLE `Status` DISABLE KEYS */;
/*!40000 ALTER TABLE `Status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Studios`
--

DROP TABLE IF EXISTS `Studios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Studios` (
  `StudID` varchar(4) NOT NULL,
  `StudDescrip` varchar(40) NOT NULL,
  PRIMARY KEY (`StudID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Studios`
--

LOCK TABLES `Studios` WRITE;
/*!40000 ALTER TABLE `Studios` DISABLE KEYS */;
/*!40000 ALTER TABLE `Studios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mytbl`
--

DROP TABLE IF EXISTS `mytbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mytbl` (
  `NAME` varchar(20) DEFAULT NULL,
  `AGE` int(2) DEFAULT NULL,
  `SEX` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mytbl`
--

LOCK TABLES `mytbl` WRITE;
/*!40000 ALTER TABLE `mytbl` DISABLE KEYS */;
INSERT INTO `mytbl` VALUES ('LAVANYA',45,'F'),('AMAN',22,'M'),('ADITI',11,'F'),('MAYANK',55,'M');
/*!40000 ALTER TABLE `mytbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mytbl2`
--

DROP TABLE IF EXISTS `mytbl2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mytbl2` (
  `NAME` varchar(20) DEFAULT NULL,
  `AGE` int(2) DEFAULT NULL,
  `SEX` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mytbl2`
--

LOCK TABLES `mytbl2` WRITE;
/*!40000 ALTER TABLE `mytbl2` DISABLE KEYS */;
INSERT INTO `mytbl2` VALUES ('LAVANYA',45,'F'),('AMAN',22,'M'),('ADITI',11,'F'),('MAYANK',55,'M'),('LAVANYA',45,'F'),('AMAN',22,'M'),('ADITI',11,'F'),('MAYANK',55,'M'),('LAVANYA',45,'F'),('AMAN',22,'M'),('ADITI',11,'F'),('MAYANK',55,'M'),('LAVANYA',45,'F'),('AMAN',22,'M'),('ADITI',11,'F'),('MAYANK',55,'M');
/*!40000 ALTER TABLE `mytbl2` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-09-09 13:52:13
