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
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `staff_id` int NOT NULL AUTO_INCREMENT,
  `department_id` int NOT NULL,
  `staff_first_name` varchar(50) NOT NULL,
  `staff_last_name` varchar(50) NOT NULL,
  `staff_email` varchar(255) NOT NULL,
  `staff_password_hash` varchar(255) NOT NULL,
  `staff_title` varchar(100) NOT NULL,
  `staff_type` enum('Full-time','Part-time','Contract','Temporary') NOT NULL,
  `staff_contract_details` text,
  `staff_salary` decimal(10,2) DEFAULT NULL,
  `staff_emergency_contact_name` varchar(100) DEFAULT NULL,
  `staff_emergency_contact_phone` varchar(50) DEFAULT NULL,
  `staff_emergency_contact_email` varchar(255) DEFAULT NULL,
  `staff_status` enum('Active','On Leave','Suspended','Inactive') NOT NULL DEFAULT 'Active',
  `staff_notes` text,
  `staff_date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `staff_date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `staff_email` (`staff_email`),
  KEY `department_id` (`department_id`),
  KEY `idx_staff_status` (`staff_status`),
  KEY `idx_staff_type` (`staff_type`),
  KEY `idx_staff_name_composite` (`staff_last_name`,`staff_first_name`),
  KEY `idx_staff_last_name` (`staff_last_name`),
  KEY `idx_staff_first_name` (`staff_first_name`),
  CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,1,'Mark','Roberts','m.roberts@university.ac.uk','staff_hash_1','IT Support Specialist','Full-time','Permanent contract, 37.5 hours per week',28000.00,'Linda Roberts','+44 7111222333','l.roberts@email.com','Active','Network administration specialist','2025-05-24 14:18:51','2025-05-24 14:18:51'),(2,2,'Lisa','Evans','l.evans@university.ac.uk','staff_hash_2','Administrative Assistant','Full-time','Permanent contract, 37.5 hours per week',24000.00,'John Evans','+44 7222333444','j.evans@email.com','Active','Student services coordinator','2025-05-24 14:18:51','2025-05-24 14:18:51'),(3,3,'Andrew','Clarke','a.clarke@university.ac.uk','staff_hash_3','Laboratory Technician','Full-time','Permanent contract, 37.5 hours per week',26000.00,'Mary Clarke','+44 7333444555','m.clarke@email.com','Active','Physics laboratory specialist','2025-05-24 14:18:51','2025-05-24 14:18:51'),(4,4,'Jennifer','Lewis','j.lewis@university.ac.uk','staff_hash_4','Research Administrator','Full-time','Permanent contract, 37.5 hours per week',30000.00,'Paul Lewis','+44 7444555666','p.lewis@email.com','Active','Grant application coordinator','2025-05-24 14:18:51','2025-05-24 14:18:51'),(5,5,'Simon','Walker','s.walker@university.ac.uk','staff_hash_5','Field Station Manager','Full-time','Permanent contract, 37.5 hours per week',32000.00,'Susan Walker','+44 7555666777','s.walker@email.com','Active','Marine station operations','2025-05-24 14:18:51','2025-05-24 14:18:51'),(6,6,'Karen','Hall','k.hall@university.ac.uk','staff_hash_6','Library Assistant','Part-time','Permanent contract, 20 hours per week',16000.00,'David Hall','+44 7666777888','d.hall@email.com','Active','Special collections specialist','2025-05-24 14:18:51','2025-05-24 14:18:51'),(7,7,'Richard','Young','r.young@university.ac.uk','staff_hash_7','Archive Curator','Full-time','Permanent contract, 37.5 hours per week',29000.00,'Helen Young','+44 7777888999','h.young@email.com','Active','Historical documents expert','2025-05-24 14:18:51','2025-05-24 14:18:51'),(8,8,'Michelle','King','m.king@university.ac.uk','staff_hash_8','Finance Officer','Full-time','Permanent contract, 37.5 hours per week',31000.00,'Robert King','+44 7888999000','r.king@email.com','Active','Budget management specialist','2025-05-24 14:18:51','2025-05-24 14:18:51'),(9,9,'Christopher','Wright','c.wright@university.ac.uk','staff_hash_9','Events Coordinator','Full-time','Permanent contract, 37.5 hours per week',27000.00,'Sarah Wright','+44 7999000111','s.wright@email.com','Active','Academic conference organiser','2025-05-24 14:18:51','2025-05-24 14:18:51'),(10,10,'Amanda','Green','a.green@university.ac.uk','staff_hash_10','Student Counsellor','Full-time','Permanent contract, 37.5 hours per week',33000.00,'James Green','+44 7000111222','j.green@email.com','Active','Mental health support specialist','2025-05-24 14:18:51','2025-05-24 14:18:51');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
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
