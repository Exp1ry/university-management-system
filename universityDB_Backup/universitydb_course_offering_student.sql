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
-- Table structure for table `course_offering_student`
--

DROP TABLE IF EXISTS `course_offering_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_offering_student` (
  `course_offering_student_id` int NOT NULL AUTO_INCREMENT,
  `course_offering_id` int NOT NULL,
  `student_id` int NOT NULL,
  `course_offering_student_result` enum('Enroled','Passed','Failed','Withdrawn','Dropped') NOT NULL DEFAULT 'Enroled',
  `course_offering_student_grade` int DEFAULT NULL,
  `course_offering_student_date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `course_offering_student_date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`course_offering_student_id`),
  UNIQUE KEY `course_offering_id` (`course_offering_id`,`student_id`),
  KEY `student_id` (`student_id`),
  KEY `idx_student_result_grade` (`course_offering_student_result`,`course_offering_student_grade`),
  KEY `idx_student_grade_performance` (`course_offering_student_grade`),
  CONSTRAINT `course_offering_student_ibfk_1` FOREIGN KEY (`course_offering_id`) REFERENCES `course_offering` (`course_offering_id`) ON DELETE RESTRICT,
  CONSTRAINT `course_offering_student_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE RESTRICT,
  CONSTRAINT `course_offering_student_chk_1` CHECK (((`course_offering_student_grade` >= 0) and (`course_offering_student_grade` <= 100))),
  CONSTRAINT `course_offering_student_chk_2` CHECK ((((`course_offering_student_result` = _utf8mb4'Passed') and (`course_offering_student_grade` >= 51)) or ((`course_offering_student_result` = _utf8mb4'Failed') and (`course_offering_student_grade` <= 50)) or ((`course_offering_student_result` in (_utf8mb4'Enroled',_utf8mb4'Withdrawn',_utf8mb4'Dropped')) and (`course_offering_student_grade` is null))))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_offering_student`
--

LOCK TABLES `course_offering_student` WRITE;
/*!40000 ALTER TABLE `course_offering_student` DISABLE KEYS */;
INSERT INTO `course_offering_student` VALUES (1,1,1,'Passed',78,'2025-05-24 14:18:51','2025-05-24 14:18:51'),(2,2,2,'Passed',85,'2025-05-24 14:18:51','2025-05-24 14:18:51'),(3,3,3,'Enroled',NULL,'2025-05-24 14:18:51','2025-05-24 14:18:51'),(4,4,4,'Passed',72,'2025-05-24 14:18:51','2025-05-24 14:18:51'),(5,5,5,'Passed',88,'2025-05-24 14:18:51','2025-05-24 14:18:51'),(6,6,6,'Passed',91,'2025-05-24 14:18:51','2025-05-24 14:18:51'),(7,7,7,'Enroled',NULL,'2025-05-24 14:18:51','2025-05-24 14:18:51'),(8,8,8,'Passed',76,'2025-05-24 14:18:51','2025-05-24 14:18:51'),(9,9,9,'Passed',83,'2025-05-24 14:18:51','2025-05-24 14:18:51'),(10,10,10,'Enroled',NULL,'2025-05-24 14:18:51','2025-05-24 14:18:51');
/*!40000 ALTER TABLE `course_offering_student` ENABLE KEYS */;
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
