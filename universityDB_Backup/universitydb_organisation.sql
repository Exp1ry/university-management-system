CREATE DATABASE  IF NOT EXISTS `universitydb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `universitydb`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: universitydb
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `organisation`
--

DROP TABLE IF EXISTS `organisation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organisation` (
  `organisation_id` int NOT NULL AUTO_INCREMENT,
  `organisation_name` varchar(100) NOT NULL,
  `organisation_description` text NOT NULL,
  `organisation_status` enum('Active','Inactive','Suspended') NOT NULL DEFAULT 'Active',
  `organisation_membership_type` enum('Student','Lecturer','Staff','Mixed') NOT NULL DEFAULT 'Mixed',
  `organisation_type` enum('Committee','Club','Interest Group','Other') NOT NULL DEFAULT 'Other',
  `organisation_notes` text,
  `organisation_date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `organisation_date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`organisation_id`),
  UNIQUE KEY `organisation_name` (`organisation_name`),
  KEY `idx_organisation_status` (`organisation_status`),
  KEY `idx_organisation_type` (`organisation_type`,`organisation_membership_type`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organisation`
--

LOCK TABLES `organisation` WRITE;
/*!40000 ALTER TABLE `organisation` DISABLE KEYS */;
INSERT INTO `organisation` VALUES (1,'Student Union','Representative body for all university students','Active','Student','Committee','Democratic student representation','2025-05-24 14:18:51','2025-05-24 14:18:51'),(2,'Academic Standards Committee','Oversight of academic quality and standards','Active','Mixed','Committee','Quality assurance focus','2025-05-24 14:18:51','2025-05-24 14:18:51'),(3,'Computer Science Society','Student society for CS programme participants','Active','Student','Club','Programming competitions and workshops','2025-05-24 14:18:51','2025-05-24 14:18:51'),(4,'Mathematics Club','Mathematics enthusiasts and students','Active','Student','Club','Problem-solving sessions','2025-05-24 14:18:51','2025-05-24 14:18:51'),(5,'Environmental Action Group','Sustainability and environmental awareness','Active','Mixed','Interest Group','Campus sustainability initiatives','2025-05-24 14:18:51','2025-05-24 14:18:51'),(6,'Drama Society','Theatre and performance group','Active','Student','Club','Annual theatrical productions','2025-05-24 14:18:51','2025-05-24 14:18:51'),(7,'Research Ethics Committee','Ethical oversight of university research','Active','Mixed','Committee','Research ethics approval','2025-05-24 14:18:51','2025-05-24 14:18:51'),(8,'International Students Association','Support network for international students','Active','Student','Interest Group','Cultural exchange programmes','2025-05-24 14:18:51','2025-05-24 14:18:51'),(9,'Staff Social Club','Social activities for university staff','Active','Staff','Club','Staff welfare and social events','2025-05-24 14:18:51','2025-05-24 14:18:51'),(10,'Alumni Network','Connection between graduates and university','Active','Mixed','Interest Group','Career networking and mentorship','2025-05-24 14:18:51','2025-05-24 14:18:51');
/*!40000 ALTER TABLE `organisation` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-24 14:24:45
