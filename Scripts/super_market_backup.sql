-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: super_market
-- ------------------------------------------------------
-- Server version	9.7.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '6c77391e-511d-11f1-bb3b-dc1ba1c687ab:1-981';

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add category',7,'add_category'),(26,'Can change category',7,'change_category'),(27,'Can delete category',7,'delete_category'),(28,'Can view category',7,'view_category'),(29,'Can add customer',8,'add_customer'),(30,'Can change customer',8,'change_customer'),(31,'Can delete customer',8,'delete_customer'),(32,'Can view customer',8,'view_customer'),(33,'Can add product',9,'add_product'),(34,'Can change product',9,'change_product'),(35,'Can delete product',9,'delete_product'),(36,'Can view product',9,'view_product'),(37,'Can add product permission',10,'add_productpermission'),(38,'Can change product permission',10,'change_productpermission'),(39,'Can delete product permission',10,'delete_productpermission'),(40,'Can view product permission',10,'view_productpermission'),(41,'Can add bill',11,'add_bill'),(42,'Can change bill',11,'change_bill'),(43,'Can delete bill',11,'delete_bill'),(44,'Can view bill',11,'view_bill'),(45,'Can add bill item',12,'add_billitem'),(46,'Can change bill item',12,'change_billitem'),(47,'Can delete bill item',12,'delete_billitem'),(48,'Can view bill item',12,'view_billitem'),(49,'Can add hero image',13,'add_heroimage'),(50,'Can change hero image',13,'change_heroimage'),(51,'Can delete hero image',13,'delete_heroimage'),(52,'Can view hero image',13,'view_heroimage'),(53,'Can add customer login',14,'add_customerlogin'),(54,'Can change customer login',14,'change_customerlogin'),(55,'Can delete customer login',14,'delete_customerlogin'),(56,'Can view customer login',14,'view_customerlogin');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$600000$igJ2zLpq4Io27dIkZ6Nh9y$OTDqxa3Sx5dr8M+v5XeshR/Yb7KIBem6wechuJ928NY=',NULL,0,'user1','','','',0,1,'2026-05-17 10:08:44.205205'),(3,'pbkdf2_sha256$600000$380ZvZFZUKWVOcp6OkSreX$OPy2nBu85Dtb8fQfMaNBFlcIipfGzMotOA7CeHlmSqs=','2026-05-22 19:02:49.777614',0,'usernew','','','',0,1,'2026-05-17 10:09:52.022567'),(4,'pbkdf2_sha256$600000$gGdbPf9FNZn59GPCdPjLJP$4RtSK+f3UUOynK+CiotOeZPsVA0jm/qPwhUB9kSxbgs=','2026-05-24 15:28:23.780582',1,'deluxmartowner56','','','avranildas698@gmail.com',1,1,'2026-05-17 10:34:48.526189'),(5,'pbkdf2_sha256$600000$EXUSxgOj4U1G8Lku8eRGDD$JmRY4tHCqRZME4rf+DoyFwyW9/8CK/KkDjImu55lMk8=','2026-05-20 16:02:57.547365',0,'user101','','','',0,1,'2026-05-19 16:11:10.937171'),(6,'pbkdf2_sha256$600000$hdISMnCheb7PLmVTf5niXL$Pp8QgwCyaIK5FFfphhDags/fcYVfbQUN1qyik9l5wTE=',NULL,0,'user202','','','',0,1,'2026-05-19 16:14:10.103090'),(7,'pbkdf2_sha256$600000$0Egg63jT6l8tcc92HTx6St$9wlFK7UbCXICCp25mPCR7MVIznScp4RbaPe3i/V9Y1Q=','2026-05-19 16:21:48.025536',0,'user303','','','',0,1,'2026-05-19 16:14:55.195060'),(8,'pbkdf2_sha256$600000$WHfDNJHCgTCQT4W0C1TOBG$DP3a3lAHJQgWZ7WrSYuFnEhnaxYw+z+FTseh6n9SgmQ=',NULL,0,'user404','','','',0,1,'2026-05-19 16:15:38.075123'),(9,'pbkdf2_sha256$600000$qwoJAiu63AcOM3RRcZEqst$HwtjQHe+vkcy/HnekUUnxX6P1nu9PLB+EkN+NSskwjY=',NULL,0,'user505','','','',0,1,'2026-05-19 16:16:42.995198'),(10,'pbkdf2_sha256$600000$6JZWvtMPcqsqmNtKABZiUM$H6urcEqUhk5BDO+FjL4Sz8UzVEmuXz7zYYgf8cJTYKY=',NULL,0,'user666','','','',0,1,'2026-05-19 16:18:20.772813'),(11,'pbkdf2_sha256$600000$P9WF3nvzaVT9KSjguQTnhG$t1MkW6qIymYH6xpSYVqsWfLrfvSCOFf2JXzokXQl4fc=',NULL,0,'user707','','','',0,1,'2026-05-19 16:19:26.163563'),(12,'pbkdf2_sha256$600000$lxcVPsqJ1WObFAYomPHYwp$ANltR2b2UGvVTNyKX18/AETtnVugKjvOr8R0H6eQYSM=',NULL,0,'user808','','','',0,1,'2026-05-19 16:20:38.601544'),(13,'pbkdf2_sha256$600000$gN0Zha99VwNUO4U07HH5IM$zB0wNnOWiXTfW/BZJEC+fcNIOqnuAS9MQoQfD3o6KPc=',NULL,0,'user909','','','',0,1,'2026-05-19 16:21:21.611414');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bill`
--

DROP TABLE IF EXISTS `bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill` (
  `bill_id` int NOT NULL AUTO_INCREMENT,
  `bill_number` varchar(20) NOT NULL,
  `bill_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `customer_id` int NOT NULL,
  `total_amount` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`bill_id`),
  UNIQUE KEY `bill_number` (`bill_number`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `bill_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill`
--

LOCK TABLES `bill` WRITE;
/*!40000 ALTER TABLE `bill` DISABLE KEYS */;
INSERT INTO `bill` VALUES (1,'INV-20260517-0001','2026-05-17 10:11:46',10,360.00),(3,'INV-20260518-0001','2026-05-18 15:20:13',10,110.00),(4,'INV-20260518-0002','2026-05-18 16:28:56',10,170.00);
/*!40000 ALTER TABLE `bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `billitem`
--

DROP TABLE IF EXISTS `billitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billitem` (
  `bill_item_id` int NOT NULL AUTO_INCREMENT,
  `bill_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `price_at_time` decimal(10,2) NOT NULL,
  PRIMARY KEY (`bill_item_id`),
  KEY `bill_id` (`bill_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `billitem_ibfk_1` FOREIGN KEY (`bill_id`) REFERENCES `bill` (`bill_id`),
  CONSTRAINT `billitem_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billitem`
--

LOCK TABLES `billitem` WRITE;
/*!40000 ALTER TABLE `billitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `billitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_name` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (25,'Accessories'),(21,'Alcohol & Tobacco'),(22,'Baby Products'),(30,'Bakery'),(32,'Dairy Extracts'),(31,'Drinks & Beverages'),(33,'Electronic Appliances'),(44,'Fashion & Personal Apparel'),(28,'Foot wear'),(34,'Fresh Produce'),(46,'Furniture & Home Decor'),(36,'Grocery'),(35,'Hardware Tools'),(37,'Health & Wellness'),(39,'Household Cleaning'),(42,'Kitchen Use'),(40,'Miscellaneous'),(24,'Personal Care & Grooming'),(29,'Pet Supplies'),(26,'Sex Health Care'),(47,'Snacks & Fillers'),(45,'Sports, Games & Toys'),(43,'Stationery');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(50) NOT NULL,
  `customer_age` int NOT NULL,
  `customer_sex` enum('M','F','Q') NOT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Avranil',16,'M',NULL),(2,'Devanshi',14,'F',NULL),(3,'Addri',25,'M',NULL),(4,'Subhashis',32,'M',NULL),(5,'Sandhya',23,'F',NULL),(6,'Arghya',69,'Q',NULL),(7,'Neha',35,'F',NULL),(8,'Choudhary',26,'Q',NULL),(9,'Subhashis Sen',15,'M',1),(10,'NEW USER',69,'Q',3),(11,'Subashish Sen',15,'M',5),(12,'Neha Jana',17,'F',6),(13,'Avranil Das',26,'M',7),(14,'Devanshi Bag',24,'F',8),(15,'Choudhary Dam',96,'Q',9),(16,'Arg Gsh',69,'Q',10),(17,'Addri Sharma',27,'M',11),(18,'Abhijeet Nair',16,'M',12),(19,'Sandhya Sethi',26,'F',13);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_login`
--

DROP TABLE IF EXISTS `customer_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_login` (
  `login_id` int NOT NULL AUTO_INCREMENT,
  `login_time` datetime(6) NOT NULL,
  `customer_id` int NOT NULL,
  PRIMARY KEY (`login_id`),
  KEY `customer_login_customer_id_c3e4795a_fk_customer_customer_id` (`customer_id`),
  CONSTRAINT `customer_login_customer_id_c3e4795a_fk_customer_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_login`
--

LOCK TABLES `customer_login` WRITE;
/*!40000 ALTER TABLE `customer_login` DISABLE KEYS */;
INSERT INTO `customer_login` VALUES (1,'2026-05-22 19:02:49.913215',10);
/*!40000 ALTER TABLE `customer_login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session'),(11,'store','bill'),(12,'store','billitem'),(7,'store','category'),(8,'store','customer'),(14,'store','customerlogin'),(13,'store','heroimage'),(9,'store','product'),(10,'store','productpermission');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2026-05-16 17:46:52.632436'),(2,'auth','0001_initial','2026-05-16 17:46:53.699185'),(3,'admin','0001_initial','2026-05-16 17:46:53.974199'),(4,'admin','0002_logentry_remove_auto_add','2026-05-16 17:46:54.002359'),(5,'admin','0003_logentry_add_action_flag_choices','2026-05-16 17:46:54.024595'),(6,'contenttypes','0002_remove_content_type_name','2026-05-16 17:46:54.259627'),(7,'auth','0002_alter_permission_name_max_length','2026-05-16 17:46:54.389414'),(8,'auth','0003_alter_user_email_max_length','2026-05-16 17:46:54.444365'),(9,'auth','0004_alter_user_username_opts','2026-05-16 17:46:54.472003'),(10,'auth','0005_alter_user_last_login_null','2026-05-16 17:46:54.609459'),(11,'auth','0006_require_contenttypes_0002','2026-05-16 17:46:54.615574'),(12,'auth','0007_alter_validators_add_error_messages','2026-05-16 17:46:54.639288'),(13,'auth','0008_alter_user_username_max_length','2026-05-16 17:46:54.779650'),(14,'auth','0009_alter_user_last_name_max_length','2026-05-16 17:46:54.904608'),(15,'auth','0010_alter_group_name_max_length','2026-05-16 17:46:54.954230'),(16,'auth','0011_update_proxy_permissions','2026-05-16 17:46:54.984622'),(17,'auth','0012_alter_user_first_name_max_length','2026-05-16 17:46:55.109281'),(18,'sessions','0001_initial','2026-05-16 17:46:55.174591'),(19,'store','0001_initial','2026-05-16 19:09:27.488104'),(20,'store','0002_heroimage','2026-05-18 15:49:10.018575'),(21,'store','0003_customerlogin','2026-05-21 17:51:29.515162');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('i2983c9w5ybltgiaa3n739yze5mrubhg','.eJxVjEEOwiAQRe_C2hAGsAWX7nsGAsyMVA0kpV0Z765NutDtf-_9lwhxW0vYOi1hRnERVpx-txTzg-oO8B7rrcnc6rrMSe6KPGiXU0N6Xg_376DEXr41AxKrMSrr7Gi1RY5Gs00-QUZwDCkppMEbhnxmw95Rhsx-INDaoRbvD_8UOJU:1wRAkZ:G_tvFTTt7BncmbjW7vzv-n2WMTJgB5OMXtRrfCofsvk','2026-06-07 15:28:23.829408');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hero_image`
--

DROP TABLE IF EXISTS `hero_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hero_image` (
  `image_id` int NOT NULL AUTO_INCREMENT,
  `image` varchar(100) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `subtitle` varchar(200) DEFAULT NULL,
  `order` int NOT NULL,
  `uploaded_at` datetime(6) NOT NULL,
  PRIMARY KEY (`image_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hero_image`
--

LOCK TABLES `hero_image` WRITE;
/*!40000 ALTER TABLE `hero_image` DISABLE KEYS */;
INSERT INTO `hero_image` VALUES (3,'hero_images/hero_section_2.jpg','Brand new Deals on Men Shoes','',2,'2026-05-19 16:33:14.725309'),(6,'hero_images/hero_section_4.jpg','Fresh from Farm, Eat Healthy every day','',4,'2026-05-19 16:35:47.381702'),(7,'hero_images/hero_section_1.jpg','New Arrival, Designer Hand Bags','',4,'2026-05-19 16:47:45.168856'),(8,'hero_images/hero_section_3_rZuoW40.png','Ongoing Sales & Offers, Shop Now!','',4,'2026-05-19 18:06:50.813756');
/*!40000 ALTER TABLE `hero_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(50) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock_quantity` int NOT NULL,
  `allowed_gender` enum('M','F','ALL') DEFAULT 'ALL',
  `is_adult_only` tinyint(1) NOT NULL DEFAULT '0',
  `category_id` int NOT NULL,
  `product_sprite` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=184 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (16,'Whiskey Bottle',120.00,500,'ALL',1,21,'product_sprites/whiskey_bottle_sprite.png'),(17,'Beer Can',50.00,500,'ALL',1,21,'product_sprites/beer_can_sprite.png'),(18,'Baby Milk',130.00,500,'ALL',1,22,'product_sprites/baby_milk_bottle_sprite.png'),(22,'Cigar',250.00,500,'ALL',1,21,'product_sprites/cigar_sprite.png'),(23,'Cigarette',15.00,500,'ALL',1,21,'product_sprites/cigeratte_box_sprite.png'),(24,'Men Boots',760.00,500,'M',0,28,'product_sprites/men_boot_sprite_DBmXnqK.png'),(25,'Women Heel',1200.00,500,'F',0,28,'product_sprites/women_heel_sprite_pz6lgYZ.png'),(26,'Men Sneakers',720.00,500,'M',0,28,'product_sprites/men_sneakers_sprite.png'),(27,'Men Razor',65.00,500,'M',0,24,'product_sprites/men_razor_sprite.png'),(28,'Men Deodrant',110.00,500,'M',0,24,'product_sprites/men_deodrant_sprite.png'),(29,'Baby Dress',780.00,500,'ALL',1,22,'product_sprites/baby_dress_sprite.png'),(30,'Baby Pacifier',120.00,500,'ALL',1,22,'product_sprites/baby_pacifier_sprite.png'),(31,'Men Backpack ',820.00,500,'M',0,25,'product_sprites/men_backpack_sprite.png'),(32,'Men Hairgel',105.00,500,'M',0,24,'product_sprites/men_hairgel_sprite.png'),(33,'Men Condom',30.00,500,'M',1,26,'product_sprites/men_condom_sprite.png'),(34,'Men Lubricant',110.00,500,'M',1,26,'product_sprites/men_lubricant_sprite.png'),(41,'Baby Diapers',250.00,500,'ALL',1,22,'product_sprites/baby_diaper_sprite.png'),(42,'Women Contraceptive Pill',250.00,500,'F',1,26,'product_sprites/women_contraceptive_pill_sprite.png'),(43,'Women Pregnancy Testkit',75.00,500,'F',1,26,'product_sprites/women_pregnancy_kit_sprite.png'),(45,'Women Flat Sandal',860.00,500,'F',0,28,'product_sprites/women_flat_sandal_sprite_qqLuhdA.png'),(46,'Women Lipstick',115.00,500,'F',0,24,'product_sprites/women_lipstick_sprite.png'),(47,'Women Perfume',320.00,500,'F',0,24,'product_sprites/women_perfume_sprite_cVDSYwq.png'),(48,'Women Pendant',6800.00,500,'F',0,25,'product_sprites/women_pendant_sprite.png'),(49,'Women Handbag',4670.00,500,'F',0,25,'product_sprites/women_handbag_sprite_TSu8zOk.png'),(52,'Women Hair Curler',670.00,500,'F',0,24,'product_sprites/women_hair_curler_sprite.png'),(53,'Pet Collar',335.00,500,'ALL',0,29,'product_sprites/pet_collar_sprite.png'),(54,'Pet Shampoo',185.00,500,'ALL',0,29,'product_sprites/pet_shampoo_sprite.png'),(55,'Pet Food',270.00,500,'ALL',0,29,'product_sprites/pet_food_sprite.png'),(56,'Pet Toy',395.00,500,'ALL',0,29,'product_sprites/pet_toy_sprite.png'),(57,'Men Wristwatch',3950.00,500,'M',0,25,'product_sprites/men_wrist_watch_sprite.png'),(58,'Men Wallet',245.00,500,'M',0,25,'product_sprites/men_wallet_sprite.png'),(59,'Fruit Basket',670.00,500,'ALL',0,34,'product_sprites/fruit_basket_sprite.png'),(60,'Vegetable Basket',775.00,500,'ALL',0,34,'product_sprites/vegetable_basket_sprite.png'),(61,'Fresh Fish',450.00,500,'ALL',0,34,'product_sprites/fresh_fish_sprite.png'),(62,'Egg Tray',320.00,499,'ALL',0,34,'product_sprites/egg_tray_sprite.png'),(63,'Fresh Meat',500.00,500,'ALL',0,34,'product_sprites/fresh_meat_sprite.png'),(64,'Honey Jar',245.00,500,'ALL',0,34,'product_sprites/honey_jar_sprite.png'),(65,'Milk Pack',160.00,500,'ALL',0,34,'product_sprites/milk_carton_sprite.png'),(66,'Cake',220.00,500,'ALL',0,30,'product_sprites/cake_sprite.png'),(67,'Pizza',190.00,500,'ALL',0,30,'product_sprites/pizza_sprite.png'),(68,'Croissant',45.00,500,'ALL',0,30,'product_sprites/croissant_sprite.png'),(69,'Bread',30.00,500,'ALL',0,30,'product_sprites/bread_sprite.png'),(70,'Cookies',35.00,500,'ALL',0,30,'product_sprites/cookie_sprite.png'),(71,'Donut',25.00,500,'ALL',0,30,'product_sprites/donut_sprite.png'),(72,'Cheese',55.00,500,'ALL',0,32,'product_sprites/cheese_sprite.png'),(73,'Butter',40.00,500,'ALL',0,32,'product_sprites/butter_sprite.png'),(74,'Whipped Cream',45.00,500,'ALL',0,32,'product_sprites/whipped_cream_sprite.png'),(75,'Ghee',35.00,500,'ALL',0,32,'product_sprites/ghee_sprite.png'),(76,'Yogurt',25.00,500,'ALL',0,32,'product_sprites/yogurt_sprite.png'),(77,'Soft Drink',50.00,500,'ALL',0,31,'product_sprites/soft_drink_sprite.png'),(78,'Sports Drink',55.00,500,'ALL',0,31,'product_sprites/sports_drink_sprite.png'),(79,'Fruit Juice',45.00,500,'ALL',0,31,'product_sprites/fruit_juice_sprite.png'),(80,'Milk Shake',40.00,500,'ALL',0,31,'product_sprites/milk_shake_sprite.png'),(81,'Black Coffee',35.00,500,'ALL',0,31,'product_sprites/black_coffee_sprite.png'),(82,'Green Tea',30.00,500,'ALL',0,31,'product_sprites/green_tea_sprite.png'),(83,'Candy',10.00,500,'ALL',0,47,'product_sprites/candy_sprite.png'),(85,'Chocolate',15.00,500,'ALL',0,47,'product_sprites/chocolate_sprite_i1rGEfI.png'),(86,'Popsicle',25.00,500,'ALL',0,47,'product_sprites/popscicle_sprite.png'),(87,'Potato Chips',20.00,500,'ALL',0,47,'product_sprites/potato_chips_sprite.png'),(88,'Popcorn',30.00,500,'ALL',0,47,'product_sprites/popcorn_sprite.png'),(89,'French Fries',35.00,500,'ALL',0,47,'product_sprites/french_fries_sprite.png'),(90,'Pen',15.00,500,'ALL',0,43,'product_sprites/pen_sprite.png'),(91,'Pencil',10.00,500,'ALL',0,43,'product_sprites/pencil_sprite.png'),(92,'Eraser',5.00,501,'ALL',0,43,'product_sprites/eraser_sprite.png'),(93,'Ruler',15.00,500,'ALL',0,43,'product_sprites/pocket_ruler_sprite.png'),(94,'Note Book',35.00,493,'ALL',0,43,'product_sprites/notebook_sprite.png'),(95,'Glue',20.00,500,'ALL',0,43,'product_sprites/converted_image_sprite_12.png'),(96,'Sticky Tape',15.00,500,'ALL',0,43,'product_sprites/sticky_tape_sprite.png'),(97,'Scissors',20.00,500,'ALL',0,43,'product_sprites/scissors_sprite.png'),(98,'Drilling Machine',540.00,500,'ALL',1,35,'product_sprites/driller_sprite.png'),(99,'Hammer',85.00,500,'ALL',1,35,'product_sprites/hammer_sprite.png'),(100,'Screw Driver',35.00,500,'ALL',1,35,'product_sprites/screw_driver_sprite.png'),(101,'Wrench',45.00,500,'ALL',1,35,'product_sprites/wrench_sprite.png'),(102,'Measuring Tape',35.00,500,'ALL',0,35,'product_sprites/measuring_tape_sprite.png'),(103,'Nails',40.00,500,'ALL',1,35,'product_sprites/nails_sprite.png'),(104,'Hand Saw',130.00,500,'ALL',1,35,'product_sprites/hand_saw_sprite.png'),(105,'Television',150750.00,500,'ALL',0,33,'product_sprites/television_sprite.png'),(106,'Refrigerator',276050.00,500,'ALL',0,33,'product_sprites/refrigerator_sprite.png'),(107,'Sound System',120455.00,500,'ALL',0,33,'product_sprites/sound_system_sprite.png'),(108,'Washing Machine',110275.00,500,'ALL',0,33,'product_sprites/washing_machine_sprite.png'),(109,'Microwave Oven',92570.00,500,'ALL',0,33,'product_sprites/microwave_oven_sprite.png'),(110,'Vaccum Cleaner',87540.00,500,'ALL',0,33,'product_sprites/vaccum_cleaner_sprite.png'),(111,'Mobile Phone',12560.00,500,'ALL',0,33,'product_sprites/mobile_phone_sprite.png'),(112,'Rice',390.00,500,'ALL',0,36,'product_sprites/rice_sprite.png'),(113,'Lentils',340.00,500,'ALL',0,36,'product_sprites/lentils_sprite.png'),(114,'Spices',290.00,500,'ALL',0,36,'product_sprites/spices_sprite.png'),(115,'Wheat Flour',300.00,500,'ALL',0,36,'product_sprites/wheat_flour_sprite.png'),(116,'Oats',280.00,500,'ALL',0,36,'product_sprites/oats_sprite.png'),(117,'Edible Oil',250.00,500,'ALL',0,36,'product_sprites/edible_oil_sprite.png'),(118,'Condiments',235.00,500,'ALL',0,36,'product_sprites/condiments_sprite.png'),(119,'Bed',25000.00,500,'ALL',0,46,'product_sprites/bed_sprite.png'),(120,'Sofa',20000.00,500,'ALL',0,46,'product_sprites/sofa_sprite.png'),(121,'Wadrobe',15000.00,500,'ALL',0,46,'product_sprites/wadrobe_sprite.png'),(122,'Dressing Table',12500.00,500,'ALL',0,46,'product_sprites/dressing_table_sprite.png'),(123,'Bookshelf',10000.00,500,'ALL',0,46,'product_sprites/bookshelf_sprite.png'),(124,'Table',8560.00,500,'ALL',0,46,'product_sprites/table_sprite.png'),(125,'Night Lamp',7505.00,500,'ALL',0,46,'product_sprites/night_lamp_sprite.png'),(126,'Chair',5500.00,500,'ALL',0,46,'product_sprites/chair_sprite.png'),(127,'Carpet',2100.00,500,'ALL',0,46,'product_sprites/carpet_sprite.png'),(128,'Curtains',875.00,500,'ALL',0,46,'product_sprites/curtains_sprite.png'),(129,'Bucket',100.00,500,'ALL',0,39,'product_sprites/bucket_sprite.png'),(130,'Mop',125.00,500,'ALL',0,39,'product_sprites/mop_sprite.png'),(131,'Cleaning Solution',85.00,500,'ALL',0,39,'product_sprites/cleaning_solution_sprite.png'),(132,'Detergent',90.00,500,'ALL',0,39,'product_sprites/detergent_powder_sprite.png'),(133,'Rubber Gloves',40.00,500,'ALL',0,39,'product_sprites/rubber_gloves_sprite.png'),(134,'Wiping Cloth',35.00,500,'ALL',0,39,'product_sprites/wiping_cloth_sprite.png'),(135,'Sprayer Bottle',65.00,500,'ALL',0,39,'product_sprites/sprayer_bottle_sprite.png'),(136,'Trash Bin',120.00,500,'ALL',0,39,'product_sprites/trash_bin_sprite.png'),(137,'Unisex Crocks',340.00,500,'ALL',0,28,'product_sprites/unisex_crocks_sprite.png'),(138,'Unisex Slipper',325.00,500,'ALL',0,28,'product_sprites/unisex_slipper_sprite.png'),(139,'Gas Stove',710.00,500,'ALL',0,42,'product_sprites/gas_stove_sprite.png'),(140,'Juicer & Blender',695.00,500,'ALL',0,42,'product_sprites/juicer__blender_sprite.png'),(141,'Cooking Pan ',445.00,500,'ALL',0,42,'product_sprites/cooking_pan_sprite.png'),(142,'Knife Set',520.00,500,'ALL',1,42,'product_sprites/knife_set_sprite.png'),(143,'Utensil Set',495.00,500,'ALL',0,42,'product_sprites/cooking_utensils_sprite.png'),(144,'Cooking Apron',395.00,500,'ALL',0,42,'product_sprites/chef_apron_sprite.png'),(145,'Chopping Board',405.00,500,'ALL',0,42,'product_sprites/chopping_board_sprite.png'),(146,'Cutlery Set',225.00,500,'ALL',0,42,'product_sprites/cutlery_sprite.png'),(147,'Peeler',175.00,500,'ALL',0,42,'product_sprites/peeler_sprite.png'),(148,'Women Purse',2750.00,500,'F',0,25,'product_sprites/women_purse_sprite_wW6oMXP.png'),(149,'Women Bracelet',5450.00,500,'F',0,25,'product_sprites/converted_image_sprite.png'),(150,'Men Necktie',360.00,500,'M',0,25,'product_sprites/converted_image_sprite_1.png'),(151,'Men Body Soap',35.00,500,'M',0,24,'product_sprites/men_soap_bar_sprite.png'),(152,'Men Facewash',55.00,500,'M',0,24,'product_sprites/men_facewash_sprite.png'),(153,'Women Nailpolish',95.00,500,'F',0,24,'product_sprites/women_nailpolish_sprite.png'),(154,'Women Shampoo',165.00,500,'F',0,24,'product_sprites/women_shampoo_sprite.png'),(156,'Fever Reducer Capsules',165.00,500,'ALL',1,37,'product_sprites/fever_reducer_capsules_sprite.png'),(157,'Pain Killer Tablets',195.00,500,'ALL',1,37,'product_sprites/pain_killer_tablets_sprite_WmPqZsP.png'),(158,'Insulin Shot',225.00,500,'ALL',1,37,'product_sprites/insulin_shot_sprite.png'),(159,'Thermometer',230.00,500,'ALL',0,37,'product_sprites/thermometer_sprite.png'),(160,'Sanitary Pads',95.00,500,'ALL',0,37,'product_sprites/sanitary_pads_sprite.png'),(161,'Disinfectant Solution',70.00,500,'ALL',0,37,'product_sprites/disinfectant_solution_sprite.png'),(163,'Ointment Tube',80.00,500,'ALL',0,37,'product_sprites/ointment_tube_sprite.png'),(164,'Cold Gel Pads',60.00,500,'ALL',0,37,'product_sprites/cold_gel_pads_sprite.png'),(165,'Inhaler',220.00,500,'ALL',0,37,'product_sprites/inhaler_sprite.png'),(166,'Bandages',40.00,500,'ALL',0,37,'product_sprites/bandages_sprite.png'),(169,'Women Palazoo',7900.00,500,'F',0,44,'product_sprites/women_palazzo_sprite_KL5LJgK.png'),(170,'Women Short Skirt',4320.00,500,'F',0,44,'product_sprites/women_short_skirt_sprite_f81iJQ3.png'),(171,'Women Denim Shorts',4870.00,500,'F',0,44,'product_sprites/women_denim_short_sprite.png'),(172,'Men Denim Pants ',5400.00,500,'M',0,44,'product_sprites/men_denim_pant_sprite.png'),(173,'Men Formal Pant',6700.00,500,'M',0,44,'product_sprites/men_formal_pant_sprite.png'),(174,'Men Shorts',3950.00,500,'M',0,44,'product_sprites/men_short_sprite.png'),(175,'Unisex Jogger',4560.00,500,'ALL',0,44,'product_sprites/unisex_jogger_sprite.png'),(176,'Unisex RainCoat',5600.00,500,'ALL',0,44,'product_sprites/unisex_raincoat_sprite.png'),(177,'Unisex Sweat Shirt',4450.00,500,'ALL',0,44,'product_sprites/unisex_sweat_shirt_sprite.png'),(178,'Women T-shirt Top',6200.00,500,'F',0,44,'product_sprites/women_Tshirt_top_sprite.png'),(179,'Women Crop Top',4960.00,500,'F',0,44,'product_sprites/women_croptop_sprite.png'),(180,'Women Cardigan',7860.00,500,'F',0,44,'product_sprites/women_cardigan_sprite.png'),(181,'Men Trench Coat',8100.00,500,'M',0,44,'product_sprites/men_trench_coat_sprite.png'),(182,'Men Formal Shirt',5005.00,500,'M',0,44,'product_sprites/men_formal_shirt_sprite.png'),(183,'Men Hoodie',4700.00,500,'M',0,44,'product_sprites/men_hoodie_sprite.png');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_permission`
--

DROP TABLE IF EXISTS `product_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_permission` (
  `permission_id` int NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL,
  `min_age` int DEFAULT '0',
  `max_age` int DEFAULT '200',
  PRIMARY KEY (`permission_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `product_permission_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_permission`
--

LOCK TABLES `product_permission` WRITE;
/*!40000 ALTER TABLE `product_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_permission` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-16  0:57:11
