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
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `department_id` int NOT NULL AUTO_INCREMENT,
  `department_name` varchar(100) NOT NULL,
  `department_research_areas` text,
  `department_notes` text,
  `department_date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `department_date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`department_id`),
  UNIQUE KEY `department_name` (`department_name`),
  FULLTEXT KEY `ft_department_research` (`department_research_areas`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'Computer Science','Artificial Intelligence, Machine Learning, Cybersecurity, Software Engineering','Leading department in technological innovation','2025-05-24 14:18:51','2025-05-24 14:18:51'),(2,'Mathematics','Pure Mathematics, Applied Mathematics, Statistics, Mathematical Modelling','Strong focus on theoretical and applied research','2025-05-24 14:18:51','2025-05-24 14:18:51'),(3,'Physics','Quantum Physics, Astrophysics, Condensed Matter, Particle Physics','State-of-the-art laboratory facilities','2025-05-24 14:18:51','2025-05-24 14:18:51'),(4,'Chemistry','Organic Chemistry, Inorganic Chemistry, Physical Chemistry, Biochemistry','Research excellence in chemical sciences','2025-05-24 14:18:51','2025-05-24 14:18:51'),(5,'Biology','Molecular Biology, Ecology, Genetics, Marine Biology','Comprehensive biological research programmes','2025-05-24 14:18:51','2025-05-24 14:18:51'),(6,'English Literature','Victorian Literature, Contemporary Fiction, Poetry, Literary Theory','Rich tradition in literary scholarship','2025-05-24 14:18:51','2025-05-24 14:18:51'),(7,'History','Medieval History, Modern European History, British History, Social History','Extensive archival collections','2025-05-24 14:18:51','2025-05-24 14:18:51'),(8,'Economics','Macroeconomics, Microeconomics, Econometrics, Development Economics','Policy-focused research initiatives','2025-05-24 14:18:51','2025-05-24 14:18:51'),(9,'Philosophy','Ethics, Metaphysics, Philosophy of Mind, Political Philosophy','Critical thinking and analytical reasoning','2025-05-24 14:18:51','2025-05-24 14:18:51'),(10,'Psychology','Cognitive Psychology, Clinical Psychology, Social Psychology, Developmental Psychology','Human behaviour research centre','2025-05-24 14:18:51','2025-05-24 14:18:51');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
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
