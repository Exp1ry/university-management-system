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
-- Table structure for table `lecturer_organisation`
--

DROP TABLE IF EXISTS `lecturer_organisation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lecturer_organisation` (
  `lecturer_organisation_id` int NOT NULL AUTO_INCREMENT,
  `lecturer_id` int NOT NULL,
  `organisation_id` int NOT NULL,
  `lecturer_organisation_role` varchar(50) DEFAULT 'Member',
  `lecturer_organisation_join_date` date NOT NULL,
  `lecturer_organisation_status` enum('Active','Inactive','Suspended') NOT NULL DEFAULT 'Active',
  `lecturer_organisation_notes` text,
  `lecturer_organisation_date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lecturer_organisation_date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`lecturer_organisation_id`),
  UNIQUE KEY `lecturer_id` (`lecturer_id`,`organisation_id`),
  KEY `organisation_id` (`organisation_id`),
  KEY `idx_lecturer_org_status` (`lecturer_organisation_status`),
  KEY `idx_lecturer_org_join_date` (`lecturer_organisation_join_date`),
  CONSTRAINT `lecturer_organisation_ibfk_1` FOREIGN KEY (`lecturer_id`) REFERENCES `lecturer` (`lecturer_id`) ON DELETE RESTRICT,
  CONSTRAINT `lecturer_organisation_ibfk_2` FOREIGN KEY (`organisation_id`) REFERENCES `organisation` (`organisation_id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lecturer_organisation`
--

LOCK TABLES `lecturer_organisation` WRITE;
/*!40000 ALTER TABLE `lecturer_organisation` DISABLE KEYS */;
INSERT INTO `lecturer_organisation` VALUES (1,1,2,'Chair','2020-09-01','Active','Academic standards oversight','2025-05-24 14:18:51','2025-05-24 14:18:51'),(2,2,7,'Member','2019-09-01','Active','Research ethics review','2025-05-24 14:18:51','2025-05-24 14:18:51'),(3,3,2,'Member','2021-09-01','Active','Quality assurance committee','2025-05-24 14:18:51','2025-05-24 14:18:51'),(4,4,7,'Vice Chair','2020-09-01','Active','Ethics committee leadership','2025-05-24 14:18:51','2025-05-24 14:18:51'),(5,5,5,'Advisor','2018-09-01','Active','Environmental policy guidance','2025-05-24 14:18:51','2025-05-24 14:18:51'),(6,6,10,'Member','2019-09-01','Active','Alumni engagement activities','2025-05-24 14:18:51','2025-05-24 14:18:51'),(7,7,2,'Member','2020-09-01','Active','Academic policy development','2025-05-24 14:18:51','2025-05-24 14:18:51'),(8,8,7,'Member','2021-09-01','Active','Research ethics evaluation','2025-05-24 14:18:51','2025-05-24 14:18:51'),(9,9,2,'Member','2019-09-01','Active','Academic standards review','2025-05-24 14:18:51','2025-05-24 14:18:51'),(10,10,7,'Member','2020-09-01','Active','Psychology research ethics','2025-05-24 14:18:51','2025-05-24 14:18:51');
/*!40000 ALTER TABLE `lecturer_organisation` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-24 14:24:46
