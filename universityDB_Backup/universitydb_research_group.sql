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
-- Table structure for table `research_group`
--

DROP TABLE IF EXISTS `research_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `research_group` (
  `research_group_id` int NOT NULL AUTO_INCREMENT,
  `research_group_name` varchar(100) NOT NULL,
  `research_group_description` text,
  `research_group_status` enum('Active','Inactive') NOT NULL DEFAULT 'Active',
  `research_group_date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `research_group_date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`research_group_id`),
  UNIQUE KEY `research_group_name` (`research_group_name`),
  KEY `idx_research_group_status` (`research_group_status`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `research_group`
--

LOCK TABLES `research_group` WRITE;
/*!40000 ALTER TABLE `research_group` DISABLE KEYS */;
INSERT INTO `research_group` VALUES (1,'Artificial Intelligence Laboratory','Advanced AI research focusing on machine learning and neural networks','Active','2025-05-24 14:18:51','2025-05-24 14:18:51'),(2,'Mathematical Modelling Centre','Applied mathematics research for real-world problem solving','Active','2025-05-24 14:18:51','2025-05-24 14:18:51'),(3,'Quantum Physics Research Group','Cutting-edge quantum mechanics and computing research','Active','2025-05-24 14:18:51','2025-05-24 14:18:51'),(4,'Green Chemistry Initiative','Sustainable chemistry research and environmental applications','Active','2025-05-24 14:18:51','2025-05-24 14:18:51'),(5,'Marine Conservation Unit','Research focused on marine ecosystem preservation','Active','2025-05-24 14:18:51','2025-05-24 14:18:51'),(6,'Digital Humanities Project','Technology applications in literary and historical research','Active','2025-05-24 14:18:51','2025-05-24 14:18:51'),(7,'Social History Archive','Preservation and analysis of historical social documents','Active','2025-05-24 14:18:51','2025-05-24 14:18:51'),(8,'Economic Policy Institute','Research on contemporary economic challenges and solutions','Active','2025-05-24 14:18:51','2025-05-24 14:18:51'),(9,'Applied Ethics Centre','Practical applications of philosophical ethics in modern society','Active','2025-05-24 14:18:51','2025-05-24 14:18:51'),(10,'Cognitive Neuroscience Lab','Brain imaging and cognitive function research','Active','2025-05-24 14:18:51','2025-05-24 14:18:51');
/*!40000 ALTER TABLE `research_group` ENABLE KEYS */;
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
