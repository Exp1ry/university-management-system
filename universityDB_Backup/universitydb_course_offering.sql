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
-- Table structure for table `course_offering`
--

DROP TABLE IF EXISTS `course_offering`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_offering` (
  `course_offering_id` int NOT NULL AUTO_INCREMENT,
  `course_id` int NOT NULL,
  `course_offering_semester` enum('Fall','Winter','Spring','Summer','Special Term') NOT NULL,
  `course_offering_year` year NOT NULL,
  `course_offering_start_date` date NOT NULL,
  `course_offering_end_date` date NOT NULL,
  `course_offering_notes` text,
  `course_offering_section` int NOT NULL DEFAULT '1',
  `course_offering_status` enum('Open','Closed','Waitlist') NOT NULL DEFAULT 'Open',
  `course_offering_date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `course_offering_date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`course_offering_id`),
  UNIQUE KEY `course_id` (`course_id`,`course_offering_semester`,`course_offering_year`,`course_offering_section`),
  KEY `idx_course_offering_semester_year` (`course_offering_semester`,`course_offering_year`),
  KEY `idx_course_offering_status` (`course_offering_status`),
  KEY `idx_course_offering_dates` (`course_offering_start_date`,`course_offering_end_date`),
  KEY `idx_course_offering_lookup` (`course_id`,`course_offering_semester`,`course_offering_year`,`course_offering_status`),
  CONSTRAINT `course_offering_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE RESTRICT,
  CONSTRAINT `course_offering_chk_1` CHECK ((`course_offering_year` between 1881 and 2100)),
  CONSTRAINT `course_offering_chk_2` CHECK ((`course_offering_start_date` <= `course_offering_end_date`)),
  CONSTRAINT `course_offering_chk_3` CHECK ((year(`course_offering_start_date`) = `course_offering_year`)),
  CONSTRAINT `course_offering_chk_4` CHECK ((`course_offering_section` >= 1))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_offering`
--

LOCK TABLES `course_offering` WRITE;
/*!40000 ALTER TABLE `course_offering` DISABLE KEYS */;
INSERT INTO `course_offering` VALUES (1,1,'Fall',2024,'2024-09-15','2024-12-15','Introduction to Programming - Autumn term',1,'Open','2025-05-24 14:18:51','2025-05-24 14:18:51'),(2,2,'Fall',2024,'2024-09-15','2024-12-15','Calculus I - Autumn term',1,'Open','2025-05-24 14:18:51','2025-05-24 14:18:51'),(3,3,'Fall',2024,'2024-09-15','2024-12-15','Classical Mechanics - Autumn term',1,'Open','2025-05-24 14:18:51','2025-05-24 14:18:51'),(4,4,'Fall',2024,'2024-09-15','2024-12-15','General Chemistry - Autumn term',1,'Open','2025-05-24 14:18:51','2025-05-24 14:18:51'),(5,5,'Fall',2024,'2024-09-15','2024-12-15','Cell Biology - Autumn term',1,'Open','2025-05-24 14:18:51','2025-05-24 14:18:51'),(6,6,'Fall',2024,'2024-09-15','2024-12-15','Introduction to Literature - Autumn term',1,'Open','2025-05-24 14:18:51','2025-05-24 14:18:51'),(7,7,'Fall',2024,'2024-09-15','2024-12-15','British History - Autumn term',1,'Open','2025-05-24 14:18:51','2025-05-24 14:18:51'),(8,8,'Fall',2024,'2024-09-15','2024-12-15','Principles of Economics - Autumn term',1,'Open','2025-05-24 14:18:51','2025-05-24 14:18:51'),(9,9,'Fall',2024,'2024-09-15','2024-12-15','Introduction to Philosophy - Autumn term',1,'Open','2025-05-24 14:18:51','2025-05-24 14:18:51'),(10,10,'Fall',2024,'2024-09-15','2024-12-15','Introduction to Psychology - Autumn term',1,'Open','2025-05-24 14:18:51','2025-05-24 14:18:51');
/*!40000 ALTER TABLE `course_offering` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-24 14:24:48
