Enter password: 
-- MySQL dump 10.13  Distrib 5.7.29, for Linux (x86_64)
--
-- Host: localhost    Database: guia_database
-- ------------------------------------------------------
-- Server version	5.7.29

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
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `locality` varchar(255) NOT NULL,
  `number` decimal(8,2) NOT NULL,
  `complements` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `uf` varchar(2) NOT NULL,
  `company_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `address_company_id_foreign` (`company_id`),
  CONSTRAINT `address_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'Rua 31 de Março',560.00,'','Pedro Velho','RN',1),(2,'Rua 31 de Março',560.00,'','Montanhas RN','RN',2),(3,'Rua dos bobos',0.00,'','Goianinha','RN',17);
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name_category` varchar(255) CHARACTER SET latin1 NOT NULL,
  `image_name` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin5;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (10,'Farmácia','b61ca0d55cce4ab2bad41b0466492df2-farmacia.jpeg'),(11,'Sorveteria','5ddaddd3d2a661771d8d531c73a5c666-sorveteria.jpeg'),(13,'Barbearia','78640ab11c0a61d57a4cc3cf414d5d7d-barbearia.jpeg'),(14,'Lanchonete','cd704aa88ea486fdac7eb7360cb3a35d-lanchonete.jpeg'),(15,'Supermercado','72fd7f1fe7d54426f4df50f106e3f1fd-download (2).jpeg'),(16,'Vestuário','dfcc5e2dc5ccb1b37b80c7aab05ce5a0-vestuario.jpeg');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `text_comment` varchar(255) NOT NULL,
  `person_id` int(10) unsigned NOT NULL,
  `company_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `comments_company_id_foreign` (`company_id`),
  KEY `comments_person_id_foreign` (`person_id`),
  CONSTRAINT `comments_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`),
  CONSTRAINT `comments_person_id_foreign` FOREIGN KEY (`person_id`) REFERENCES `people` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cnpj` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `evaluation` decimal(8,2) NOT NULL,
  `instagram` varchar(255) NOT NULL,
  `whatsapp` varchar(255) NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `image_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `company_user_id_foreign` (`user_id`),
  CONSTRAINT `company_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES (1,'000.111.222-00','Barbearia do José','Barbearia especializada em cortes modernos e focada no bem estar dos nossos clientes. VENHA CONFERIR!',5.00,'@barbeadriadopedrao','(84) 0000-0000',1,NULL,NULL,'78640ab11c0a61d57a4cc3cf414d5d7d-barbearia.jpeg'),(2,'000.111.222-00','Loja da Maria','Loja virtual ',4.50,'@morenadebronze','(84) 0000-0000',2,NULL,NULL,'dfcc5e2dc5ccb1b37b80c7aab05ce5a0-vestuario.jpeg'),(3,'000.111.222-00','Farmacia do povo','teste',4.70,'@teste','(84) 0000-0000',6,NULL,NULL,'bab3ff8aa28e4e356663798bf541cbbd-code_coding_binary_code_abstract_patterns_112140_2560x1440.jpg'),(4,'000.111.222-00','teste','testanto esse teste',0.00,'@teste','(84) 0000-0000',7,NULL,NULL,'f0662012db9789f49157fcde20e4632e-code_coding_binary_code_abstract_patterns_112140_2560x1440.jpg'),(17,'000.111.222-00','teste','testanto esse teste',0.00,'@teste','(84) 0000-0000',21,NULL,NULL,'49cdf3d313bd8feadd186eea4d735ffa-code_coding_binary_code_abstract_patterns_112140_2560x1440.jpg'),(18,'000.111.222-00','teste','testanto esse teste',0.00,'@teste','(84) 0000-0000',22,NULL,NULL,'1f4f82a1d80d6d30e4e87a39aed52b0a-Captura de tela_2020-04-30_21-00-14.png'),(19,'000.111.222-00','teste backend','testanto esse teste',0.00,'@teste','(84) 0000-0000',26,NULL,NULL,'1ba65bb9c1eadb942fa9fb91e817a77e-ícone_sem_fundo.jpg'),(20,'000.111.222-00','teste backend','testanto esse teste',0.00,'@teste','(84) 0000-0000',30,NULL,NULL,'db69255c6caa183a7103d3347827194d-ícone_sem_fundo.jpg'),(21,'000.111.222-00','teste backend XXX','testanto esse teste',0.00,'@teste','(84) 0000-0000',37,NULL,NULL,'65b7e5749fb7ee56e610e8891865a3ea-ícone_sem_fundo.jpg'),(22,'86.633.080/0001-38','teste no frontend','',0.00,'@testefront','989898',40,NULL,NULL,'eaefdea58e40e9b72e817c3febb9dc61-ícone_sem_fundo.jpg');
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company_category`
--

