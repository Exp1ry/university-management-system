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
-- Table structure for table `student_organisation`
--

DROP TABLE IF EXISTS `student_organisation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_organisation` (
  `student_organisation_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `organisation_id` int NOT NULL,
  `student_organisation_role` varchar(50) DEFAULT 'Member',
  `student_organisation_join_date` date NOT NULL,
  `student_organisation_status` enum('Active','Inactive','Suspended') NOT NULL DEFAULT 'Active',
  `student_organisation_notes` text,
  `student_organisation_date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `student_organisation_date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`student_organisation_id`),
  UNIQUE KEY `student_id` (`student_id`,`organisation_id`),
  KEY `organisation_id` (`organisation_id`),
  KEY `idx_student_org_status` (`student_organisation_status`),
  KEY `idx_student_org_join_date` (`student_organisation_join_date`),
  CONSTRAINT `student_organisation_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE RESTRICT,
  CONSTRAINT `student_organisation_ibfk_2` FOREIGN KEY (`organisation_id`) REFERENCES `organisation` (`organisation_id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_organisation`
--

LOCK TABLES `student_organisation` WRITE;
/*!40000 ALTER TABLE `student_organisation` DISABLE KEYS */;
INSERT INTO `student_organisation` VALUES (1,1,3,'President','2023-09-01','Active','Leading programming workshops','2025-05-24 14:18:51','2025-05-24 14:18:51'),(2,2,4,'Secretary','2022-09-01','Active','Organising mathematics competitions','2025-05-24 14:18:51','2025-05-24 14:18:51'),(3,3,5,'Member','2024-01-15','Active','Environmental awareness campaigns','2025-05-24 14:18:51','2025-05-24 14:18:51'),(4,4,6,'Vice President','2023-09-01','Active','Theatre production coordinator','2025-05-24 14:18:51','2025-05-24 14:18:51'),(5,5,8,'Treasurer','2022-09-01','Active','International student support','2025-05-24 14:18:51','2025-05-24 14:18:51'),(6,6,6,'Member','2023-09-01','Active','Creative writing workshops','2025-05-24 14:18:51','2025-05-24 14:18:51'),(7,7,1,'Representative','2024-01-15','Active','Student union representative','2025-05-24 14:18:51','2025-05-24 14:18:51'),(8,8,10,'Member','2022-09-01','Active','Alumni networking events','2025-05-24 14:18:51','2025-05-24 14:18:51'),(9,9,5,'Committee Member','2023-09-01','Active','Sustainability projects','2025-05-24 14:18:51','2025-05-24 14:18:51'),(10,10,8,'Member','2024-01-15','Active','Cultural exchange programmes','2025-05-24 14:18:51','2025-05-24 14:18:51');
/*!40000 ALTER TABLE `student_organisation` ENABLE KEYS */;
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
