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
-- Table structure for table `research_project`
--

DROP TABLE IF EXISTS `research_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `research_project` (
  `research_project_id` int NOT NULL AUTO_INCREMENT,
  `research_group_id` int NOT NULL,
  `department_id` int NOT NULL,
  `research_project_title` varchar(255) NOT NULL,
  `research_project_funding` text,
  `research_project_publications` text,
  `research_project_outcomes` text,
  `research_project_status` enum('Active','Completed','Discontinued','Planned') NOT NULL DEFAULT 'Active',
  `research_project_notes` text,
  `research_project_date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `research_project_date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`research_project_id`),
  UNIQUE KEY `research_project_title` (`research_project_title`),
  UNIQUE KEY `research_project_title_2` (`research_project_title`,`research_group_id`),
  KEY `department_id` (`department_id`),
  KEY `idx_research_project_status` (`research_project_status`),
  KEY `idx_research_project_group_status` (`research_group_id`,`research_project_status`),
  FULLTEXT KEY `ft_research_project_title` (`research_project_title`),
  CONSTRAINT `research_project_ibfk_1` FOREIGN KEY (`research_group_id`) REFERENCES `research_group` (`research_group_id`) ON DELETE RESTRICT,
  CONSTRAINT `research_project_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `research_project`
--

LOCK TABLES `research_project` WRITE;
/*!40000 ALTER TABLE `research_project` DISABLE KEYS */;
INSERT INTO `research_project` VALUES (1,1,1,'Deep Learning for Medical Diagnosis','EPSRC Grant £250,000','5 conference papers, 2 journal articles','Improved diagnostic accuracy by 15%','Active','Collaboration with NHS trusts','2025-05-24 14:18:51','2025-05-24 14:18:51'),(2,2,2,'Mathematical Models for Climate Change','NERC Grant £180,000','3 journal articles','Policy recommendations submitted','Active','Government advisory input','2025-05-24 14:18:51','2025-05-24 14:18:51'),(3,3,3,'Quantum Computing Algorithms','Royal Society Grant £200,000','4 journal articles','Patent application filed','Active','Industry partnership potential','2025-05-24 14:18:51','2025-05-24 14:18:51'),(4,4,4,'Sustainable Chemical Processes','Innovate UK Grant £150,000','6 journal articles','Green chemistry protocols developed','Active','Environmental impact reduction','2025-05-24 14:18:51','2025-05-24 14:18:51'),(5,5,5,'Marine Biodiversity Assessment','Marine Conservation Grant £120,000','8 journal articles','Species conservation recommendations','Active','International collaboration','2025-05-24 14:18:51','2025-05-24 14:18:51'),(6,6,6,'Digital Archive Development','Arts Council Grant £80,000','2 book chapters','Online archive platform created','Completed','Public access achieved','2025-05-24 14:18:51','2025-05-24 14:18:51'),(7,7,7,'Social History Documentation','Heritage Lottery Grant £100,000','3 journal articles','Historical database compiled','Active','Community engagement focus','2025-05-24 14:18:51','2025-05-24 14:18:51'),(8,8,8,'Economic Impact Analysis','Treasury Research Grant £90,000','4 policy papers','Economic forecasting model developed','Active','Government policy influence','2025-05-24 14:18:51','2025-05-24 14:18:51'),(9,9,9,'Ethics in Technology','Wellcome Trust Grant £110,000','5 journal articles','Ethical guidelines published','Active','Technology sector adoption','2025-05-24 14:18:51','2025-05-24 14:18:51'),(10,10,10,'Cognitive Function Mapping','MRC Grant £300,000','7 journal articles','Brain imaging protocols established','Active','Clinical applications developed','2025-05-24 14:18:51','2025-05-24 14:18:51');
/*!40000 ALTER TABLE `research_project` ENABLE KEYS */;
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