DROP TABLE IF EXISTS `company_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company_category` (
  `company_id` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  KEY `company_category_company_id_foreign` (`company_id`),
  KEY `company_category_category_id_foreign` (`category_id`),
  CONSTRAINT `company_category_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `company_category_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company_category`
--

LOCK TABLES `company_category` WRITE;
/*!40000 ALTER TABLE `company_category` DISABLE KEYS */;
INSERT INTO `company_category` VALUES (3,10),(1,13),(2,16),(4,14);
/*!40000 ALTER TABLE `company_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `knex_migrations`
--

DROP TABLE IF EXISTS `knex_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `knex_migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `batch` int(11) DEFAULT NULL,
  `migration_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `knex_migrations`
--

LOCK TABLES `knex_migrations` WRITE;
/*!40000 ALTER TABLE `knex_migrations` DISABLE KEYS */;
INSERT INTO `knex_migrations` VALUES (1,'20200328174302_create_users.js',1,'2020-05-07 15:20:36'),(2,'20200328174358_create_category.js',1,'2020-05-07 15:20:37'),(3,'20200328174434_create_company.js',1,'2020-05-07 15:20:38'),(4,'20200328174514_create_company_category.js',1,'2020-05-07 15:20:41'),(5,'20200328174546_create_address.js',1,'2020-05-07 15:20:42'),(6,'20200328174615_create_promotions.js',1,'2020-05-07 15:20:44'),(7,'20200328174642_create_comments.js',1,'2020-05-07 15:20:46'),(8,'20200413121935_alter_table_promotions.js',1,'2020-05-07 15:20:47'),(9,'20200501132732_create_person_table.js',1,'2020-05-07 15:20:48'),(10,'20200501133620_refactor_table_users.js',1,'2020-05-07 15:20:57'),(11,'20200501134558_refactor_table_comments.js',1,'2020-05-07 15:21:04'),(12,'20200501151817_refactor_table_company.js',1,'2020-05-07 15:21:06'),(13,'20200506233001_refactor_table_company.js',1,'2020-05-07 15:21:07'),(14,'20200508222815_refactor_table_category.js',2,'2020-05-08 22:32:04'),(15,'20200509000120_refactor_table_people.js',3,'2020-05-09 00:02:57');
/*!40000 ALTER TABLE `knex_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `knex_migrations_lock`
--

DROP TABLE IF EXISTS `knex_migrations_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `knex_migrations_lock` (
  `index` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_locked` int(11) DEFAULT NULL,
  PRIMARY KEY (`index`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `knex_migrations_lock`
--

LOCK TABLES `knex_migrations_lock` WRITE;
/*!40000 ALTER TABLE `knex_migrations_lock` DISABLE KEYS */;
INSERT INTO `knex_migrations_lock` VALUES (1,0);
/*!40000 ALTER TABLE `knex_migrations_lock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `people`
--

DROP TABLE IF EXISTS `people`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `people` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cpf` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `birth_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `gender` enum('male','female','other') DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `image_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `people_user_id_foreign` (`user_id`),
  CONSTRAINT `people_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `people`
--

LOCK TABLES `people` WRITE;
/*!40000 ALTER TABLE `people` DISABLE KEYS */;
INSERT INTO `people` VALUES (1,'111.222.333-44','Jorge','Vercillo','1997-02-06 00:00:00','male',NULL,NULL,45,'409002983f738889be858a79bfcdd22f-jorge.jpeg'),(2,'111.222.333-44','Jorge','Vercillo','1997-02-06 00:00:00','male',NULL,NULL,50,'cf32e9dbc8dc3a161240e233adb1cad6-jorge.jpeg'),(3,'111.222.333-44','Jorge','Vercillo','1997-02-06 00:00:00','male',NULL,NULL,52,'1a5f6b0eaab0dfe09c1977cd043415ae-jorge.jpeg');
/*!40000 ALTER TABLE `people` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotions`
--

DROP TABLE IF EXISTS `promotions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `promotions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `coupon_amount` decimal(8,2) NOT NULL,
  `coupon_count` decimal(8,2) NOT NULL,
  `company_id` int(10) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `value_real` decimal(8,2) NOT NULL,
  `value_discount` decimal(8,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `promotions_company_id_foreign` (`company_id`),
  CONSTRAINT `promotions_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotions`
--

LOCK TABLES `promotions` WRITE;
/*!40000 ALTER TABLE `promotions` DISABLE KEYS */;
INSERT INTO `promotions` VALUES (1,'2020-03-16','2020-04-07',10.00,2.00,1,'Cortes com 30% de desconto',10.00,7.00),(2,'2020-03-16','2020-04-07',10.00,2.00,1,'Cortes com 30% de desconto',10.00,7.00);
/*!40000 ALTER TABLE `promotions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email_validated` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'bpedrao@sucesso.com','$2b$10$Jbv3fBQLcrQ8wXj0I8wMf.I7/.00L0O21V6Wge7GePn4zAU5WmpFK',0,'2020-05-07 15:56:52','2020-05-07 15:56:52'),(2,'morena@sucesso.com','$2b$10$3gr.BY/gvBHCjjEVK/WOReq1V/520XAcCFBe.uuLAAJ2cy5L8VX7K',0,'2020-05-07 16:03:29','2020-05-07 16:03:29'),(3,'teste@teste.com','$2b$10$jEat1QKKYM/COm1EJgekfOTZ0Wr7dDhKl1HJgTNVvtKOCjEJ/wJIu',0,'2020-05-07 18:55:43','2020-05-07 18:55:43'),(4,'teste@teste.com','$2b$10$O0vMIs.NWbczls27v3ryZObn7CxHLhJkkEe5Kl5y7pSrmHMIdY7Jy',0,'2020-05-07 18:56:30','2020-05-07 18:56:30'),(5,'teste@teste.com','$2b$10$735kVMBLa4TqF5l8L6ICCOLbv1vhW2osclqKQdpEzveVXj4Bm2laK',0,'2020-05-07 18:56:33','2020-05-07 18:56:33'),(6,'teste@teste.com','$2b$10$N3AHgBPDRus5G5UqNKq46.bwxucc0BR5sGagx.2QV7BzvVPtfHvSq',0,'2020-05-07 18:56:54','2020-05-07 18:56:54'),(7,'teste@teste.com','$2b$10$RA5.AkhUtXMn9IT34AYSf.AI7kK4hF/l26lI65hUytVWqlL1uZz3m',0,'2020-05-07 19:00:06','2020-05-07 19:00:06'),(8,'teste@teste.com','$2b$10$ZTgKG15PDM5GQD5ZpZHcveGmzOLl9y9f9tKc5vqNPN8zl8oVICui2',0,'2020-05-07 19:00:57','2020-05-07 19:00:57'),(9,'teste@teste.com','$2b$10$0rPWecu02dIW/agUMSGMi.ufJlbD9ml0qZ488tsfDudGLyOO1tjHK',0,'2020-05-07 19:02:37','2020-05-07 19:02:37'),(10,'teste@teste.com','$2b$10$9O3EhbCVAC4sdi8ZC22IRuKcHrV7hnpzvgvG6HScB6VQiJdlipQky',0,'2020-05-07 19:07:45','2020-05-07 19:07:45'),(11,'teste@teste.com','$2b$10$k.rY8CboJg1tjUfWB4Tsg.bvnqLplQF4FeWCjuehu5yLi9P1etEqu',0,'2020-05-07 19:08:11','2020-05-07 19:08:11'),(12,'teste@teste.com','$2b$10$e9gYhvcvkWx5Eyfq8etndeRJMwtYml1zjGXIq/ZUHvJIk8MV8qS0G',0,'2020-05-07 19:08:54','2020-05-07 19:08:54'),(13,'teste@teste.com','$2b$10$DY58gIUM6nX5yJUSXkjfFuzlaDkfELfreqA0dNEDX286/0iOHTZCa',0,'2020-05-07 19:09:02','2020-05-07 19:09:02'),(14,'teste@teste.com','$2b$10$qQ7yb87wpsHjun9vQmeFM.ATDzDqIAYAQl2WvCPxxJGaGOKfINOPq',0,'2020-05-07 19:09:02','2020-05-07 19:09:02'),(15,'teste@teste.com','$2b$10$2RNcAaTsfyYhc2Uwq9nEZeZXrbdxwwA0itzSHZeZUnnILddP.YUc6',0,'2020-05-07 19:13:09','2020-05-07 19:13:09'),(16,'teste@teste.com','$2b$10$YOEY7WAfIPZC5hTjcI/RkesrO94qg4UEKQuV2l2v48fSXeJSRsZSq',0,'2020-05-07 19:13:42','2020-05-07 19:13:42'),(17,'teste@teste.com','$2b$10$UPjvIpXoBbzzzo0hK2FTq.eazV6Dj2OPkHOKTuB21JLM7xgM3l0L2',0,'2020-05-07 19:15:21','2020-05-07 19:15:21'),(18,'teste@teste.com','$2b$10$eT5IYZ1JH793FCYPGJkMiOajPFQbEsulfmn8FgKFllBp9QJP89JvS',0,'2020-05-07 19:16:17','2020-05-07 19:16:17'),(19,'teste@teste.com','$2b$10$N25vbtnJVmcm5LuKdn2ULueD8Gsnf880P3ZMrdxNseWsT.PmLXony',0,'2020-05-07 19:16:32','2020-05-07 19:16:32'),(20,'teste@teste.com','$2b$10$Fmxwv8zJZjsAAOSUSL88eekaNf2qD9F2aw61vSG53KwzMZSlbqyY2',0,'2020-05-07 19:16:43','2020-05-07 19:16:43'),(21,'teste@teste.com','$2b$10$iIIRZehXAH3wJJHLvJXj7eNbt88qkp3ptN3tdapCAqQFwKejho3LW',0,'2020-05-07 19:18:36','2020-05-07 19:18:36'),(22,'teste@teste.com','$2b$10$TE/hj.i0qtW2VWCxwtyFpOL8eMTFXouCXEUox9ECgy9YcewFtCdJm',0,'2020-05-07 19:49:23','2020-05-07 19:49:23'),(23,'teste@testando.com','$2b$10$6xgVncSR.bKECNo8vwQuTuap.XXeddfj/t3QDp6UcwLJ6kg/.dz62',0,'2020-05-07 22:06:59','2020-05-07 22:06:59'),(24,'teste@testando.com','$2b$10$iw9IIuOyo.FnXz8DXrfTHunwOJ3WA/MrEgUHSnzuNTgSR0vT8cY6q',0,'2020-05-07 22:17:08','2020-05-07 22:17:08'),(25,'teste@testando.com','$2b$10$gG9PxzRsMZCgbLJPNhj8qu3TjI8EtfB9aLwBl0Z1KzOehn8IBSQ3a',0,'2020-05-07 22:18:25','2020-05-07 22:18:25'),(26,'teste@teste.com','$2b$10$Bwd2nvpvZveYAI3TLGviA.amFZMJKfriGiEJmqo4yZGlOT03/4u5y',0,'2020-05-07 22:34:46','2020-05-07 22:34:46'),(27,'teste@teste.com','$2b$10$xldXdOLv98ze3I50KTqbre/PJ3Mrda0JNTWl6NYCz/aDY79HDQ4MO',0,'2020-05-07 22:44:03','2020-05-07 22:44:03'),(28,'teste@teste.com','$2b$10$fwwgB6kIe9GCXvokkX5jruJCy4MBnHxCIsepX43FU9oeNhUUca5Wm',0,'2020-05-07 22:44:28','2020-05-07 22:44:28'),(29,'teste@teste.com','$2b$10$t1aw/g8tMvPFTn17MWBYHe6/2I3jX0rzEDhnN9fyhszQwaFR8HpCK',0,'2020-05-07 22:46:01','2020-05-07 22:46:01'),(30,'teste@teste.com','$2b$10$FO4SnnCNNp4IWUafnMGieO57LHQRTtLRHFpe.ZKgwjYEBKgyok/yO',0,'2020-05-07 22:46:48','2020-05-07 22:46:48'),(31,'yhyh@ijijij.com','$2b$10$tOy7pi1YD1HVLYK/UHi.tuw1A96qR6FyrF41PgdZBu2QDyaG89KmG',0,'2020-05-07 22:55:57','2020-05-07 22:55:57'),(32,'yhyh@ijijij.com','$2b$10$1Via7PKDceLdj94nFA/YMOTrkGXCYtjNaEqKOj7fbU2wv/aFbEfva',0,'2020-05-07 22:56:48','2020-05-07 22:56:48'),(33,'yhyh@ijijij.com','$2b$10$jqf8Dsq.a8/txKaWwrpnne5Z0xYyXy5dtOrSt0U3Y1HTQq/keK0Xe',0,'2020-05-07 22:57:35','2020-05-07 22:57:35'),(34,'iij@iik.com','$2b$10$Z4yVIo4xmem/G.oRY4vwc.4BQ3gEy8LQR5zvkE/0dKNlRzl/F/ohm',0,'2020-05-07 23:03:17','2020-05-07 23:03:17'),(35,'uju@ikik.com','$2b$10$xqE8j9ohDQsRqn2ujzA85OkXGfCt6ebszKkIkrt/asGr4.aXQbuYy',0,'2020-05-07 23:07:22','2020-05-07 23:07:22'),(36,'uju@ikik.com','$2b$10$YeukXIYJZE6PsY.wcltifeT73jQeVYApTMGpHIa1t86nUFYaRUTzG',0,'2020-05-07 23:15:57','2020-05-07 23:15:57'),(37,'teste@teste.com','$2b$10$IKpzY0cC1LcdmAk29iasFuMq5fyxaZ0ipxBkmRJOLpNGyTV5HwSF.',0,'2020-05-07 23:24:28','2020-05-07 23:24:28'),(38,'uju@ikik.com','$2b$10$1HqrdLGACWCiyQrj/0hXgOxwbWG/2kXqbxLUboJZpS8673c9RQd9e',0,'2020-05-07 23:27:03','2020-05-07 23:27:03'),(39,'uju@ikik.com','$2b$10$vtUCqb.JGBhpg13z3.azZOAAsVDWDKS2suQXukjqcX/xCl0DbF9Su',0,'2020-05-07 23:27:45','2020-05-07 23:27:45'),(40,'teste@tgtgtgtg.com','$2b$10$yj6FUIXNRZl.aAW8kw2oCOjl2C4DxYwQjFglm9T1VaDObXFa/8MFO',0,'2020-05-07 23:32:42','2020-05-07 23:32:42'),(41,'jorge.vercillo@demais.com','123',0,NULL,NULL),(42,'jorge.vercillo@demais.com','123',0,NULL,NULL),(43,'jorge.vercillo@demais.com','123',0,NULL,NULL),(44,'jorge.vercillo@demais.com','123',0,NULL,NULL),(45,'jorge.vercillo@demais.com','123',0,NULL,NULL),(46,'whind@teste.com','123',0,NULL,NULL),(47,'teste@hotok.com','123',0,NULL,NULL),(48,'teste@example.com','1234',0,NULL,NULL),(49,'teste@example.com','1234',0,NULL,NULL),(50,'jorge.vercillo@demais.com','123',0,NULL,NULL),(51,'teste@example.com','1234',0,NULL,NULL),(52,'jorge.vercillo@demais.com','123',0,NULL,NULL),(53,'teste@example.com','1234',0,NULL,NULL),(54,'jii@hotmail.com','1234',0,NULL,NULL),(55,'jii@hotmail.com','1234',0,NULL,NULL),(56,'jii@hotmail.com','1234',0,NULL,NULL),(57,'jii@hotmail.com','1234',0,NULL,NULL),(58,'jii@hotmail.com','1234',0,NULL,NULL),(59,'jii@hotmail.com','1234',0,NULL,NULL),(60,'carlajkkk@hotmail.com','123',0,NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-12-03  0:25:50
