CREATE DATABASE  IF NOT EXISTS `digitalnapijaca` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `digitalnapijaca`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: digitalnapijaca
-- ------------------------------------------------------
-- Server version	8.0.43

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
-- Table structure for table `kategorija`
--

DROP TABLE IF EXISTS `kategorija`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kategorija` (
  `id_kategorija` int NOT NULL AUTO_INCREMENT,
  `putanja_slike` varchar(255) DEFAULT NULL,
  `naziv` varchar(45) NOT NULL,
  `vrsta` enum('voce','povrce') NOT NULL,
  PRIMARY KEY (`id_kategorija`),
  UNIQUE KEY `naziv_UNIQUE` (`naziv`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kategorija`
--

LOCK TABLES `kategorija` WRITE;
/*!40000 ALTER TABLE `kategorija` DISABLE KEYS */;
/*!40000 ALTER TABLE `kategorija` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `korisnik`
--

DROP TABLE IF EXISTS `korisnik`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `korisnik` (
  `id_korisnik` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `sifra` varchar(255) NOT NULL,
  `ime` varchar(255) NOT NULL,
  `uloga` enum('kupac','domacin','admin') NOT NULL DEFAULT 'kupac',
  `telefon` varchar(20) DEFAULT NULL,
  `adresa` varchar(255) DEFAULT NULL,
  `opis` text,
  `fk_mesto` int DEFAULT NULL,
  PRIMARY KEY (`id_korisnik`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  KEY `fk_mesto_idx` (`fk_mesto`),
  CONSTRAINT `fk_mesto` FOREIGN KEY (`fk_mesto`) REFERENCES `mesto` (`id_mesto`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `korisnik`
--

LOCK TABLES `korisnik` WRITE;
/*!40000 ALTER TABLE `korisnik` DISABLE KEYS */;
/*!40000 ALTER TABLE `korisnik` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mesto`
--

DROP TABLE IF EXISTS `mesto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mesto` (
  `id_mesto` int NOT NULL AUTO_INCREMENT,
  `naziv` varchar(45) NOT NULL,
  PRIMARY KEY (`id_mesto`),
  UNIQUE KEY `naziv_UNIQUE` (`naziv`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mesto`
--

LOCK TABLES `mesto` WRITE;
/*!40000 ALTER TABLE `mesto` DISABLE KEYS */;
/*!40000 ALTER TABLE `mesto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obavestenje`
--

DROP TABLE IF EXISTS `obavestenje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `obavestenje` (
  `id_obavestenje` int NOT NULL AUTO_INCREMENT,
  `sadrzaj` text,
  `datum_kreiranja` datetime DEFAULT CURRENT_TIMESTAMP,
  `vidljivost` tinyint NOT NULL DEFAULT '0',
  `fk_admin` int DEFAULT NULL,
  `fk_zahtev` int DEFAULT NULL,
  PRIMARY KEY (`id_obavestenje`),
  KEY `fk_admin_idx` (`fk_admin`),
  KEY `fk_zahtev_idx` (`fk_zahtev`),
  CONSTRAINT `fk_admin_obavestenje` FOREIGN KEY (`fk_admin`) REFERENCES `korisnik` (`id_korisnik`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_zahtev` FOREIGN KEY (`fk_zahtev`) REFERENCES `zahtev` (`id_zahtev`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obavestenje`
--

LOCK TABLES `obavestenje` WRITE;
/*!40000 ALTER TABLE `obavestenje` DISABLE KEYS */;
/*!40000 ALTER TABLE `obavestenje` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proizvod`
--

DROP TABLE IF EXISTS `proizvod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proizvod` (
  `id_proizvod` int NOT NULL AUTO_INCREMENT,
  `naziv` varchar(100) NOT NULL,
  `opis` text,
  `putanja_slike` varchar(255) DEFAULT NULL,
  `nacin_uzgoja` enum('organski','prskano') NOT NULL DEFAULT 'prskano',
  `dostupnost` tinyint NOT NULL DEFAULT '1',
  `datum_kreiranja` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fk_domacin` int NOT NULL,
  `fk_kategorija` int DEFAULT NULL,
  PRIMARY KEY (`id_proizvod`),
  KEY `fk_domacin_idx` (`fk_domacin`),
  KEY `fk_kategorija_idx` (`fk_kategorija`),
  CONSTRAINT `fk_domacin` FOREIGN KEY (`fk_domacin`) REFERENCES `korisnik` (`id_korisnik`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_kategorija` FOREIGN KEY (`fk_kategorija`) REFERENCES `kategorija` (`id_kategorija`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proizvod`
--

LOCK TABLES `proizvod` WRITE;
/*!40000 ALTER TABLE `proizvod` DISABLE KEYS */;
/*!40000 ALTER TABLE `proizvod` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zahtev`
--

DROP TABLE IF EXISTS `zahtev`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zahtev` (
  `id_zahtev` int NOT NULL AUTO_INCREMENT,
  `prilozeni_telefon` varchar(20) NOT NULL,
  `prilozena_adresa` varchar(255) NOT NULL,
  `status` enum('odobreno','odbijeno','u_obradi') NOT NULL DEFAULT 'u_obradi',
  `komentar` text,
  `datum_kreiranja` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `datum_obrade` datetime(3) DEFAULT NULL,
  `fk_kupac` int NOT NULL,
  `fk_admin` int DEFAULT NULL,
  `fk_prilozeno_mesto` int DEFAULT NULL,
  PRIMARY KEY (`id_zahtev`),
  KEY `fk_kupac_idx` (`fk_kupac`),
  KEY `fk_admin_idx` (`fk_admin`),
  KEY `fk_prilozeno_mesto_idx` (`fk_prilozeno_mesto`),
  CONSTRAINT `fk_admin` FOREIGN KEY (`fk_admin`) REFERENCES `korisnik` (`id_korisnik`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_kupac` FOREIGN KEY (`fk_kupac`) REFERENCES `korisnik` (`id_korisnik`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_prilozeno_mesto` FOREIGN KEY (`fk_prilozeno_mesto`) REFERENCES `mesto` (`id_mesto`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zahtev`
--

LOCK TABLES `zahtev` WRITE;
/*!40000 ALTER TABLE `zahtev` DISABLE KEYS */;
/*!40000 ALTER TABLE `zahtev` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-08 16:44:15
