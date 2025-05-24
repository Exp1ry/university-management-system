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
-- Table structure for table `lecturer`
--

DROP TABLE IF EXISTS `lecturer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lecturer` (
  `lecturer_id` int NOT NULL AUTO_INCREMENT,
  `department_id` int NOT NULL,
  `lecturer_first_name` varchar(50) NOT NULL,
  `lecturer_last_name` varchar(50) NOT NULL,
  `lecturer_email` varchar(255) NOT NULL,
  `lecturer_password_hash` varchar(255) NOT NULL,
  `lecturer_academic_qualifications` text NOT NULL,
  `lecturer_expertise` text NOT NULL,
  `lecturer_course_load` int DEFAULT NULL,
  `lecturer_research_interests` text,
  `lecturer_publications` text,
  `lecturer_status` enum('Active','On Leave','Suspended','Inactive') NOT NULL DEFAULT 'Active',
  `lecturer_notes` text,
  `lecturer_date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lecturer_date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`lecturer_id`),
  UNIQUE KEY `lecturer_email` (`lecturer_email`),
  KEY `department_id` (`department_id`),
  KEY `idx_lecturer_status` (`lecturer_status`),
  KEY `idx_lecturer_expertise` (`lecturer_expertise`(100)),
  KEY `idx_lecturer_research_interests` (`lecturer_research_interests`(100)),
  KEY `idx_lecturer_course_load` (`lecturer_course_load`),
  KEY `idx_lecturer_name_composite` (`lecturer_last_name`,`lecturer_first_name`),
  KEY `idx_lecturer_last_name` (`lecturer_last_name`),
  KEY `idx_lecturer_first_name` (`lecturer_first_name`),
  FULLTEXT KEY `ft_lecturer_expertise` (`lecturer_expertise`,`lecturer_research_interests`),
  CONSTRAINT `lecturer_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`) ON DELETE RESTRICT,
  CONSTRAINT `lecturer_chk_1` CHECK ((`lecturer_course_load` between 0 and 10))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lecturer`
--

LOCK TABLES `lecturer` WRITE;
/*!40000 ALTER TABLE `lecturer` DISABLE KEYS */;
INSERT INTO `lecturer` VALUES (1,1,'James','Thompson','j.thompson@university.ac.uk','hashed_password_1','PhD Computer Science, University of Cambridge','Artificial Intelligence, Machine Learning',3,'Neural networks, deep learning algorithms','15 peer-reviewed publications in AI journals','Active','Leading AI research group','2025-05-24 14:18:51','2025-05-24 14:18:51'),(2,2,'Sarah','Williams','s.williams@university.ac.uk','hashed_password_2','PhD Mathematics, University of Oxford','Pure Mathematics, Number Theory',4,'Prime number theory, cryptographic applications','20 publications in mathematical journals','Active','Royal Society fellowship recipient','2025-05-24 14:18:51','2025-05-24 14:18:51'),(3,3,'Michael','Brown','m.brown@university.ac.uk','hashed_password_3','PhD Physics, Imperial College London','Quantum Physics, Condensed Matter',2,'Quantum computing, superconductivity','18 publications in physics journals','Active','Quantum research laboratory director','2025-05-24 14:18:51','2025-05-24 14:18:51'),(4,4,'Emma','Davis','e.davis@university.ac.uk','hashed_password_4','PhD Chemistry, University of Edinburgh','Organic Chemistry, Drug Discovery',3,'Pharmaceutical compounds, synthetic methods','12 publications in chemistry journals','Active','Industry collaboration specialist','2025-05-24 14:18:51','2025-05-24 14:18:51'),(5,5,'Robert','Wilson','r.wilson@university.ac.uk','hashed_password_5','PhD Biology, University of Bristol','Marine Biology, Ecology',4,'Marine ecosystems, climate change impacts','22 publications in ecology journals','Active','Field research coordinator','2025-05-24 14:18:51','2025-05-24 14:18:51'),(6,6,'Catherine','Taylor','c.taylor@university.ac.uk','hashed_password_6','PhD English Literature, University of York','Victorian Literature, Gender Studies',5,'Victorian women writers, feminist literary theory','14 publications in literary journals','Active','Victorian studies expert','2025-05-24 14:18:51','2025-05-24 14:18:51'),(7,7,'David','Anderson','d.anderson@university.ac.uk','hashed_password_7','PhD History, University of Durham','Medieval History, British History',3,'Medieval manuscripts, social history','16 publications in historical journals','Active','Medieval studies specialist','2025-05-24 14:18:51','2025-05-24 14:18:51'),(8,8,'Rachel','Thomas','r.thomas@university.ac.uk','hashed_password_8','PhD Economics, London School of Economics','Macroeconomics, Economic Policy',2,'Monetary policy, economic forecasting','11 publications in economics journals','Active','Government advisory committee member','2025-05-24 14:18:51','2025-05-24 14:18:51'),(9,9,'Peter','Jackson','p.jackson@university.ac.uk','hashed_password_9','PhD Philosophy, University of St Andrews','Ethics, Political Philosophy',4,'Applied ethics, moral philosophy','13 publications in philosophy journals','Active','Ethics committee chair','2025-05-24 14:18:51','2025-05-24 14:18:51'),(10,10,'Helen','White','h.white@university.ac.uk','hashed_password_10','PhD Psychology, University of Glasgow','Cognitive Psychology, Neuroscience',3,'Memory processes, brain imaging','19 publications in psychology journals','Active','Cognitive neuroscience laboratory head','2025-05-24 14:18:51','2025-05-24 14:18:51');
/*!40000 ALTER TABLE `lecturer` ENABLE KEYS */;
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
