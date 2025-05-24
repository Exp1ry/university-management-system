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
-- Table structure for table `programme`
--

DROP TABLE IF EXISTS `programme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `programme` (
  `programme_id` int NOT NULL AUTO_INCREMENT,
  `department_id` int NOT NULL,
  `programme_name` varchar(100) NOT NULL,
  `programme_degree_awarded` varchar(50) NOT NULL,
  `programme_duration` int NOT NULL,
  `programme_notes` text,
  `programme_date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `programme_date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`programme_id`),
  UNIQUE KEY `programme_name` (`programme_name`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `programme_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`) ON DELETE RESTRICT,
  CONSTRAINT `programme_chk_1` CHECK ((`programme_duration` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programme`
--

LOCK TABLES `programme` WRITE;
/*!40000 ALTER TABLE `programme` DISABLE KEYS */;
INSERT INTO `programme` VALUES (1,1,'Computer Science','BSc',3,'Comprehensive programme covering software development and theoretical computer science','2025-05-24 14:18:51','2025-05-24 14:18:51'),(2,2,'Mathematics','BSc',3,'Rigorous mathematical training with practical applications','2025-05-24 14:18:51','2025-05-24 14:18:51'),(3,3,'Physics','BSc',3,'Fundamental physics principles with laboratory experience','2025-05-24 14:18:51','2025-05-24 14:18:51'),(4,4,'Chemistry','BSc',3,'Chemical sciences with extensive practical work','2025-05-24 14:18:51','2025-05-24 14:18:51'),(5,5,'Biology','BSc',3,'Life sciences programme with field work opportunities','2025-05-24 14:18:51','2025-05-24 14:18:51'),(6,6,'English Literature','BA',3,'Literary studies with critical analysis focus','2025-05-24 14:18:51','2025-05-24 14:18:51'),(7,7,'History','BA',3,'Historical research and analysis programme','2025-05-24 14:18:51','2025-05-24 14:18:51'),(8,8,'Economics','BSc',3,'Economic theory and quantitative methods','2025-05-24 14:18:51','2025-05-24 14:18:51'),(9,9,'Philosophy','BA',3,'Philosophical inquiry and logical reasoning','2025-05-24 14:18:51','2025-05-24 14:18:51'),(10,10,'Psychology','BSc',3,'Scientific study of human behaviour and cognition','2025-05-24 14:18:51','2025-05-24 14:18:51');
/*!40000 ALTER TABLE `programme` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-24 14:24:47
