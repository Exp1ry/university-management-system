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
-- Table structure for table `programme_course_requirement`
--

DROP TABLE IF EXISTS `programme_course_requirement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `programme_course_requirement` (
  `programme_course_requirement_id` int NOT NULL AUTO_INCREMENT,
  `programme_id` int NOT NULL,
  `course_id` int NOT NULL,
  `programme_course_requirement_type` enum('Core','Elective','Optional') NOT NULL DEFAULT 'Core',
  `programme_course_requirement_notes` text,
  `requirement_date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `requirement_date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`programme_course_requirement_id`),
  UNIQUE KEY `programme_id` (`programme_id`,`course_id`),
  KEY `course_id` (`course_id`),
  KEY `idx_programme_course_requirement_type` (`programme_course_requirement_type`),
  CONSTRAINT `programme_course_requirement_ibfk_1` FOREIGN KEY (`programme_id`) REFERENCES `programme` (`programme_id`) ON DELETE RESTRICT,
  CONSTRAINT `programme_course_requirement_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programme_course_requirement`
--

LOCK TABLES `programme_course_requirement` WRITE;
/*!40000 ALTER TABLE `programme_course_requirement` DISABLE KEYS */;
INSERT INTO `programme_course_requirement` VALUES (1,1,1,'Core','Essential foundation course for Computer Science programme','2025-05-24 14:18:51','2025-05-24 14:18:51'),(2,2,2,'Core','Fundamental mathematics requirement','2025-05-24 14:18:51','2025-05-24 14:18:51'),(3,3,3,'Core','Basic physics principles course','2025-05-24 14:18:51','2025-05-24 14:18:51'),(4,4,4,'Core','General chemistry foundation','2025-05-24 14:18:51','2025-05-24 14:18:51'),(5,5,5,'Core','Cell biology fundamentals','2025-05-24 14:18:51','2025-05-24 14:18:51'),(6,6,6,'Core','Literature programme foundation','2025-05-24 14:18:51','2025-05-24 14:18:51'),(7,7,7,'Core','Historical methods introduction','2025-05-24 14:18:51','2025-05-24 14:18:51'),(8,8,8,'Core','Economic principles foundation','2025-05-24 14:18:51','2025-05-24 14:18:51'),(9,9,9,'Core','Philosophy programme introduction','2025-05-24 14:18:51','2025-05-24 14:18:51'),(10,10,10,'Core','Psychology programme foundation','2025-05-24 14:18:51','2025-05-24 14:18:51');
/*!40000 ALTER TABLE `programme_course_requirement` ENABLE KEYS */;
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
