-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: myfood
-- ------------------------------------------------------
-- Server version	5.6.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `food`
--

DROP TABLE IF EXISTS `food`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `food` (
  `food_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` float NOT NULL,
  `fk_restaurantManager` int(11) NOT NULL,
  PRIMARY KEY (`food_id`),
  KEY `FKmbtbwoadapwiqdu38ghb49k26` (`fk_restaurantManager`),
  CONSTRAINT `FKmbtbwoadapwiqdu38ghb49k26` FOREIGN KEY (`fk_restaurantManager`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food`
--

LOCK TABLES `food` WRITE;
/*!40000 ALTER TABLE `food` DISABLE KEYS */;
INSERT INTO `food` VALUES (4,'Pizza Margherita',10,3),(5,'Carbonara',15,3),(6,'Spaghetti',7,3);
/*!40000 ALTER TABLE `food` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `foodorderbill`
--

DROP TABLE IF EXISTS `foodorderbill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `foodorderbill` (
  `foodOrderBill_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `food_id` int(11) NOT NULL,
  `orderBill_id` int(11) NOT NULL,
  PRIMARY KEY (`foodOrderBill_id`),
  KEY `FKab7bxm5xvi3ydpc2sc4e4cmhb` (`food_id`),
  KEY `FKq3wyspy6bchnm9yagjmsyg8ms` (`orderBill_id`),
  CONSTRAINT `FKab7bxm5xvi3ydpc2sc4e4cmhb` FOREIGN KEY (`food_id`) REFERENCES `food` (`food_id`),
  CONSTRAINT `FKq3wyspy6bchnm9yagjmsyg8ms` FOREIGN KEY (`orderBill_id`) REFERENCES `orderbill` (`orderBill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `foodorderbill`
--

LOCK TABLES `foodorderbill` WRITE;
/*!40000 ALTER TABLE `foodorderbill` DISABLE KEYS */;
INSERT INTO `foodorderbill` VALUES (8,3,5,7),(9,1,4,7),(10,3,6,7),(13,1,4,12),(14,7,5,12);
/*!40000 ALTER TABLE `foodorderbill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hibernate_sequence`
--

DROP TABLE IF EXISTS `hibernate_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hibernate_sequence` (
  `next_val` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hibernate_sequence`
--

LOCK TABLES `hibernate_sequence` WRITE;
/*!40000 ALTER TABLE `hibernate_sequence` DISABLE KEYS */;
INSERT INTO `hibernate_sequence` VALUES (15),(15),(15),(15);
/*!40000 ALTER TABLE `hibernate_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderbill`
--

DROP TABLE IF EXISTS `orderbill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderbill` (
  `orderBill_id` int(11) NOT NULL,
  `dateTime` datetime DEFAULT NULL,
  `fk_customer` int(11) NOT NULL,
  `fk_restaurantManager` int(11) NOT NULL,
  PRIMARY KEY (`orderBill_id`),
  KEY `FKnij5ke3pd64musbjc6b10pf27` (`fk_customer`),
  KEY `FK4mlcqfemi877olgvcn0b721oh` (`fk_restaurantManager`),
  CONSTRAINT `FK4mlcqfemi877olgvcn0b721oh` FOREIGN KEY (`fk_restaurantManager`) REFERENCES `user` (`user_id`),
  CONSTRAINT `FKnij5ke3pd64musbjc6b10pf27` FOREIGN KEY (`fk_customer`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderbill`
--

LOCK TABLES `orderbill` WRITE;
/*!40000 ALTER TABLE `orderbill` DISABLE KEYS */;
INSERT INTO `orderbill` VALUES (7,'2019-12-16 20:44:22',2,3),(12,'2019-12-16 20:46:34',11,3);
/*!40000 ALTER TABLE `orderbill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `DTYPE` varchar(31) NOT NULL,
  `user_id` int(11) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `bankAccount` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('Customer',2,'Via Martiri','Emilio PayPal','emilio@gmail.com','emilio','emilio','3932498576','1997-12-04',NULL),('RestaurantManager',3,'Via Grazia 21','grazia PayPal','grazia@gmail.com','Pizzeria Da Grazia','grazia','23452123',NULL,'Locale accogliente ;)'),('Customer',11,'Via Martiri 2','federico PayPal','federico@gmail.com','federico','federico','12345678','1988-11-10',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-12-16 21:49:47
