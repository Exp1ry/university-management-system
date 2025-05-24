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
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `student_id` int NOT NULL AUTO_INCREMENT,
  `programme_id` int NOT NULL,
  `student_first_name` varchar(50) NOT NULL,
  `student_last_name` varchar(50) NOT NULL,
  `student_dob` date NOT NULL,
  `student_email` varchar(255) NOT NULL,
  `student_password_hash` varchar(255) NOT NULL,
  `student_contact_phone` varchar(20) DEFAULT NULL,
  `student_address` text,
  `student_study_year` int NOT NULL,
  `student_disciplinary_records` text,
  `student_status` enum('Active','Suspended','Graduated','Withdrawn','Exchange Completed') NOT NULL DEFAULT 'Active',
  `student_notes` text,
  `student_date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `student_date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`student_id`),
  UNIQUE KEY `student_email` (`student_email`),
  KEY `idx_student_study_year` (`student_study_year`),
  KEY `idx_student_status` (`student_status`),
  KEY `idx_student_programme_year` (`programme_id`,`student_study_year`,`student_status`),
  KEY `idx_student_date_created` (`student_date_created`),
  KEY `idx_student_name_composite` (`student_last_name`,`student_first_name`),
  KEY `idx_student_last_name` (`student_last_name`),
  KEY `idx_student_first_name` (`student_first_name`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`programme_id`) REFERENCES `programme` (`programme_id`) ON DELETE RESTRICT,
  CONSTRAINT `student_chk_1` CHECK ((`student_study_year` between 1 and 10))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (1,1,'Oliver','Smith','2002-03-15','o.smith@university.ac.uk','student_hash_1','+44 7123456789','123 University Road, Manchester M13 9PL',2,NULL,'Active','Excellent programming skills','2025-05-24 14:18:51','2025-05-24 14:18:51'),(2,2,'Emily','Johnson','2001-07-22','e.johnson@university.ac.uk','student_hash_2','+44 7234567890','456 College Street, Birmingham B15 2TT',3,NULL,'Active','Mathematics society president','2025-05-24 14:18:51','2025-05-24 14:18:51'),(3,3,'Harry','Williams','2003-01-08','h.williams@university.ac.uk','student_hash_3','+44 7345678901','789 Campus Lane, Leeds LS2 9JT',1,NULL,'Active','Physics laboratory assistant','2025-05-24 14:18:51','2025-05-24 14:18:51'),(4,4,'Sophie','Brown','2002-11-30','s.brown@university.ac.uk','student_hash_4','+44 7456789012','321 Student Gardens, Newcastle NE1 7RU',2,NULL,'Active','Chemistry research volunteer','2025-05-24 14:18:51','2025-05-24 14:18:51'),(5,5,'George','Jones','2001-09-14','g.jones@university.ac.uk','student_hash_5','+44 7567890123','654 Academic Close, Liverpool L69 3BX',3,NULL,'Active','Marine biology field trip leader','2025-05-24 14:18:51','2025-05-24 14:18:51'),(6,6,'Charlotte','Miller','2002-05-03','c.miller@university.ac.uk','student_hash_6','+44 7678901234','987 Literature Avenue, Edinburgh EH8 9YL',2,NULL,'Active','Creative writing award winner','2025-05-24 14:18:51','2025-05-24 14:18:51'),(7,7,'William','Davis','2003-04-18','w.davis@university.ac.uk','student_hash_7','+44 7789012345','147 History House, Oxford OX1 2JD',1,NULL,'Active','Historical society member','2025-05-24 14:18:51','2025-05-24 14:18:51'),(8,8,'Grace','Wilson','2001-12-07','g.wilson@university.ac.uk','student_hash_8','+44 7890123456','258 Economics Court, Cambridge CB2 1TN',3,NULL,'Active','Economics journal contributor','2025-05-24 14:18:51','2025-05-24 14:18:51'),(9,9,'Jack','Moore','2002-08-25','j.moore@university.ac.uk','student_hash_9','+44 7901234567','369 Philosophy Plaza, York YO10 5DD',2,NULL,'Active','Debate society champion','2025-05-24 14:18:51','2025-05-24 14:18:51'),(10,10,'Amelia','Taylor','2003-02-11','a.taylor@university.ac.uk','student_hash_10','+44 7012345678','741 Psychology Park, Bath BA2 7AY',1,NULL,'Active','Research methods tutor','2025-05-24 14:18:51','2025-05-24 14:18:51');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
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
