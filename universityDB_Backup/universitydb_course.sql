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
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `course_id` int NOT NULL AUTO_INCREMENT,
  `department_id` int NOT NULL,
  `course_code` varchar(10) NOT NULL,
  `course_name` varchar(100) NOT NULL,
  `course_description` text NOT NULL,
  `course_level` enum('Preparatory','Undergraduate','Graduate','Doctoral','Continuing Education','Other') NOT NULL DEFAULT 'Other',
  `course_credits` decimal(3,1) NOT NULL DEFAULT '0.5',
  `course_materials` text,
  `course_notes` text,
  `course_date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `course_date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`course_id`),
  UNIQUE KEY `course_code` (`course_code`),
  UNIQUE KEY `course_name` (`course_name`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`) ON DELETE RESTRICT,
  CONSTRAINT `course_chk_1` CHECK ((`course_credits` between 0.5 and 2.0))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (1,1,'CS101','Introduction to Programming','Fundamental programming concepts using Python and Java','Undergraduate',1.0,'Programming textbooks, online resources, development tools','Prerequisite for advanced CS courses','2025-05-24 14:18:51','2025-05-24 14:18:51'),(2,2,'MATH101','Calculus I','Differential and integral calculus fundamentals','Undergraduate',1.0,'Calculus textbook, graphing calculator','Foundation course for mathematics programme','2025-05-24 14:18:51','2025-05-24 14:18:51'),(3,3,'PHYS101','Classical Mechanics','Newtonian mechanics and motion principles','Undergraduate',1.0,'Physics textbook, laboratory manual','Includes practical laboratory sessions','2025-05-24 14:18:51','2025-05-24 14:18:51'),(4,4,'CHEM101','General Chemistry','Atomic structure, chemical bonding, and reactions','Undergraduate',1.0,'Chemistry textbook, safety equipment','Laboratory work required','2025-05-24 14:18:51','2025-05-24 14:18:51'),(5,5,'BIO101','Cell Biology','Structure and function of cellular components','Undergraduate',1.0,'Biology textbook, microscopy equipment','Microscopy skills development','2025-05-24 14:18:51','2025-05-24 14:18:51'),(6,6,'ENG101','Introduction to Literature','Survey of major literary works and genres','Undergraduate',1.0,'Literary anthology, critical essays','Essay writing skills emphasis','2025-05-24 14:18:51','2025-05-24 14:18:51'),(7,7,'HIST101','British History','Overview of British historical development','Undergraduate',1.0,'History textbooks, primary sources','Document analysis skills','2025-05-24 14:18:51','2025-05-24 14:18:51'),(8,8,'ECON101','Principles of Economics','Basic economic theory and market principles','Undergraduate',1.0,'Economics textbook, case studies','Mathematical applications included','2025-05-24 14:18:51','2025-05-24 14:18:51'),(9,9,'PHIL101','Introduction to Philosophy','Major philosophical questions and methods','Undergraduate',1.0,'Philosophy reader, classical texts','Critical thinking development','2025-05-24 14:18:51','2025-05-24 14:18:51'),(10,10,'PSYC101','Introduction to Psychology','Overview of psychological theories and research','Undergraduate',1.0,'Psychology textbook, research articles','Statistical methods introduction','2025-05-24 14:18:51','2025-05-24 14:18:51');
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
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
