CREATE DATABASE  IF NOT EXISTS `pharmafinder` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `pharmafinder`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: pharmafinder
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `address_id` int NOT NULL AUTO_INCREMENT,
  `state` varchar(45) NOT NULL,
  `zip_code` int NOT NULL,
  `city` varchar(45) NOT NULL,
  `street_address` varchar(255) NOT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'CA',95132,'San Jose','2514 Berryessa Rd'),(2,'CA',95119,'San Jose','276 Hospital Pkwy'),(3,'CA',95123,'San Jose','440 Blossom Hill Rd'),(4,'CA',95128,'San Jose','455 O\'Connor Dr Suite 190'),(5,'CA',94538,'Sunnyvale','2600 Mowry Ave'),(6,'CA',94089,'Santa Clara','1287 Hammerwood Ave Suite B'),(7,'CA',95054,'Fremont','3970 Rivermark Plaza'),(8,'CA',94538,'Fremont','4020 Fremont Hub'),(9,'CA',95035,'Milpitas','114 S Park Victoria Dr'),(10,'CA',95014,'Cupertino','1655 South De Anza Boulevard, Suite 2');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `avatar`
--

DROP TABLE IF EXISTS `avatar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avatar` (
  `avatar_id` int NOT NULL AUTO_INCREMENT,
  `directory_path` varchar(128) NOT NULL,
  PRIMARY KEY (`avatar_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avatar`
--

LOCK TABLES `avatar` WRITE;
/*!40000 ALTER TABLE `avatar` DISABLE KEYS */;
INSERT INTO `avatar` VALUES (1,'AvatarImages/cat.png'),(2,'AvatarImages/dragon.png'),(3,'AvatarImages/duck.png'),(4,'AvatarImages/hen.png'),(5,'AvatarImages/lion.png'),(6,'AvatarImages/owl.png'),(7,'AvatarImages/panda.png'),(8,'AvatarImages/rabbit.png'),(9,'AvatarImages/sea-lion.png'),(10,'AvatarImages/weasel.png');
/*!40000 ALTER TABLE `avatar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorized_as`
--

DROP TABLE IF EXISTS `categorized_as`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorized_as` (
  `med_id` int NOT NULL,
  `type_id` int NOT NULL,
  PRIMARY KEY (`med_id`,`type_id`),
  KEY `type_id_idx` (`type_id`),
  CONSTRAINT `medication_id` FOREIGN KEY (`med_id`) REFERENCES `medication` (`med_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `type_id` FOREIGN KEY (`type_id`) REFERENCES `type` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorized_as`
--

LOCK TABLES `categorized_as` WRITE;
/*!40000 ALTER TABLE `categorized_as` DISABLE KEYS */;
INSERT INTO `categorized_as` VALUES (5,1),(6,1),(8,1),(10,1),(1,2),(2,2),(3,2),(4,2),(8,3),(1,4),(1,5),(2,5),(3,5),(4,5),(7,6),(1,8),(3,8),(4,8),(9,10);
/*!40000 ALTER TABLE `categorized_as` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `user_id` int NOT NULL,
  `avatar_id` int NOT NULL,
  `email_address` varchar(128) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email_address_UNIQUE` (`email_address`),
  KEY `avatar_id_idx` (`avatar_id`),
  CONSTRAINT `avatar_id` FOREIGN KEY (`avatar_id`) REFERENCES `avatar` (`avatar_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (11,1,'joe.bob@gmail.com'),(12,3,'alex.javier18@gmail.com'),(13,2,'maria.cristo@hotmail.com'),(14,3,'lisa.adams01@yahoo.com'),(15,8,'tyler.do@proton.me'),(16,5,'sam.mason2@gmail.com'),(17,10,'wesley.smith@proton.me'),(18,9,'sara.brown@yahoo.com'),(19,6,'melissa.garcia21@gmail.com'),(20,4,'mark.davis@proton.me');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manufacturer`
--

DROP TABLE IF EXISTS `manufacturer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manufacturer` (
  `manf_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`manf_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manufacturer`
--

LOCK TABLES `manufacturer` WRITE;
/*!40000 ALTER TABLE `manufacturer` DISABLE KEYS */;
INSERT INTO `manufacturer` VALUES (1,'Pfizer'),(2,'Prestige Consumer Healthcare'),(3,'Roche'),(4,'Bayer'),(5,'Merck'),(6,'Johnson & Johnson'),(7,'Procter & Gamble'),(8,'AbbVie'),(9,'Novartis'),(10,'GSK plc');
/*!40000 ALTER TABLE `manufacturer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medication`
--

DROP TABLE IF EXISTS `medication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medication` (
  `med_id` int NOT NULL AUTO_INCREMENT,
  `manf_id` int NOT NULL,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`med_id`),
  KEY `manf_id_idx` (`manf_id`),
  CONSTRAINT `manf_id` FOREIGN KEY (`manf_id`) REFERENCES `manufacturer` (`manf_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medication`
--

LOCK TABLES `medication` WRITE;
/*!40000 ALTER TABLE `medication` DISABLE KEYS */;
INSERT INTO `medication` VALUES (1,4,'Aspirin'),(2,6,'Tylenol'),(3,1,'Advil'),(4,6,'Motrin'),(5,6,'Benadryl'),(6,4,'Claritin'),(7,10,'Tums'),(8,2,'Dramamine'),(9,4,'MiraLAX'),(10,7,'NyQuil');
/*!40000 ALTER TABLE `medication` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pharmacy`
--

DROP TABLE IF EXISTS `pharmacy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pharmacy` (
  `user_id` int NOT NULL,
  `address_id` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `tax_num` varchar(45) NOT NULL,
  `web_url` varchar(256) DEFAULT NULL,
  `operating_hours` varchar(128) NOT NULL,
  `average_rating` decimal(18,2) DEFAULT NULL,
  `phone_number` varchar(45) DEFAULT NULL,
  `fax_number` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `tax_id_UNIQUE` (`tax_num`),
  KEY `address_id_idx` (`address_id`),
  CONSTRAINT `address_id` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pharmacy_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pharmacy`
--

LOCK TABLES `pharmacy` WRITE;
/*!40000 ALTER TABLE `pharmacy` DISABLE KEYS */;
INSERT INTO `pharmacy` VALUES (1,1,'CVS Pharmacy','11-1111111','https://www.cvs.com/store-locator/san-jose-ca-pharmacies/2514-berryessa-rd-san-jose-ca-95132/storeid=9812','00:00-23:59,00:00-23:59,00:00-23:59,00:00-23:59,00:00-23:59,00:00-23:59,00:00-23:59',2.00,'(408) 272-1431','(408) 231-4291'),(2,2,'Kaiser Permanente Pharmacy','11-1111112','https://healthy.kaiserpermanente.org/northern-california/facilities/san-jose-medical-center-100322/departments/pharmacy-dlp-102744','08:30-19:30,08:30-19:30,08:30-19:30,08:30-19:30,08:30-19:30,09:00-18:00,09:00-18:00',NULL,'(408) 972-6911',NULL),(3,3,'Walgreens Pharmacy','11-1111113','https://www.walgreens.com/locator/walgreens-440+blossom+hill+rd-san+jose-ca-95123/id=2739','00:00-23:59,00:00-23:59,00:00-23:59,00:00-23:59,00:00-23:59,00:00-23:59,00:00-23:59',1.00,'(408) 229-8013','(408) 251-3989'),(4,4,'Savco Pharmacy','11-1111114','https://www.mygnp.com/pharmacies/savco-pharmacy-san-jose-ca-95128/','08:30-18:00,08:30-18:00,08:30-18:00,08:30-18:00,08:30-18:00,Closed,Closed',5.00,'(408) 298-6190',NULL),(5,5,'Walgreens Pharmacy','11-1111115','https://www.walgreens.com/locator/walgreens-2600+mowry+ave-fremont-ca-94538/id=4517','02:00-01:30,02:00-01:30,02:00-01:30,02:00-01:30,02:00-01:30,02:00-01:30,02:00-01:30',5.00,'(510) 742-9356',NULL),(6,6,'Q-Bit Wellness Pharmacy','11-1111116','https://qbitwellness.com/','10:00-17:00,10:00-17:00,10:00-17:00,10:00-17:00,10:00-17:00,Closed,Closed',4.00,'(650) 206-9343',NULL),(7,7,'Safeway Pharmacy','11-1111117','https://local.pharmacy.safeway.com/safeway/ca/santa-clara/3970-rivermark-plaza.html','09:00-20:00,09:00-20:00,09:00-20:00,09:00-20:00,09:00-20:00,09:00-17:00,09:00-17:00',5.00,'(408) 855-0985','(408) 837-0130'),(8,8,'CVS Pharmacy','11-1111118','https://www.cvs.com/store-locator/fremont-ca-pharmacies/4020-fremont-hub-fremont-ca-94538/storeid=9099','00:00-23:59,00:00-23:59,00:00-23:59,00:00-23:59,00:00-23:59,00:00-23:59,00:00-23:59',5.00,'(510) 791-9108',NULL),(9,9,'Calaveras Pharmacy','11-1111119','https://www.calaverasrx.com/','09:30-18:30,09:30-18:30,09:30-18:30,09:30-18:30,09:30-18:30,09:30-18:30,Closed',4.00,'(408) 262-2056','(408) 262-2055'),(10,10,'KML Pharmacy','11-1111120','https://www.mygnp.com/pharmacies/kml-pharmacy-cupertino-ca-95014/','09:30-18:00,09:30-18:00,09:30-18:00,09:30-18:00,09:30-18:00,09:30-14:00,Closed',3.00,'(408) 873-8123',NULL);
/*!40000 ALTER TABLE `pharmacy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `review_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `pharm_id` int NOT NULL,
  `content` varchar(512) NOT NULL,
  `rating` int NOT NULL,
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`review_id`),
  KEY `customer_id_idx` (`customer_id`),
  KEY `pharm_id_idx` (`pharm_id`),
  CONSTRAINT `customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pharm_id` FOREIGN KEY (`pharm_id`) REFERENCES `pharmacy` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,11,9,'My go-to pharmacy for over-the-counter medications.',4,'2025-07-12 04:44:44','2025-07-12 04:44:44'),(2,14,8,'The store was spotless and easy to navigate. I found the cold medicine I needed within minutes',5,'2025-07-12 05:24:05','2025-07-12 05:24:05'),(3,18,3,'Disappointing visit. The staff seemed uninterested when I asked for help.',1,'2025-07-12 05:25:17','2025-07-12 05:25:17'),(4,14,4,'They have a great selection of painkillers, and the cashier was super friendly.',5,'2025-07-12 05:27:35','2025-07-12 05:27:35'),(5,11,10,'Decent selection, but the store felt a bit disorganized this time around.',3,'2025-07-12 05:28:48','2025-07-12 05:28:48'),(6,20,6,'A bit overpriced, but the convenience and layout make up for it.',4,'2025-07-12 05:29:24','2025-07-12 05:29:24'),(7,15,7,'Quick in and out. Picked up cold medicine, and the cashier even suggested a better option.',5,'2025-07-12 05:30:04','2025-07-12 05:30:04'),(8,13,1,'I found the medication labels confusing and couldn\'t find someone to assist me.',2,'2025-07-12 05:31:12','2025-07-12 05:31:12'),(9,16,5,'Will be returning. Low prices, a well-organized store layout, and refreshing air conditioning.',5,'2025-07-12 05:33:03','2025-07-12 05:33:03'),(10,17,3,'One of the worst pharmacy visits I’ve had. Staff were rude, aisles were messy, barely any OTC products in stock, and the place felt like it hadn’t been cleaned in days.',1,'2025-07-12 05:35:03','2025-07-12 05:35:03');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sells`
--

DROP TABLE IF EXISTS `sells`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sells` (
  `user_id` int NOT NULL,
  `med_id` int NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(18,2) NOT NULL,
  PRIMARY KEY (`user_id`,`med_id`),
  KEY `product_id_idx` (`med_id`),
  CONSTRAINT `product_id` FOREIGN KEY (`med_id`) REFERENCES `medication` (`med_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `seller_id` FOREIGN KEY (`user_id`) REFERENCES `pharmacy` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sells`
--

LOCK TABLES `sells` WRITE;
/*!40000 ALTER TABLE `sells` DISABLE KEYS */;
INSERT INTO `sells` VALUES (1,3,19,12.50),(3,8,17,18.99),(4,7,24,12.95),(5,1,12,9.99),(5,2,31,16.99),(5,7,5,13.99),(6,2,29,15.95),(8,1,12,8.50),(8,9,6,22.50),(9,10,14,26.99);
/*!40000 ALTER TABLE `sells` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type`
--

DROP TABLE IF EXISTS `type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `type` (
  `type_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type`
--

LOCK TABLES `type` WRITE;
/*!40000 ALTER TABLE `type` DISABLE KEYS */;
INSERT INTO `type` VALUES (1,'Antihistamine'),(2,'Fever Reducer'),(3,'Antiemetic'),(4,'Blood Thinner'),(5,'Pain Reliever'),(6,'Antacid'),(7,'Antidepressant'),(8,'Anti-inflammatory'),(9,'Antibiotic'),(10,'Laxative');
/*!40000 ALTER TABLE `type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` char(64) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'cvs1','1b4f0e9851971998e732078544c96b36c3d01cedf7caa332359d6f1d83567014'),(2,'kaiser1','60303ae22b998861bce3b28f33eec1be758a213c86c93c076dbe9f558c11c752'),(3,'walgreens1','fd61a03af4f77d870fc21e05e7e80678095c92d808cfb3b5c279ee04c74aca13'),(4,'savco1','a4e624d686e03ed2767c0abd85c14426b0b1157d2ce81d27bb4fe4f6f01d688a'),(5,'walgreens2','a140c0c1eda2def2b830363ba362aa4d7d255c262960544821f556e16661b6ff'),(6,'qbit1','ed0cb90bdfa4f93981a7d03cff99213a86aa96a6cbcf89ec5e8889871f088727'),(7,'safeway1','bd7c911264aae15b66d4291b6850829aa96986b1d3ead34d1fdbfef27056c112'),(8,'cvs2','1f9bfeb15fee8a10c4d0711c7eb0c083962123e1918e461b6a508e7146c189b2'),(9,'calaveras1','b4451034d3b6590060ce9484a28b88dd332a80a22ae8e39c9c5cb7357ab26c9f'),(10,'kml1','ec2738feb2bbb0bc783eb4667903391416372ba6ed8b8dddbebbdb37e5102473'),(11,'joe_b1','744ea9ec6fa0a83e9764b4e323d5be6b55a5accfc7fe4c08eab6a8de1fca4855'),(12,'alexxj','a98ec5c5044800c88e862f007b98d89815fc40ca155d6ce7909530d792e909ce'),(13,'maria.c','166fb78f0f44d271a2d9065272a67ba373c3266b59d85847c02ef695af0cbf3f'),(14,'lisaa3','40cca5cc13abf91c7d5a72c0aea9bcbea4108946e67f24c0c23003cbf307efa2'),(15,'tyl_do','ebb39b342baead7aa52c0bcd6c0d4ba061b42f3a9dd6bafa2407a096b91b2450'),(16,'samm2','8ffd063b93a29f84389a635552740a9f0a7234169994158fb19692f5964dd7f5'),(17,'wesley.smith','813e41d4092656716cb0b46a1e5002857066cdaef8decf182ae15abf0b43b8d5'),(18,'s.brown1','b3c0e5febe1ec8875cd4a06fa4a99abf270de3f131d83a65f897322edbc12aec'),(19,'mel_garcia','840b1bf550a873a1dbed1381abe379cb9f1e76067b6de54bcd37367ce6ca3c0a'),(20,'mark.d','946cc198869790373cd8424cd9073e9e29aaa17b6f6a6ec55b38110cae856385');
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

-- Dump completed on 2025-07-22 23:51:17
