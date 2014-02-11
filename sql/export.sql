CREATE DATABASE  IF NOT EXISTS `goodbank` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `goodbank`;
-- MySQL dump 10.13  Distrib 5.6.13, for osx10.6 (i386)
--
-- Host: 127.0.0.1    Database: goodbank
-- ------------------------------------------------------
-- Server version	5.6.12

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account_interest`
--

DROP TABLE IF EXISTS `account_interest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_interest` (
  `interest_id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `account_type` int(6) unsigned NOT NULL,
  `interest` float(4,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`interest_id`),
  KEY `interest_external_account_type_idx` (`account_type`),
  CONSTRAINT `interest_external_account_type` FOREIGN KEY (`account_type`) REFERENCES `account_types` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_interest`
--

LOCK TABLES `account_interest` WRITE;
/*!40000 ALTER TABLE `account_interest` DISABLE KEYS */;
INSERT INTO `account_interest` VALUES (1,1,2.20),(2,2,3.40),(3,3,3.75);
/*!40000 ALTER TABLE `account_interest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_types`
--

DROP TABLE IF EXISTS `account_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_types` (
  `type_id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_types`
--

LOCK TABLES `account_types` WRITE;
/*!40000 ALTER TABLE `account_types` DISABLE KEYS */;
INSERT INTO `account_types` VALUES (1,'Cuenta morada'),(2,'Cuenta nómina plus'),(3,'Cuenta ahorro platino');
/*!40000 ALTER TABLE `account_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts` (
  `account_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `account_number` bigint(10) unsigned NOT NULL,
  `branch` bigint(20) unsigned NOT NULL,
  `creation_date` date NOT NULL,
  `account_type` int(6) unsigned NOT NULL,
  `client_id` bigint(20) unsigned NOT NULL,
  `second_client_id` bigint(20) unsigned DEFAULT NULL,
  `third_client_id` bigint(20) unsigned DEFAULT NULL,
  `amount` decimal(65,10) NOT NULL DEFAULT '0.0000000000',
  PRIMARY KEY (`account_id`),
  KEY `accounts_external_branch_idx` (`branch`),
  KEY `accounts_external_account_type_idx` (`account_type`),
  KEY `accounts_external_client_idx` (`client_id`),
  KEY `accounts_external_secondary_client_idx` (`second_client_id`),
  KEY `accounts_external_tertiary_idx` (`third_client_id`),
  CONSTRAINT `accounts_external_account_type` FOREIGN KEY (`account_type`) REFERENCES `account_types` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `accounts_external_branch` FOREIGN KEY (`branch`) REFERENCES `branches` (`branch_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `accounts_external_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `accounts_external_secondary_client` FOREIGN KEY (`second_client_id`) REFERENCES `clients` (`client_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `accounts_external_tertiary` FOREIGN KEY (`third_client_id`) REFERENCES `clients` (`client_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,6313332953,1,'2013-11-10',1,1,NULL,NULL,1577.0599215183),(2,8665511473,2,'2012-09-10',2,2,NULL,NULL,3715.7018127462),(3,4593984876,2,'2010-12-10',3,2,3,NULL,31117.5751986142),(4,4325463421,2,'2013-11-05',1,3,NULL,NULL,97768.0157681824);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branches`
--

DROP TABLE IF EXISTS `branches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `branches` (
  `branch_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `branch_code` int(4) unsigned NOT NULL,
  `street_type` int(6) unsigned NOT NULL,
  `address` varchar(150) NOT NULL,
  `province` int(6) unsigned NOT NULL,
  `community` int(4) unsigned NOT NULL,
  `phone_number` bigint(11) unsigned NOT NULL,
  `manager` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`branch_id`),
  KEY `branches_external_street_idx` (`street_type`),
  KEY `branches_external_province_idx` (`province`),
  KEY `branches_external_community_idx` (`community`),
  KEY `branches_external_manager_idx` (`manager`),
  CONSTRAINT `branches_external_community` FOREIGN KEY (`community`) REFERENCES `communities` (`community_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `branches_external_manager` FOREIGN KEY (`manager`) REFERENCES `managers` (`manager_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `branches_external_province` FOREIGN KEY (`province`) REFERENCES `provinces` (`province_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `branches_external_street` FOREIGN KEY (`street_type`) REFERENCES `street_types` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branches`
--

LOCK TABLES `branches` WRITE;
/*!40000 ALTER TABLE `branches` DISABLE KEYS */;
INSERT INTO `branches` VALUES (1,5674,6,'Trinidad 3',47,7,34983252525,2),(2,1628,7,'Equinoccio Leganés',28,13,34912525252,3);
/*!40000 ALTER TABLE `branches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_ranges`
--

DROP TABLE IF EXISTS `client_ranges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_ranges` (
  `range_id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  PRIMARY KEY (`range_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_ranges`
--

LOCK TABLES `client_ranges` WRITE;
/*!40000 ALTER TABLE `client_ranges` DISABLE KEYS */;
INSERT INTO `client_ranges` VALUES (1,'Cliente estándar'),(2,'Cliente oro'),(3,'Cliente platino');
/*!40000 ALTER TABLE `client_ranges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clients` (
  `client_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_card` varchar(9) NOT NULL,
  `name` varchar(50) NOT NULL,
  `lastname_first` varchar(50) NOT NULL,
  `lastname_second` varchar(50) NOT NULL,
  `birth_date` date NOT NULL,
  `street_type` int(6) unsigned NOT NULL,
  `address` varchar(150) NOT NULL,
  `province` int(6) unsigned NOT NULL,
  `community` int(4) unsigned NOT NULL,
  `phone_number` bigint(11) unsigned NOT NULL,
  `client_range` int(4) unsigned NOT NULL,
  `password` varchar(128) NOT NULL,
  PRIMARY KEY (`client_id`),
  KEY `clients_external_street_idx` (`street_type`),
  KEY `clients_external_province_idx` (`province`),
  KEY `clients_external_community_idx` (`community`),
  KEY `clients_external_range_idx` (`client_range`),
  CONSTRAINT `clients_external_community` FOREIGN KEY (`community`) REFERENCES `communities` (`community_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `clients_external_province` FOREIGN KEY (`province`) REFERENCES `provinces` (`province_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `clients_external_range` FOREIGN KEY (`client_range`) REFERENCES `client_ranges` (`range_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `clients_external_street` FOREIGN KEY (`street_type`) REFERENCES `street_types` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,'62581737W','Juan','Benito','Marín','1985-10-12',16,'Cuatro caminos 3 4B',47,7,34666787834,1,'7469eb3dc5848b1dadd0f638a95cf4e4f0d6246717d5dc92e77b80f5199182b0f2cc1bb86c9187666b90aca27372cdb03d22689a9343c5a96993bb1782f7a67d'),(2,'54325661Y','Teresa','Luenco','Pérez','1986-04-22',8,'Tenerife 2 1B',47,7,34646482831,2,'7469eb3dc5848b1dadd0f638a95cf4e4f0d6246717d5dc92e77b80f5199182b0f2cc1bb86c9187666b90aca27372cdb03d22689a9343c5a96993bb1782f7a67d'),(3,'37532591H','Juan','Benito','Marín','1985-10-12',6,'Trinidad 1 2B',28,13,34666787834,2,'7469eb3dc5848b1dadd0f638a95cf4e4f0d6246717d5dc92e77b80f5199182b0f2cc1bb86c9187666b90aca27372cdb03d22689a9343c5a96993bb1782f7a67d');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `communities`
--

DROP TABLE IF EXISTS `communities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `communities` (
  `community_id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `community` varchar(100) NOT NULL,
  PRIMARY KEY (`community_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `communities`
--

LOCK TABLES `communities` WRITE;
/*!40000 ALTER TABLE `communities` DISABLE KEYS */;
INSERT INTO `communities` VALUES (1,'Andalucía'),(2,'Aragón'),(3,'Asturias, Principado de'),(4,'Balears, Illes'),(5,'Canarias'),(6,'Cantabria'),(7,'Castilla y León'),(8,'Castilla - La Mancha'),(9,'Catalunya'),(10,'Comunitat Valenciana'),(11,'Extremadura'),(12,'Galicia'),(13,'Madrid, Comunidad de'),(14,'Murcia, Región de'),(15,'Navarra, Comunidad Foral de'),(16,'País Vasco'),(17,'Rioja, La'),(18,'Ceuta'),(19,'Melilla');
/*!40000 ALTER TABLE `communities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manager_ranges`
--

DROP TABLE IF EXISTS `manager_ranges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manager_ranges` (
  `range_id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  PRIMARY KEY (`range_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager_ranges`
--

LOCK TABLES `manager_ranges` WRITE;
/*!40000 ALTER TABLE `manager_ranges` DISABLE KEYS */;
INSERT INTO `manager_ranges` VALUES (1,'Empleado estándar'),(2,'Director'),(3,'Administrador');
/*!40000 ALTER TABLE `manager_ranges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `managers`
--

DROP TABLE IF EXISTS `managers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `managers` (
  `manager_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_card` varchar(9) NOT NULL,
  `name` varchar(50) NOT NULL,
  `lastname_first` varchar(50) NOT NULL,
  `lastname_second` varchar(50) NOT NULL,
  `birth_date` date NOT NULL,
  `street_type` int(6) unsigned NOT NULL,
  `address` varchar(150) NOT NULL,
  `province` int(6) unsigned NOT NULL,
  `community` int(4) unsigned NOT NULL,
  `phone_number` bigint(11) unsigned NOT NULL,
  `manager_range` int(4) unsigned NOT NULL,
  `password` varchar(128) NOT NULL,
  PRIMARY KEY (`manager_id`),
  KEY `managers_external_street_idx` (`street_type`),
  KEY `managers_external_province_idx` (`province`),
  KEY `managers_external_community_idx` (`community`),
  KEY `managers_external_range_idx` (`manager_range`),
  CONSTRAINT `manager_external_community` FOREIGN KEY (`community`) REFERENCES `communities` (`community_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `manager_external_province` FOREIGN KEY (`province`) REFERENCES `provinces` (`province_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `manager_external_range` FOREIGN KEY (`manager_range`) REFERENCES `manager_ranges` (`range_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `manager_external_street` FOREIGN KEY (`street_type`) REFERENCES `street_types` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `managers`
--

LOCK TABLES `managers` WRITE;
/*!40000 ALTER TABLE `managers` DISABLE KEYS */;
INSERT INTO `managers` VALUES (1,'83373738A','Super Admin','Boss','Manager','1998-05-16',8,'Falsa 12 3E',47,7,34983121212,3,'5fc2ca6f085919f2f77626f1e280fab9cc92b4edc9edc53ac6eee3f72c5c508e869ee9d67a96d63986d14c1c2b82c35ff5f31494bea831015424f59c96fff664'),(2,'26170333J','Juan','Rebollo','Martínez','1987-04-19',8,'de la salud 11 4D',47,7,34666567834,2,'5fc2ca6f085919f2f77626f1e280fab9cc92b4edc9edc53ac6eee3f72c5c508e869ee9d67a96d63986d14c1c2b82c35ff5f31494bea831015424f59c96fff664'),(3,'74702757E','María','Miñón','Aparicio','1983-02-24',20,'de Europa 23 2B',28,13,34666127812,2,'5fc2ca6f085919f2f77626f1e280fab9cc92b4edc9edc53ac6eee3f72c5c508e869ee9d67a96d63986d14c1c2b82c35ff5f31494bea831015424f59c96fff664'),(4,'88954664W','Marta','González','Pérez','1989-08-11',6,'san martín 5 5 22',47,7,34983111213,1,'5fc2ca6f085919f2f77626f1e280fab9cc92b4edc9edc53ac6eee3f72c5c508e869ee9d67a96d63986d14c1c2b82c35ff5f31494bea831015424f59c96fff664');
/*!40000 ALTER TABLE `managers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provinces`
--

DROP TABLE IF EXISTS `provinces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provinces` (
  `province_id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `province` varchar(50) NOT NULL,
  PRIMARY KEY (`province_id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provinces`
--

LOCK TABLES `provinces` WRITE;
/*!40000 ALTER TABLE `provinces` DISABLE KEYS */;
INSERT INTO `provinces` VALUES (1,'Araba/Álava'),(2,'Albacete'),(3,'Alicante/Alacant'),(4,'Almería'),(5,'Ávila'),(6,'Badajoz'),(7,'Balears, Illes'),(8,'Barcelona'),(9,'Burgos'),(10,'Cáceres'),(11,'Cádiz'),(12,'Castellón/Castelló'),(13,'Ciudad Real'),(14,'Córdoba'),(15,'Coruña, A'),(16,'Cuenca'),(17,'Girona'),(18,'Granada'),(19,'Guadalajara'),(20,'Gipuzkoa'),(21,'Huelva'),(22,'Huesca'),(23,'Jaén'),(24,'León'),(25,'Lleida'),(26,'Rioja, La'),(27,'Lugo'),(28,'Madrid'),(29,'Málaga'),(30,'Murcia'),(31,'Navarra'),(32,'Ourense'),(33,'Asturias'),(34,'Palencia'),(35,'Palmas, Las'),(36,'Pontevedra'),(37,'Salamanca'),(38,'Santa Cruz de Tenerife'),(39,'Cantabria'),(40,'Segovia'),(41,'Sevilla'),(42,'Soria'),(43,'Tarragona'),(44,'Teruel'),(45,'Toledo'),(46,'Valencia/València'),(47,'Valladolid'),(48,'Bizkaia'),(49,'Zamora'),(50,'Zaragoza'),(51,'Ceuta'),(52,'Melilla');
/*!40000 ALTER TABLE `provinces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `street_types`
--

DROP TABLE IF EXISTS `street_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `street_types` (
  `type_id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `street_types`
--

LOCK TABLES `street_types` WRITE;
/*!40000 ALTER TABLE `street_types` DISABLE KEYS */;
INSERT INTO `street_types` VALUES (1,'Acceso'),(2,'Acera'),(3,'Alameda'),(4,'Autopista'),(5,'Autovía'),(6,'Avenida'),(7,'C. Comercial'),(8,'Calle'),(9,'Callejón'),(10,'Camino'),(11,'Cañada'),(12,'Carrer'),(13,'Carrera'),(14,'Carretera'),(15,'Cuesta'),(16,'Glorieta'),(17,'Pasadizo'),(18,'Pasaje'),(19,'Paseo'),(20,'Plaza'),(21,'Rambla'),(22,'Ronda'),(23,'Sendero'),(24,'Travesía'),(25,'Urbanización'),(26,'Vía');
/*!40000 ALTER TABLE `street_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactions` (
  `transaction_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `account` bigint(20) unsigned NOT NULL,
  `transaction_date` datetime NOT NULL,
  `amount` decimal(65,10) NOT NULL DEFAULT '0.0000000000',
  `applicant` varchar(150) NOT NULL,
  `concept` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `transactions_external_account_idx` (`account`),
  CONSTRAINT `accounts_external_account` FOREIGN KEY (`account`) REFERENCES `accounts` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=521 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (1,3,'2010-12-10 10:30:00',570.0000000000,'Teresa Luenco','Ingreso en efectivo inicial'),(2,3,'2011-01-10 10:30:00',570.0000000000,'Juan Benito','Ingreso en efectivo'),(3,3,'2011-02-10 10:30:00',570.0000000000,'Juan Benito','Ingreso en efectivo'),(4,3,'2011-03-10 10:20:00',570.0000000000,'Juan Benito','Ingreso en efectivo'),(5,3,'2011-04-10 10:30:00',570.0000000000,'Juan Benito','Ingreso en efectivo'),(6,3,'2011-05-10 10:30:00',570.0000000000,'Juan Benito','Ingreso en efectivo'),(7,3,'2011-06-10 10:20:00',570.0000000000,'Juan Benito','Ingreso en efectivo'),(8,3,'2011-07-10 10:30:00',570.0000000000,'Juan Benito','Ingreso en efectivo'),(9,3,'2011-09-10 10:30:00',570.0000000000,'Juan Benito','Ingreso en efectivo'),(10,3,'2011-10-10 10:30:00',570.0000000000,'Juan Benito','Ingreso en efectivo'),(11,3,'2011-11-10 10:30:00',570.0000000000,'Juan Benito','Ingreso en efectivo'),(12,3,'2011-12-10 10:30:00',570.0000000000,'Juan Benito','Ingreso en efectivo'),(13,3,'2012-01-10 10:30:00',570.0000000000,'Juan Benito','Ingreso en efectivo'),(14,3,'2012-02-10 10:30:00',570.0000000000,'Juan Benito','Ingreso en efectivo'),(15,3,'2012-03-10 10:30:00',570.0000000000,'Juan Benito','Ingreso en efectivo'),(16,3,'2012-04-10 10:10:00',570.0000000000,'Juan Benito','Ingreso en efectivo'),(17,3,'2012-05-10 10:30:00',570.0000000000,'Juan Benito','Ingreso en efectivo'),(18,3,'2012-06-10 10:30:00',570.0000000000,'Juan Benito','Ingreso en efectivo'),(19,3,'2012-07-10 10:30:00',570.0000000000,'Juan Benito','Ingreso en efectivo'),(20,3,'2012-09-10 10:30:00',570.0000000000,'Juan Benito','Ingreso en efectivo'),(21,3,'2012-10-10 10:30:00',570.0000000000,'Juan Benito','Ingreso en efectivo'),(22,3,'2012-11-10 10:30:00',570.0000000000,'Juan Benito','Ingreso en efectivo'),(23,3,'2012-12-10 10:30:00',570.0000000000,'Juan Benito','Ingreso en efectivo'),(24,3,'2013-01-10 10:30:00',570.0000000000,'Juan Benito','Ingreso en efectivo'),(25,3,'2013-02-10 10:30:00',570.0000000000,'Juan Benito','Ingreso en efectivo'),(26,3,'2013-03-10 10:30:00',570.0000000000,'Juan Benito','Ingreso en efectivo'),(27,3,'2013-04-10 10:30:00',570.0000000000,'Juan Benito','Ingreso en efectivo'),(28,3,'2013-05-10 10:30:00',570.0000000000,'Juan Benito','Ingreso en efectivo'),(29,3,'2013-06-10 10:30:00',570.0000000000,'Juan Benito','Ingreso en efectivo'),(30,3,'2013-07-10 10:30:00',570.0000000000,'Juan Benito','Ingreso en efectivo'),(31,3,'2013-09-10 10:30:00',570.0000000000,'Juan Benito','Ingreso en efectivo'),(32,3,'2013-10-10 10:30:00',570.0000000000,'Juan Benito','Ingreso en efectivo'),(33,3,'2013-11-10 10:30:00',570.0000000000,'Juan Benito','Ingreso en efectivo'),(34,4,'2013-11-06 08:30:10',579.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(35,4,'2013-11-08 09:12:11',-79.7500000000,'Iberdrola Generación SA','Adeudo de Iberdrola'),(36,4,'2013-11-10 11:37:33',-13.1400000000,'Aguas de Valladolid','Adeudo de agua'),(37,4,'2013-11-10 13:22:45',-83.1400000000,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(38,4,'2013-11-19 20:49:00',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(39,4,'2013-11-19 20:49:00',-84.0946694810,'Iberdrola Generación SA','Adeudo de Iberdrola'),(40,4,'2013-11-19 20:49:00',-17.2772193604,'Aguas de Valladolid','Adeudo de agua'),(41,4,'2013-11-19 20:49:00',-67.1361857917,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(42,4,'2013-11-19 20:50:00',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(43,4,'2013-11-19 20:50:00',-86.0622299473,'Iberdrola Generación SA','Adeudo de Iberdrola'),(44,4,'2013-11-19 20:50:00',-17.8934884935,'Aguas de Valladolid','Adeudo de agua'),(45,4,'2013-11-19 20:50:00',-58.2111115136,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(46,4,'2013-11-19 20:51:00',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(47,4,'2013-11-19 20:51:00',-70.9894306685,'Iberdrola Generación SA','Adeudo de Iberdrola'),(48,4,'2013-11-19 20:51:00',-12.0743782972,'Aguas de Valladolid','Adeudo de agua'),(49,4,'2013-11-19 20:51:00',-81.1529774795,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(50,4,'2013-11-19 20:51:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(51,4,'2013-11-19 20:51:28',-80.2380204745,'Iberdrola Generación SA','Adeudo de Iberdrola'),(52,4,'2013-11-19 20:51:28',-16.7087813508,'Aguas de Valladolid','Adeudo de agua'),(53,4,'2013-11-19 20:51:28',-72.1323238544,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(54,4,'2013-11-19 20:52:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(55,4,'2013-11-19 20:52:28',-79.6335568002,'Iberdrola Generación SA','Adeudo de Iberdrola'),(56,4,'2013-11-19 20:52:28',-11.6609956691,'Aguas de Valladolid','Adeudo de agua'),(57,4,'2013-11-19 20:52:28',-57.6771846384,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(58,4,'2013-11-19 20:53:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(59,4,'2013-11-19 20:53:28',-72.2798828253,'Iberdrola Generación SA','Adeudo de Iberdrola'),(60,4,'2013-11-19 20:53:28',-10.7747774250,'Aguas de Valladolid','Adeudo de agua'),(61,4,'2013-11-19 20:53:28',-70.8583073445,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(62,4,'2013-11-19 20:54:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(63,4,'2013-11-19 20:54:28',-63.5346573548,'Iberdrola Generación SA','Adeudo de Iberdrola'),(64,4,'2013-11-19 20:54:28',-13.1743368933,'Aguas de Valladolid','Adeudo de agua'),(65,4,'2013-11-19 20:54:28',-97.1759885035,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(66,4,'2013-11-19 20:55:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(67,4,'2013-11-19 20:55:28',-65.9662919764,'Iberdrola Generación SA','Adeudo de Iberdrola'),(68,4,'2013-11-19 20:55:28',-17.8210620041,'Aguas de Valladolid','Adeudo de agua'),(69,4,'2013-11-19 20:55:28',-68.7566077217,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(70,4,'2013-11-19 20:56:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(71,4,'2013-11-19 20:56:28',-61.0257718867,'Iberdrola Generación SA','Adeudo de Iberdrola'),(72,4,'2013-11-19 20:56:28',-14.9466197689,'Aguas de Valladolid','Adeudo de agua'),(73,4,'2013-11-19 20:56:28',-50.5131750750,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(74,4,'2013-11-19 20:57:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(75,4,'2013-11-19 20:57:28',-63.6014944941,'Iberdrola Generación SA','Adeudo de Iberdrola'),(76,4,'2013-11-19 20:57:28',-15.6189351197,'Aguas de Valladolid','Adeudo de agua'),(77,4,'2013-11-19 20:57:28',-77.1820248279,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(78,4,'2013-11-19 20:58:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(79,4,'2013-11-19 20:58:28',-83.2635345147,'Iberdrola Generación SA','Adeudo de Iberdrola'),(80,4,'2013-11-19 20:58:28',-13.8294334239,'Aguas de Valladolid','Adeudo de agua'),(81,4,'2013-11-19 20:58:28',-65.7744926766,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(82,4,'2013-11-19 20:59:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(83,4,'2013-11-19 20:59:28',-81.3868246174,'Iberdrola Generación SA','Adeudo de Iberdrola'),(84,4,'2013-11-19 20:59:28',-18.3107306189,'Aguas de Valladolid','Adeudo de agua'),(85,4,'2013-11-19 20:59:28',-69.9111855602,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(86,4,'2013-11-19 21:00:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(87,4,'2013-11-19 21:00:28',-68.6071415582,'Iberdrola Generación SA','Adeudo de Iberdrola'),(88,4,'2013-11-19 21:00:28',-17.7983236402,'Aguas de Valladolid','Adeudo de agua'),(89,4,'2013-11-19 21:00:28',-91.1909347106,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(90,4,'2013-11-19 21:01:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(91,4,'2013-11-19 21:01:28',-85.0416553720,'Iberdrola Generación SA','Adeudo de Iberdrola'),(92,4,'2013-11-19 21:01:28',-19.2670854961,'Aguas de Valladolid','Adeudo de agua'),(93,4,'2013-11-19 21:01:28',-96.3795035516,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(94,4,'2013-11-19 21:02:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(95,4,'2013-11-19 21:02:28',-78.3108195889,'Iberdrola Generación SA','Adeudo de Iberdrola'),(96,4,'2013-11-19 21:02:28',-15.7376556653,'Aguas de Valladolid','Adeudo de agua'),(97,4,'2013-11-19 21:02:28',-85.8423797995,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(98,4,'2013-11-19 21:03:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(99,4,'2013-11-19 21:03:28',-88.9592372810,'Iberdrola Generación SA','Adeudo de Iberdrola'),(100,4,'2013-11-19 21:03:28',-10.0387341823,'Aguas de Valladolid','Adeudo de agua'),(101,4,'2013-11-19 21:03:28',-63.6870780477,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(102,4,'2013-11-19 21:04:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(103,4,'2013-11-19 21:04:28',-61.0677768020,'Iberdrola Generación SA','Adeudo de Iberdrola'),(104,4,'2013-11-19 21:04:28',-14.6586126642,'Aguas de Valladolid','Adeudo de agua'),(105,4,'2013-11-19 21:04:28',-79.5753085597,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(106,4,'2013-11-19 21:05:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(107,4,'2013-11-19 21:05:28',-83.5262517403,'Iberdrola Generación SA','Adeudo de Iberdrola'),(108,4,'2013-11-19 21:05:28',-10.5712644531,'Aguas de Valladolid','Adeudo de agua'),(109,4,'2013-11-19 21:05:28',-99.7605427231,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(110,4,'2013-11-19 21:06:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(111,4,'2013-11-19 21:06:28',-89.6495268218,'Iberdrola Generación SA','Adeudo de Iberdrola'),(112,4,'2013-11-19 21:06:28',-10.1131953286,'Aguas de Valladolid','Adeudo de agua'),(113,4,'2013-11-19 21:06:28',-98.4205894801,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(114,4,'2013-11-19 21:07:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(115,4,'2013-11-19 21:07:28',-71.3498678521,'Iberdrola Generación SA','Adeudo de Iberdrola'),(116,4,'2013-11-19 21:07:28',-17.6225932880,'Aguas de Valladolid','Adeudo de agua'),(117,4,'2013-11-19 21:07:28',-74.7744377478,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(118,4,'2013-11-19 21:08:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(119,4,'2013-11-19 21:08:28',-83.0592320911,'Iberdrola Generación SA','Adeudo de Iberdrola'),(120,4,'2013-11-19 21:08:28',-16.0663027396,'Aguas de Valladolid','Adeudo de agua'),(121,4,'2013-11-19 21:08:28',-68.2358511599,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(122,4,'2013-11-19 21:09:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(123,4,'2013-11-19 21:09:28',-61.8074473689,'Iberdrola Generación SA','Adeudo de Iberdrola'),(124,4,'2013-11-19 21:09:28',-15.1513815690,'Aguas de Valladolid','Adeudo de agua'),(125,4,'2013-11-19 21:09:28',-58.1800444816,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(126,4,'2013-11-19 21:10:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(127,4,'2013-11-19 21:10:28',-82.1921226350,'Iberdrola Generación SA','Adeudo de Iberdrola'),(128,4,'2013-11-19 21:10:28',-19.5411322839,'Aguas de Valladolid','Adeudo de agua'),(129,4,'2013-11-19 21:10:28',-83.7862467599,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(130,4,'2013-11-19 21:11:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(131,4,'2013-11-19 21:11:28',-82.6295754602,'Iberdrola Generación SA','Adeudo de Iberdrola'),(132,4,'2013-11-19 21:11:28',-15.0322966448,'Aguas de Valladolid','Adeudo de agua'),(133,4,'2013-11-19 21:11:28',-75.1369155134,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(134,4,'2013-11-19 21:12:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(135,4,'2013-11-19 21:12:28',-71.0781942490,'Iberdrola Generación SA','Adeudo de Iberdrola'),(136,4,'2013-11-19 21:12:28',-19.1512645173,'Aguas de Valladolid','Adeudo de agua'),(137,4,'2013-11-19 21:12:28',-87.2309219974,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(138,4,'2013-11-19 21:13:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(139,4,'2013-11-19 21:13:28',-73.4585742343,'Iberdrola Generación SA','Adeudo de Iberdrola'),(140,4,'2013-11-19 21:13:28',-17.8258520143,'Aguas de Valladolid','Adeudo de agua'),(141,4,'2013-11-19 21:13:28',-61.3007139647,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(142,4,'2013-11-19 21:14:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(143,4,'2013-11-19 21:14:28',-75.6411362694,'Iberdrola Generación SA','Adeudo de Iberdrola'),(144,4,'2013-11-19 21:14:28',-19.7337948203,'Aguas de Valladolid','Adeudo de agua'),(145,4,'2013-11-19 21:14:28',-97.2797919369,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(146,4,'2013-11-19 21:15:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(147,4,'2013-11-19 21:15:28',-84.9034972097,'Iberdrola Generación SA','Adeudo de Iberdrola'),(148,4,'2013-11-19 21:15:28',-14.1031436420,'Aguas de Valladolid','Adeudo de agua'),(149,4,'2013-11-19 21:15:28',-51.9561722756,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(150,4,'2013-11-19 21:16:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(151,4,'2013-11-19 21:16:28',-87.9204822131,'Iberdrola Generación SA','Adeudo de Iberdrola'),(152,4,'2013-11-19 21:16:28',-10.0367531125,'Aguas de Valladolid','Adeudo de agua'),(153,4,'2013-11-19 21:16:28',-97.6301076647,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(154,4,'2013-11-19 21:17:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(155,4,'2013-11-19 21:17:28',-84.1163477264,'Iberdrola Generación SA','Adeudo de Iberdrola'),(156,4,'2013-11-19 21:17:28',-15.4872496235,'Aguas de Valladolid','Adeudo de agua'),(157,4,'2013-11-19 21:17:28',-94.2751270578,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(158,4,'2013-11-19 21:18:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(159,4,'2013-11-19 21:18:28',-74.4565738736,'Iberdrola Generación SA','Adeudo de Iberdrola'),(160,4,'2013-11-19 21:18:28',-12.5309052308,'Aguas de Valladolid','Adeudo de agua'),(161,4,'2013-11-19 21:18:28',-84.3680972635,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(162,4,'2013-11-19 21:19:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(163,4,'2013-11-19 21:19:28',-81.6729276073,'Iberdrola Generación SA','Adeudo de Iberdrola'),(164,4,'2013-11-19 21:19:28',-20.6630931417,'Aguas de Valladolid','Adeudo de agua'),(165,4,'2013-11-19 21:19:28',-100.4488878049,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(166,4,'2013-11-19 21:20:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(167,4,'2013-11-19 21:20:28',-84.1272346502,'Iberdrola Generación SA','Adeudo de Iberdrola'),(168,4,'2013-11-19 21:20:28',-19.1731039562,'Aguas de Valladolid','Adeudo de agua'),(169,4,'2013-11-19 21:20:28',-65.5251528304,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(170,4,'2013-11-19 21:21:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(171,4,'2013-11-19 21:21:28',-62.7667710990,'Iberdrola Generación SA','Adeudo de Iberdrola'),(172,4,'2013-11-19 21:21:28',-12.9505801606,'Aguas de Valladolid','Adeudo de agua'),(173,4,'2013-11-19 21:21:28',-63.0552235901,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(174,4,'2013-11-19 21:22:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(175,4,'2013-11-19 21:22:28',-61.8056590593,'Iberdrola Generación SA','Adeudo de Iberdrola'),(176,4,'2013-11-19 21:22:28',-12.1379388070,'Aguas de Valladolid','Adeudo de agua'),(177,4,'2013-11-19 21:22:28',-53.8922589553,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(178,4,'2013-11-19 21:23:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(179,4,'2013-11-19 21:23:28',-66.3176268913,'Iberdrola Generación SA','Adeudo de Iberdrola'),(180,4,'2013-11-19 21:23:28',-18.2632791982,'Aguas de Valladolid','Adeudo de agua'),(181,4,'2013-11-19 21:23:28',-84.8467228121,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(182,4,'2013-11-19 21:24:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(183,4,'2013-11-19 21:24:28',-66.7029439042,'Iberdrola Generación SA','Adeudo de Iberdrola'),(184,4,'2013-11-19 21:24:28',-14.5124360164,'Aguas de Valladolid','Adeudo de agua'),(185,4,'2013-11-19 21:24:28',-75.1614118254,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(186,4,'2013-11-19 21:25:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(187,4,'2013-11-19 21:25:28',-72.8607066329,'Iberdrola Generación SA','Adeudo de Iberdrola'),(188,4,'2013-11-19 21:25:28',-16.7735847275,'Aguas de Valladolid','Adeudo de agua'),(189,4,'2013-11-19 21:25:28',-70.2192916086,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(190,4,'2013-11-19 21:26:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(191,4,'2013-11-19 21:26:28',-66.7967922226,'Iberdrola Generación SA','Adeudo de Iberdrola'),(192,4,'2013-11-19 21:26:28',-14.1117098147,'Aguas de Valladolid','Adeudo de agua'),(193,4,'2013-11-19 21:26:28',-88.5055025783,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(194,4,'2013-11-19 21:27:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(195,4,'2013-11-19 21:27:28',-83.5767110896,'Iberdrola Generación SA','Adeudo de Iberdrola'),(196,4,'2013-11-19 21:27:28',-14.5818764015,'Aguas de Valladolid','Adeudo de agua'),(197,4,'2013-11-19 21:27:28',-90.0784151634,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(198,4,'2013-11-19 21:28:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(199,4,'2013-11-19 21:28:28',-77.8555776007,'Iberdrola Generación SA','Adeudo de Iberdrola'),(200,4,'2013-11-19 21:28:28',-14.7774552472,'Aguas de Valladolid','Adeudo de agua'),(201,4,'2013-11-19 21:28:28',-94.4963689886,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(202,4,'2013-11-19 21:29:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(203,4,'2013-11-19 21:29:28',-64.8209216374,'Iberdrola Generación SA','Adeudo de Iberdrola'),(204,4,'2013-11-19 21:29:28',-16.5073199633,'Aguas de Valladolid','Adeudo de agua'),(205,4,'2013-11-19 21:29:28',-63.8154131719,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(206,4,'2013-11-19 21:30:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(207,4,'2013-11-19 21:30:28',-82.1627850299,'Iberdrola Generación SA','Adeudo de Iberdrola'),(208,4,'2013-11-19 21:30:28',-17.2313572599,'Aguas de Valladolid','Adeudo de agua'),(209,4,'2013-11-19 21:30:28',-53.9898471123,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(210,4,'2013-11-19 21:31:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(211,4,'2013-11-19 21:31:28',-86.5590999876,'Iberdrola Generación SA','Adeudo de Iberdrola'),(212,4,'2013-11-19 21:31:28',-19.9583948106,'Aguas de Valladolid','Adeudo de agua'),(213,4,'2013-11-19 21:31:28',-70.5645545523,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(214,4,'2013-11-19 21:32:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(215,4,'2013-11-19 21:32:28',-73.4940494554,'Iberdrola Generación SA','Adeudo de Iberdrola'),(216,4,'2013-11-19 21:32:28',-20.6917500660,'Aguas de Valladolid','Adeudo de agua'),(217,4,'2013-11-19 21:32:28',-83.0228194372,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(218,4,'2013-11-19 21:33:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(219,4,'2013-11-19 21:33:28',-60.2976037803,'Iberdrola Generación SA','Adeudo de Iberdrola'),(220,4,'2013-11-19 21:33:28',-13.6363969128,'Aguas de Valladolid','Adeudo de agua'),(221,4,'2013-11-19 21:33:28',-59.8125631858,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(222,4,'2013-11-19 21:34:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(223,4,'2013-11-19 21:34:28',-90.4178251902,'Iberdrola Generación SA','Adeudo de Iberdrola'),(224,4,'2013-11-19 21:34:28',-14.7506156375,'Aguas de Valladolid','Adeudo de agua'),(225,4,'2013-11-19 21:34:28',-97.2402140285,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(226,4,'2013-11-19 21:35:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(227,4,'2013-11-19 21:35:28',-71.6527116689,'Iberdrola Generación SA','Adeudo de Iberdrola'),(228,4,'2013-11-19 21:35:28',-15.9487040282,'Aguas de Valladolid','Adeudo de agua'),(229,4,'2013-11-19 21:35:28',-93.7386515377,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(230,4,'2013-11-19 21:36:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(231,4,'2013-11-19 21:36:28',-85.7931740347,'Iberdrola Generación SA','Adeudo de Iberdrola'),(232,4,'2013-11-19 21:36:28',-12.2950059267,'Aguas de Valladolid','Adeudo de agua'),(233,4,'2013-11-19 21:36:28',-100.3694882802,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(234,4,'2013-11-19 21:37:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(235,4,'2013-11-19 21:37:28',-68.2026623003,'Iberdrola Generación SA','Adeudo de Iberdrola'),(236,4,'2013-11-19 21:37:28',-10.6660178919,'Aguas de Valladolid','Adeudo de agua'),(237,4,'2013-11-19 21:37:28',-98.9241411890,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(238,4,'2013-11-19 21:38:28',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(239,4,'2013-11-19 21:38:28',-74.2822217382,'Iberdrola Generación SA','Adeudo de Iberdrola'),(240,4,'2013-11-19 21:38:28',-14.7090212188,'Aguas de Valladolid','Adeudo de agua'),(241,4,'2013-11-19 21:38:28',-85.7665918702,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(242,4,'2013-11-21 18:09:53',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(243,4,'2013-11-21 18:09:53',-79.5641935197,'Iberdrola Generación SA','Adeudo de Iberdrola'),(244,4,'2013-11-21 18:09:53',-15.6619416013,'Aguas de Valladolid','Adeudo de agua'),(245,4,'2013-11-21 18:09:53',-50.7250185779,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(246,4,'2013-11-21 18:10:53',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(247,4,'2013-11-21 18:10:53',-90.4177641251,'Iberdrola Generación SA','Adeudo de Iberdrola'),(248,4,'2013-11-21 18:10:53',-13.5070006198,'Aguas de Valladolid','Adeudo de agua'),(249,4,'2013-11-21 18:10:53',-52.9926774014,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(250,4,'2013-11-21 18:11:53',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(251,4,'2013-11-21 18:11:53',-68.2374827047,'Iberdrola Generación SA','Adeudo de Iberdrola'),(252,4,'2013-11-21 18:11:53',-10.8018914337,'Aguas de Valladolid','Adeudo de agua'),(253,4,'2013-11-21 18:11:53',-79.7538425076,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(254,4,'2013-11-21 18:12:53',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(255,4,'2013-11-21 18:12:53',-71.4829722808,'Iberdrola Generación SA','Adeudo de Iberdrola'),(256,4,'2013-11-21 18:12:53',-16.9379254227,'Aguas de Valladolid','Adeudo de agua'),(257,4,'2013-11-21 18:12:53',-94.0251180636,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(258,4,'2013-11-21 18:13:53',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(259,4,'2013-11-21 18:13:53',-87.5345307785,'Iberdrola Generación SA','Adeudo de Iberdrola'),(260,4,'2013-11-21 18:13:53',-11.7449868783,'Aguas de Valladolid','Adeudo de agua'),(261,4,'2013-11-21 18:13:53',-67.2396097765,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(262,4,'2013-11-21 18:14:53',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(263,4,'2013-11-21 18:14:53',-73.1573583993,'Iberdrola Generación SA','Adeudo de Iberdrola'),(264,4,'2013-11-21 18:14:53',-18.7002994285,'Aguas de Valladolid','Adeudo de agua'),(265,4,'2013-11-21 18:14:53',-81.7622885405,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(266,4,'2013-11-21 18:15:53',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(267,4,'2013-11-21 18:15:53',-70.5768089241,'Iberdrola Generación SA','Adeudo de Iberdrola'),(268,4,'2013-11-21 18:15:53',-12.8768983285,'Aguas de Valladolid','Adeudo de agua'),(269,4,'2013-11-21 18:15:53',-58.8346821270,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(270,4,'2013-11-21 18:16:53',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(271,4,'2013-11-21 18:16:53',-77.8880368804,'Iberdrola Generación SA','Adeudo de Iberdrola'),(272,4,'2013-11-21 18:16:53',-19.4722874071,'Aguas de Valladolid','Adeudo de agua'),(273,4,'2013-11-21 18:16:53',-57.3922814278,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(274,4,'2013-11-21 18:17:53',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(275,4,'2013-11-21 18:17:53',-63.8951959502,'Iberdrola Generación SA','Adeudo de Iberdrola'),(276,4,'2013-11-21 18:17:53',-13.2124941882,'Aguas de Valladolid','Adeudo de agua'),(277,4,'2013-11-21 18:17:53',-94.9366677782,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(278,4,'2013-11-21 18:18:53',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(279,4,'2013-11-21 18:18:53',-85.1654366397,'Iberdrola Generación SA','Adeudo de Iberdrola'),(280,4,'2013-11-21 18:18:53',-17.7771165244,'Aguas de Valladolid','Adeudo de agua'),(281,4,'2013-11-21 18:18:53',-66.4701088422,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(282,4,'2013-11-21 18:19:53',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(283,4,'2013-11-21 18:19:53',-67.4172962013,'Iberdrola Generación SA','Adeudo de Iberdrola'),(284,4,'2013-11-21 18:19:53',-12.2832448316,'Aguas de Valladolid','Adeudo de agua'),(285,4,'2013-11-21 18:19:53',-76.2663634201,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(286,4,'2013-11-21 18:20:53',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(287,4,'2013-11-21 18:20:53',-89.1692564583,'Iberdrola Generación SA','Adeudo de Iberdrola'),(288,4,'2013-11-21 18:20:53',-20.2835331617,'Aguas de Valladolid','Adeudo de agua'),(289,4,'2013-11-21 18:20:53',-84.4754474025,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(290,4,'2013-11-21 18:21:53',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(291,4,'2013-11-21 18:21:53',-66.4251652204,'Iberdrola Generación SA','Adeudo de Iberdrola'),(292,4,'2013-11-21 18:21:53',-19.8813063375,'Aguas de Valladolid','Adeudo de agua'),(293,4,'2013-11-21 18:21:53',-89.3322642227,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(294,4,'2013-11-21 18:22:53',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(295,4,'2013-11-21 18:22:53',-72.2637524303,'Iberdrola Generación SA','Adeudo de Iberdrola'),(296,4,'2013-11-21 18:22:53',-14.9914010040,'Aguas de Valladolid','Adeudo de agua'),(297,4,'2013-11-21 18:22:53',-96.2413925577,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(298,4,'2013-11-21 18:23:53',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(299,4,'2013-11-21 18:23:53',-87.0808751225,'Iberdrola Generación SA','Adeudo de Iberdrola'),(300,4,'2013-11-21 18:23:53',-16.2656399313,'Aguas de Valladolid','Adeudo de agua'),(301,4,'2013-11-21 18:23:53',-61.4158593204,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(302,4,'2013-11-21 18:24:53',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(303,4,'2013-11-21 18:24:53',-88.5089198094,'Iberdrola Generación SA','Adeudo de Iberdrola'),(304,4,'2013-11-21 18:24:53',-19.9430781048,'Aguas de Valladolid','Adeudo de agua'),(305,4,'2013-11-21 18:24:53',-73.2939530719,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(306,4,'2013-11-21 18:25:53',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(307,4,'2013-11-21 18:25:53',-89.4255456809,'Iberdrola Generación SA','Adeudo de Iberdrola'),(308,4,'2013-11-21 18:25:53',-11.8219153314,'Aguas de Valladolid','Adeudo de agua'),(309,4,'2013-11-21 18:25:53',-76.9142694258,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(310,4,'2013-11-21 18:26:53',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(311,4,'2013-11-21 18:26:53',-65.7415750133,'Iberdrola Generación SA','Adeudo de Iberdrola'),(312,4,'2013-11-21 18:26:53',-16.9571113610,'Aguas de Valladolid','Adeudo de agua'),(313,4,'2013-11-21 18:26:53',-75.0529319743,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(314,4,'2013-11-21 18:27:53',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(315,4,'2013-11-21 18:27:53',-88.2862182138,'Iberdrola Generación SA','Adeudo de Iberdrola'),(316,4,'2013-11-21 18:27:53',-12.7116360092,'Aguas de Valladolid','Adeudo de agua'),(317,4,'2013-11-21 18:27:53',-87.1650621469,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(318,4,'2013-11-21 18:28:53',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(319,4,'2013-11-21 18:28:53',-69.8475184206,'Iberdrola Generación SA','Adeudo de Iberdrola'),(320,4,'2013-11-21 18:28:53',-15.9244970093,'Aguas de Valladolid','Adeudo de agua'),(321,4,'2013-11-21 18:28:53',-83.5146343158,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(322,4,'2013-11-21 18:29:53',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(323,4,'2013-11-21 18:29:53',-63.7357509532,'Iberdrola Generación SA','Adeudo de Iberdrola'),(324,4,'2013-11-21 18:29:53',-17.1810986176,'Aguas de Valladolid','Adeudo de agua'),(325,4,'2013-11-21 18:29:53',-73.4181296891,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(326,4,'2013-11-21 18:30:53',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(327,4,'2013-11-21 18:30:53',-70.2363451854,'Iberdrola Generación SA','Adeudo de Iberdrola'),(328,4,'2013-11-21 18:30:53',-17.3620333133,'Aguas de Valladolid','Adeudo de agua'),(329,4,'2013-11-21 18:30:53',-60.2210173724,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(330,4,'2013-11-21 18:31:53',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(331,4,'2013-11-21 18:31:53',-72.8590270865,'Iberdrola Generación SA','Adeudo de Iberdrola'),(332,4,'2013-11-21 18:31:53',-13.6617447694,'Aguas de Valladolid','Adeudo de agua'),(333,4,'2013-11-21 18:31:53',-88.6136163942,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(334,4,'2013-11-21 18:32:53',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(335,4,'2013-11-21 18:32:53',-62.0472462009,'Iberdrola Generación SA','Adeudo de Iberdrola'),(336,4,'2013-11-21 18:32:53',-18.7281068217,'Aguas de Valladolid','Adeudo de agua'),(337,4,'2013-11-21 18:32:53',-53.0771942284,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(338,4,'2013-11-21 18:33:53',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(339,4,'2013-11-21 18:33:53',-70.5637030442,'Iberdrola Generación SA','Adeudo de Iberdrola'),(340,4,'2013-11-21 18:33:53',-13.7538659743,'Aguas de Valladolid','Adeudo de agua'),(341,4,'2013-11-21 18:33:53',-81.0677353655,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(342,4,'2013-11-21 18:34:53',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(343,4,'2013-11-21 18:34:53',-88.4011438226,'Iberdrola Generación SA','Adeudo de Iberdrola'),(344,4,'2013-11-21 18:34:53',-20.2199629841,'Aguas de Valladolid','Adeudo de agua'),(345,4,'2013-11-21 18:34:53',-58.0618239482,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(346,4,'2013-11-22 16:43:08',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(347,3,'2013-11-22 16:43:08',570.0000000000,'Juan Benito','Ingreso en efectivo'),(348,1,'2013-11-22 16:43:08',33.5086400000,'Banco bueno','Abono intereses'),(349,2,'2013-11-22 16:43:08',119.7218200000,'Banco bueno','Abono intereses'),(350,4,'2013-11-22 16:43:08',-75.2742829065,'Iberdrola Generación SA','Adeudo de Iberdrola'),(351,3,'2013-11-22 16:43:08',705.3750000000,'Banco bueno','Abono intereses'),(352,4,'2013-11-22 16:43:08',1773.3673704573,'Banco bueno','Abono intereses'),(353,4,'2013-11-22 16:43:08',-19.4569083446,'Aguas de Valladolid','Adeudo de agua'),(354,4,'2013-11-22 16:43:08',-92.9015779839,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(355,3,'2013-11-22 16:43:16',570.0000000000,'Juan Benito','Ingreso en efectivo'),(356,4,'2013-11-22 16:43:16',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(357,1,'2013-11-22 16:43:16',33.5086400000,'Banco bueno','Abono intereses'),(358,2,'2013-11-22 16:43:16',119.7218200000,'Banco bueno','Abono intereses'),(359,3,'2013-11-22 16:43:16',726.7500000000,'Banco bueno','Abono intereses'),(360,4,'2013-11-22 16:43:16',1790.1083313805,'Banco bueno','Abono intereses'),(361,4,'2013-11-22 16:43:16',-83.6763540212,'Iberdrola Generación SA','Adeudo de Iberdrola'),(362,4,'2013-11-22 16:43:16',-15.4679538974,'Aguas de Valladolid','Adeudo de agua'),(363,4,'2013-11-22 16:43:16',-51.2824123658,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(364,4,'2013-11-22 17:30:07',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(365,4,'2013-11-22 17:30:07',-83.8568507360,'Iberdrola Generación SA','Adeudo de Iberdrola'),(366,4,'2013-11-22 17:30:07',-13.7441569462,'Aguas de Valladolid','Adeudo de agua'),(367,4,'2013-11-22 17:30:07',-72.0217475992,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(368,3,'2013-11-22 17:30:12',570.0000000000,'Juan Benito','Ingreso en efectivo'),(369,1,'2013-11-22 17:31:47',2.7975060422,'Banco bueno','Abono intereses'),(370,2,'2013-11-22 17:31:47',10.0050859852,'Banco bueno','Abono intereses'),(371,3,'2013-11-22 17:31:47',64.3198242187,'Banco bueno','Abono intereses'),(372,4,'2013-11-22 17:31:47',152.1405463529,'Banco bueno','Abono intereses'),(373,4,'2013-11-22 17:31:52',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(374,4,'2013-11-22 17:31:52',-75.5555547131,'Iberdrola Generación SA','Adeudo de Iberdrola'),(375,4,'2013-11-22 17:31:52',-15.3035047691,'Aguas de Valladolid','Adeudo de agua'),(376,4,'2013-11-22 17:31:52',-59.7516716251,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(377,3,'2013-11-22 17:31:57',570.0000000000,'Juan Benito','Ingreso en efectivo'),(378,1,'2013-11-22 17:41:47',2.8026348032,'Banco bueno','Abono intereses'),(379,2,'2013-11-22 17:41:47',10.0334337289,'Banco bueno','Abono intereses'),(380,3,'2013-11-22 17:41:47',66.3020736694,'Banco bueno','Abono intereses'),(381,4,'2013-11-22 17:41:47',153.7466770282,'Banco bueno','Abono intereses'),(382,1,'2013-11-22 17:45:16',2.8077729671,'Banco bueno','Abono intereses'),(383,2,'2013-11-22 17:45:16',10.0618617911,'Banco bueno','Abono intereses'),(384,3,'2013-11-22 17:45:16',66.5092676496,'Banco bueno','Abono intereses'),(385,4,'2013-11-22 17:45:16',154.0285459361,'Banco bueno','Abono intereses'),(386,4,'2013-11-22 17:45:21',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(387,4,'2013-11-22 17:45:21',-68.7253794771,'Iberdrola Generación SA','Adeudo de Iberdrola'),(388,4,'2013-11-22 17:45:21',-11.2721300835,'Aguas de Valladolid','Adeudo de agua'),(389,4,'2013-11-22 17:45:21',-86.4406749128,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(390,3,'2013-11-22 17:45:26',570.0000000000,'Juan Benito','Ingreso en efectivo'),(391,1,'2013-11-22 17:49:58',2.8129205508,'Banco bueno','Abono intereses'),(392,2,'2013-11-22 17:49:58',10.0903703995,'Banco bueno','Abono intereses'),(393,3,'2013-11-22 17:49:58',68.4983591110,'Banco bueno','Abono intereses'),(394,4,'2013-11-22 17:49:58',155.6671549418,'Banco bueno','Abono intereses'),(395,4,'2013-11-22 17:50:02',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(396,4,'2013-11-22 17:50:02',-64.7772400192,'Iberdrola Generación SA','Adeudo de Iberdrola'),(397,4,'2013-11-22 17:50:02',-16.7366815421,'Aguas de Valladolid','Adeudo de agua'),(398,4,'2013-11-22 17:50:02',-73.0054182160,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(399,3,'2013-11-22 17:50:07',570.0000000000,'Juan Benito','Ingreso en efectivo'),(400,1,'2013-11-22 17:53:35',2.8180775718,'Banco bueno','Abono intereses'),(401,2,'2013-11-22 17:53:35',10.1189597823,'Banco bueno','Abono intereses'),(402,3,'2013-11-22 17:53:35',70.4936664832,'Banco bueno','Abono intereses'),(403,4,'2013-11-22 17:53:35',157.2869168488,'Banco bueno','Abono intereses'),(404,4,'2013-11-22 17:53:40',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(405,4,'2013-11-22 17:53:40',-60.1409363157,'Iberdrola Generación SA','Adeudo de Iberdrola'),(406,4,'2013-11-22 17:53:40',-20.3363879041,'Aguas de Valladolid','Adeudo de agua'),(407,4,'2013-11-22 17:53:40',-52.9025116527,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(408,3,'2013-11-22 17:53:45',570.0000000000,'Juan Benito','Ingreso en efectivo'),(409,1,'2013-11-22 17:54:35',2.8232440474,'Banco bueno','Abono intereses'),(410,2,'2013-11-22 17:54:35',10.1476301683,'Banco bueno','Abono intereses'),(411,3,'2013-11-22 17:54:35',72.4952091910,'Banco bueno','Abono intereses'),(412,4,'2013-11-22 17:54:35',158.8708925621,'Banco bueno','Abono intereses'),(413,1,'2013-11-22 17:55:07',2.8284199948,'Banco bueno','Abono intereses'),(414,2,'2013-11-22 17:55:07',10.1763817872,'Banco bueno','Abono intereses'),(415,3,'2013-11-22 17:55:07',72.7217567197,'Banco bueno','Abono intereses'),(416,4,'2013-11-22 17:55:07',159.1621558652,'Banco bueno','Abono intereses'),(417,4,'2013-11-22 17:55:12',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(418,4,'2013-11-22 17:55:12',-68.2982994254,'Iberdrola Generación SA','Adeudo de Iberdrola'),(419,4,'2013-11-22 17:55:12',-12.2752038433,'Aguas de Valladolid','Adeudo de agua'),(420,4,'2013-11-22 17:55:12',-74.4122126413,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(421,3,'2013-11-22 17:55:17',570.0000000000,'Juan Benito','Ingreso en efectivo'),(422,1,'2013-11-22 18:05:07',2.8336054315,'Banco bueno','Abono intereses'),(423,2,'2013-11-22 18:05:07',10.2052148689,'Banco bueno','Abono intereses'),(424,3,'2013-11-22 18:05:07',74.7302622095,'Banco bueno','Abono intereses'),(425,4,'2013-11-22 18:05:07',160.7891802968,'Banco bueno','Abono intereses'),(426,4,'2013-11-22 18:05:12',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(427,4,'2013-11-22 18:05:12',-69.8879950022,'Iberdrola Generación SA','Adeudo de Iberdrola'),(428,4,'2013-11-22 18:05:12',-14.9106178052,'Aguas de Valladolid','Adeudo de agua'),(429,4,'2013-11-22 18:05:12',-75.9471760311,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(430,3,'2013-11-22 18:05:17',570.0000000000,'Juan Benito','Ingreso en efectivo'),(431,1,'2013-11-22 18:15:07',2.8388003748,'Banco bueno','Abono intereses'),(432,2,'2013-11-22 18:15:07',10.2341296443,'Banco bueno','Abono intereses'),(433,3,'2013-11-22 18:15:07',76.7450442789,'Banco bueno','Abono intereses'),(434,4,'2013-11-22 18:15:07',162.4297477402,'Banco bueno','Abono intereses'),(435,4,'2013-11-22 18:15:12',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(436,4,'2013-11-22 18:15:12',-72.3460223088,'Iberdrola Generación SA','Adeudo de Iberdrola'),(437,4,'2013-11-22 18:15:12',-16.7251270131,'Aguas de Valladolid','Adeudo de agua'),(438,4,'2013-11-22 18:15:12',-92.4786127554,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(439,3,'2013-11-22 18:15:17',570.0000000000,'Juan Benito','Ingreso en efectivo'),(440,1,'2013-11-22 18:17:53',2.8440048421,'Banco bueno','Abono intereses'),(441,2,'2013-11-22 18:17:53',10.2631263450,'Banco bueno','Abono intereses'),(442,3,'2013-11-22 18:17:53',78.7661225422,'Banco bueno','Abono intereses'),(443,4,'2013-11-22 18:17:53',164.1114635082,'Banco bueno','Abono intereses'),(444,4,'2013-11-22 18:17:56',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(445,4,'2013-11-22 18:17:56',-88.0033948923,'Iberdrola Generación SA','Adeudo de Iberdrola'),(446,4,'2013-11-22 18:17:56',-18.1237812348,'Aguas de Valladolid','Adeudo de agua'),(447,4,'2013-11-22 18:17:56',-88.4863201156,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(448,3,'2013-11-22 18:18:02',570.0000000000,'Juan Benito','Ingreso en efectivo'),(449,1,'2013-11-22 18:27:53',2.8492188510,'Banco bueno','Abono intereses'),(450,2,'2013-11-22 18:27:53',10.2922052030,'Banco bueno','Abono intereses'),(451,3,'2013-11-22 18:27:53',80.7935166752,'Banco bueno','Abono intereses'),(452,4,'2013-11-22 18:27:53',165.8202126010,'Banco bueno','Abono intereses'),(453,4,'2013-11-22 18:27:56',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(454,4,'2013-11-22 18:27:56',-81.0194295591,'Iberdrola Generación SA','Adeudo de Iberdrola'),(455,4,'2013-11-22 18:27:56',-12.7996808459,'Aguas de Valladolid','Adeudo de agua'),(456,4,'2013-11-22 18:27:56',-98.1830944833,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(457,3,'2013-11-22 18:28:02',570.0000000000,'Juan Benito','Ingreso en efectivo'),(458,1,'2013-11-26 19:35:32',2.8544424189,'Banco bueno','Abono intereses'),(459,2,'2013-11-26 19:35:32',10.3213664511,'Banco bueno','Abono intereses'),(460,3,'2013-11-26 19:35:32',82.8272464148,'Banco bueno','Abono intereses'),(461,4,'2013-11-26 19:35:32',167.5273070331,'Banco bueno','Abono intereses'),(462,4,'2013-11-26 19:35:35',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(463,4,'2013-11-26 19:35:35',-60.1921289630,'Iberdrola Generación SA','Adeudo de Iberdrola'),(464,4,'2013-11-26 19:35:35',-18.8480004703,'Aguas de Valladolid','Adeudo de agua'),(465,4,'2013-11-26 19:35:35',-100.1499946310,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(466,3,'2013-11-26 19:35:41',570.0000000000,'Juan Benito','Ingreso en efectivo'),(467,1,'2013-11-26 20:34:16',2.8596755633,'Banco bueno','Abono intereses'),(468,2,'2013-11-26 20:34:16',10.3506103227,'Banco bueno','Abono intereses'),(469,3,'2013-11-26 20:34:16',84.8673315598,'Banco bueno','Abono intereses'),(470,4,'2013-11-26 20:34:16',169.2140423235,'Banco bueno','Abono intereses'),(471,4,'2013-11-26 20:34:18',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(472,4,'2013-11-26 20:34:18',-75.7340663167,'Iberdrola Generación SA','Adeudo de Iberdrola'),(473,4,'2013-11-26 20:34:18',-20.9518344559,'Aguas de Valladolid','Adeudo de agua'),(474,4,'2013-11-26 20:34:18',-76.0018648224,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(475,3,'2013-11-26 20:34:24',570.0000000000,'Juan Benito','Ingreso en efectivo'),(476,1,'2013-11-26 20:35:54',2.8649183018,'Banco bueno','Abono intereses'),(477,2,'2013-11-26 20:35:54',10.3799370519,'Banco bueno','Abono intereses'),(478,3,'2013-11-26 20:35:54',86.9137919710,'Banco bueno','Abono intereses'),(479,4,'2013-11-26 20:35:54',170.8919489713,'Banco bueno','Abono intereses'),(480,4,'2013-11-26 20:35:57',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(481,4,'2013-11-26 20:35:57',-61.7750753755,'Iberdrola Generación SA','Adeudo de Iberdrola'),(482,4,'2013-11-26 20:35:57',-12.4135992740,'Aguas de Valladolid','Adeudo de agua'),(483,4,'2013-11-26 20:35:57',-54.1912334250,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(484,3,'2013-11-26 20:36:03',570.0000000000,'Juan Benito','Ingreso en efectivo'),(485,1,'2013-11-26 20:45:54',2.8701706521,'Banco bueno','Abono intereses'),(486,2,'2013-11-26 20:45:54',10.4093468736,'Banco bueno','Abono intereses'),(487,3,'2013-11-26 20:45:54',88.9666475709,'Banco bueno','Abono intereses'),(488,4,'2013-11-26 20:45:54',172.4917007092,'Banco bueno','Abono intereses'),(489,4,'2013-11-26 20:45:57',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(490,4,'2013-11-26 20:45:57',-82.0981071985,'Iberdrola Generación SA','Adeudo de Iberdrola'),(491,4,'2013-11-26 20:45:57',-11.3882072409,'Aguas de Valladolid','Adeudo de agua'),(492,4,'2013-11-26 20:45:57',-82.7239753496,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(493,3,'2013-11-26 20:46:03',570.0000000000,'Juan Benito','Ingreso en efectivo'),(494,1,'2013-11-26 20:55:54',2.8754326316,'Banco bueno','Abono intereses'),(495,2,'2013-11-26 20:55:54',10.4388400230,'Banco bueno','Abono intereses'),(496,3,'2013-11-26 20:55:54',91.0259183445,'Banco bueno','Abono intereses'),(497,4,'2013-11-26 20:55:54',174.1820743585,'Banco bueno','Abono intereses'),(498,4,'2013-11-26 20:55:57',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(499,4,'2013-11-26 20:55:57',-88.9013696445,'Iberdrola Generación SA','Adeudo de Iberdrola'),(500,4,'2013-11-26 20:55:57',-13.7358066844,'Aguas de Valladolid','Adeudo de agua'),(501,4,'2013-11-26 20:55:57',-71.9749083903,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(502,3,'2013-11-26 20:56:03',570.0000000000,'Juan Benito','Ingreso en efectivo'),(503,1,'2013-11-26 21:09:22',2.8807042581,'Banco bueno','Abono intereses'),(504,2,'2013-11-26 21:09:22',10.4684167364,'Banco bueno','Abono intereses'),(505,3,'2013-11-26 21:09:22',93.0916243394,'Banco bueno','Abono intereses'),(506,4,'2013-11-26 21:09:22',175.8726169834,'Banco bueno','Abono intereses'),(507,4,'2013-11-26 21:09:25',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(508,4,'2013-11-26 21:09:25',-76.6015927566,'Iberdrola Generación SA','Adeudo de Iberdrola'),(509,4,'2013-11-26 21:09:25',-20.3121244492,'Aguas de Valladolid','Adeudo de agua'),(510,4,'2013-11-26 21:09:25',-70.2153161403,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(511,3,'2013-11-26 21:09:31',570.0000000000,'Juan Benito','Ingreso en efectivo'),(512,1,'2013-11-26 21:19:22',2.8859855492,'Banco bueno','Abono intereses'),(513,2,'2013-11-26 21:19:22',10.4980772505,'Banco bueno','Abono intereses'),(514,3,'2013-11-26 21:19:22',95.1637856654,'Banco bueno','Abono intereses'),(515,4,'2013-11-26 21:19:22',177.5525400091,'Banco bueno','Abono intereses'),(516,4,'2013-11-26 21:19:25',573.3200000000,'Servicio Público de Empleo Estatal','Prestación por desempleo'),(517,4,'2013-11-26 21:19:25',-72.9172230485,'Iberdrola Generación SA','Adeudo de Iberdrola'),(518,4,'2013-11-26 21:19:25',-16.1866086367,'Aguas de Valladolid','Adeudo de agua'),(519,4,'2013-11-26 21:19:25',-81.1993915235,'Gas Natural SDG SA','Adeudo de Gas Natural Fenosa'),(520,3,'2013-11-26 21:19:31',570.0000000000,'Juan Benito','Ingreso en efectivo');
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-02-11 20:05:01
