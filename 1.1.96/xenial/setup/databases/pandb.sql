-- MySQL dump 10.15  Distrib 10.0.16-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: pandb
-- ------------------------------------------------------
-- Server version	10.0.16-MariaDB

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


DROP TABLE if EXISTS `cronjobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cronjobs` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `name` varchar(45) NOT NULL,
 `type` varchar(45) NOT NULL,
 `log_connector` varchar(45) NOT NULL,
 `recurrence` varchar(50) NOT NULL,
 `day_of_week` varchar(50) NOT NULL,
 `start_date` date NOT NULL,
 `start_time` varchar(5) NOT NULL DEFAULT '00:00',
 `date_created` datetime NOT NULL,
 `date_modification` datetime NOT NULL,
 `filename` varchar(50) NOT NULL,
 `command` varchar(100) NOT NULL,
 `source` INT(11) NOT NULL,
 `vsys` VARCHAR(45) NOT NULL,
 `project` VARCHAR(45) NOT NULL,
 `disable` INT(1) NOT NULL,
 `rules_lid` MEDIUMTEXT NOT NULL,
 PRIMARY KEY (`id`),
 UNIQUE KEY `id_UNIQUE` (`id`),
 KEY `index1` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
--
-- Table structure for table `contents`
--

DROP TABLE IF EXISTS `contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source` varchar(255) NOT NULL,
  `type` varchar(45) NOT NULL,
  `version` varchar(45) NOT NULL,
  `releasedate` datetime NOT NULL,
  `filename` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `index1` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contents`
--

LOCK TABLES `contents` WRITE;
/*!40000 ALTER TABLE `contents` DISABLE KEYS */;
/*!40000 ALTER TABLE `contents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devices`
--

DROP TABLE IF EXISTS `devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `vsys` varchar(10) DEFAULT 'vsys1',
  `api_key` varchar(255) NOT NULL,
  `panos` varchar(45) NOT NULL,
  `threats` int(1) DEFAULT '0',
  `apps` int(1) DEFAULT '0',
  `hostname` varchar(255) NOT NULL,
  `ispanorama` int(1) DEFAULT '0',
  `config` int(1) DEFAULT '0',
  `type` varchar(255) NOT NULL,
  `port` int(6) DEFAULT '443',
  `serial` varchar(45) NOT NULL,
  `appversion` varchar(45) NOT NULL,
  `appreleasedate` datetime NOT NULL,
  `threatversion` varchar(45) NOT NULL,
  `threatreleasedate` datetime NOT NULL,
  `device` varchar(255) NOT NULL,
  `management` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devices`
--

LOCK TABLES `devices` WRITE;
/*!40000 ALTER TABLE `devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `panos_capacity`
--

DROP TABLE IF EXISTS `panos_capacity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `panos_capacity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `platform_id` int(11) NOT NULL,
  `panos` varchar(45) NOT NULL,
  `address_max` int(11) NOT NULL,
  `address_groups_max` int(11) NOT NULL,
  `members_address_groups_max` int(11) NOT NULL,
  `services_max` int(11) NOT NULL,
  `services_groups_max` int(11) NOT NULL,
  `members_services_groups_max` int(11) NOT NULL,
  `fqdn_max` int(11) NOT NULL,
  `security_rulebase_max` int(11) NOT NULL,
  `nat_rulebase_max` int(11) NOT NULL,
  `zones_max` int(11) NOT NULL,
  `virtual_routers_max` int(11) NOT NULL,
  `base_vsys` int(11) NOT NULL,
  `vsys_max` int(11) NOT NULL,
  `forwarding_table_max` int(11) NOT NULL,
  `security_profiles_max` int(11) NOT NULL,
  `appoverride_rulebase_max` int(11) NOT NULL,
  `custom_appid_max` int(11) NOT NULL DEFAULT '512',
  `sessions_max` int(11) DEFAULT NULL,
  `ipsec_tunnels_max` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `index1` (`platform_id`,`panos`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `panos_capacity`
--

LOCK TABLES `panos_capacity` WRITE;
/*!40000 ALTER TABLE `panos_capacity` DISABLE KEYS */;
INSERT INTO `panos_capacity` VALUES

(8,2,'6.0',2500,125,500,1000,250,500,1000,250,125,10,3,1,1,0,25,100,6416,50000,25),
(9,3,'6.0',4000,250,500,1000,250,500,1000,2000,1000,20,3,1,1,0,50,100,6416,100000,500),
(10,4,'6.0',10000,1000,500,1000,250,500,1000,5000,1000,40,3,1,1,0,250,500,6416,250000,2000),
(11,7,'6.0',10000,1000,500,2000,500,500,1000,10000,1000,40,3,1,1,0,250,1000,6416,250000,2000),
(12,8,'6.0',2500,125,500,1000,250,500,1000,250,125,10,3,1,1,0,25,100,6416,64000,25),
(13,10,'6.0',2500,250,500,1000,250,500,1000,1000,125,20,3,1,1,0,50,100,6416,64000,250),
(14,13,'6.0',5000,500,500,1000,250,500,1000,2500,1000,40,10,1,6,0,100,250,6416,125000,1000),
(15,14,'6.0',10000,1000,500,1000,250,500,1000,5000,1000,40,10,1,6,0,250,500,6416,250000,2000),
(16,15,'6.0',5000,500,500,1000,250,500,1000,2500,1000,40,10,1,6,0,100,250,6416,250000,1000),
(17,16,'6.0',10000,1000,500,1000,250,500,1000,5000,1000,40,10,1,6,0,250,500,6416,500000,2000),
(18,17,'6.0',10000,1000,500,1000,250,500,1000,5000,1000,80,20,10,20,0,250,500,6416,50000,2000),
(19,18,'6.0',10000,1000,500,1000,250,500,1000,10000,4000,500,125,25,125,0,250,1000,6416,2000000,2000),
(20,19,'6.0',40000,2500,500,2000,250,500,1000,20000,4000,500,125,25,125,0,500,2000,6416,2000000,4000),
(21,20,'6.0',40000,2500,500,2000,250,500,1000,20000,1000,80,20,10,20,0,500,2000,6416,1000000,4000),
(22,21,'6.0',10000,1000,500,1000,250,500,1000,10000,4000,500,125,25,125,0,500,1000,6416,2000000,2000),
(23,22,'6.0',40000,2500,500,2000,250,500,1000,20000,4000,500,225,25,225,0,500,2000,6416,4000000,4000),
(24,23,'6.0',80000,4000,500,4000,250,500,1000,40000,8000,900,225,25,225,0,500,4000,6416,4000000,8000),
(25,27,'6.0',80000,8000,500,8000,250,500,8000,80000,8000,4000,225,25,225,0,500,4000,6416,24000000,8000),

(26,2,'7.1',2500,125,2500,1000,250,500,2000,250,160,10,3,1,1,0,38,100,6416,50000,25),
(27,3,'7.1',4000,250,2500,1000,250,500,2000,2000,1000,20,3,1,1,0,75,100,6416,100000,500),
(28,4,'7.1',10000,1000,2500,1000,250,500,2000,5000,1000,40,3,1,1,0,375,500,6416,250000,2000),
(29,7,'7.1',10000,1000,2500,2000,250,500,2000,10000,1000,40,3,1,1,0,375,1000,6416,250000,2000),
(30,8,'7.1',2500,125,2500,1000,250,500,2000,250,160,10,3,1,1,0,38,100,6416,65536,25),
(31,10,'7.1',2500,250,2500,1000,250,500,2000,1000,160,20,3,1,1,0,75,100,6416,65536,250),
(32,13,'7.1',5000,500,2500,1000,250,500,2000,2500,1000,40,10,1,6,0,150,250,6416,131072,1024),
(33,14,'7.1',10000,1000,2500,1000,250,500,2000,5000,1000,40,10,1,6,0,375,500,6416,262144,2048),
(34,15,'7.1',5000,500,2500,1000,250,500,2000,2500,3000,40,10,1,6,0,150,250,6416,262144,1024),
(35,16,'7.1',10000,1000,2500,1000,250,500,2000,5000,5000,40,10,1,6,0,375,500,6416,524288,2048),
(36,17,'7.1',10000,1000,2500,1000,250,500,2000,5000,5000,40,10,1,6,0,375,500,6416,524288,2048),
(37,18,'7.1',10000,1000,2500,2000,250,500,2000,10000,5000,80,20,10,20,0,375,1000,6416,524288,2048),
(38,19,'7.1',40000,2500,2500,2000,250,500,2000,20000,5000,500,125,25,125,0,750,2000,6416,2097152,4096),
(39,20,'7.1',40000,2500,2500,2000,250,500,2000,20000,6000,500,125,25,125,0,750,2000,6416,2097152,4096),
(40,21,'7.1',10000,1000,2500,2000,250,500,2000,10000,6000,80,20,10,20,0,750,1000,6416,1048576,2048),
(41,22,'7.1',40000,2500,2500,2000,250,500,2000,20000,8000,500,125,25,125,0,750,2000,6416,2000002,4096),
(42,23,'7.1',80000,4000,2500,4000,250,500,2000,40000,16000,900,225,25,225,0,750,4000,6416,4194304,8000),
(43,27,'7.1',80000,8000,2500,4000,250,500,6000,40000,16000,900,225,25,225,0,750,4000,6416,48000000,8000),
(44,28,'7.1',80000,8000,2500,4000,250,500,6000,40000,16000,900,225,25,225,0,750,4000,6416,80000000,8000),

(45,1,'8.0',2500,125,2500,1000,250,500,2000,250,400,15,3,1,1,0,38,100,6416,65536,250),
(46,2,'8.0',10000,1000,2500,2000,500,500,2000,1500,3000,40,3,1,1,0,375,1000,6416,256000,1000),
(47,3,'8.0',4000,250,2500,1000,250,500,2000,2000,1000,20,3,1,1,0,75,100,6416,100000,500),
(48,4,'8.0',10000,1000,2500,2000,500,500,2000,10000,5000,40,10,1,1,0,375,1000,6416,819200,2000),
(49,5,'8.0',20000,2500,2500,2000,250,500,2000,10000,8000,200,20,1,1,0,750,1000,6416,2000002,4000),
(50,6,'8.0',40000,4000,2500,2000,250,500,2000,20000,8000,200,125,1,1,0,750,2000,6416,10485760,8000),
(51,7,'8.0',10000,1000,2500,2000,500,500,2000,10000,1000,40,3,1,1,0,375,1000,6416,250000,2000),
(52,8,'8.0',2500,125,2500,1000,250,500,2000,250,160,10,3,1,1,0,38,100,6416,65536,25),
(53,9,'8.0',2500,125,2500,1000,250,500,2000,250,400,15,3,1,1,0,38,100,6416,65536,1000),
(54,10,'8.0',2500,250,2500,1000,250,500,2000,1000,160,20,3,1,1,0,75,100,6416,65536,250),
(55,11,'8.0',2500,250,2500,1000,250,500,2000,1500,3000,30,5,1,1,0,100,100,6416,131072,2000),
(56,12,'8.0',2500,350,2500,1000,250,500,2000,1500,3000,30,5,1,1,0,150,150,6416,196608,2000),
(57,15,'8.0',5000,500,2500,1000,250,500,2000,2500,3000,40,10,1,6,0,150,250,6416,262144,1024),
(58,16,'8.0',10000,1000,2500,1000,250,500,2000,5000,5000,40,10,1,6,0,375,500,6416,524288,2048),
(59,17,'8.0',10000,1000,2500,1000,250,500,2000,5000,5000,40,10,1,6,0,375,500,6416,524288,2048),
(60,21,'8.0',10000,1000,2500,2000,250,500,2000,10000,6000,80,20,10,20,0,750,1000,6416,1048576,2048),
(61,22,'8.0',40000,2500,2500,2000,250,500,2000,20000,8000,500,125,25,125,0,750,2000,6416,2000002,4096),
(62,23,'8.0',80000,4000,2500,4000,250,500,2000,40000,16000,900,225,25,225,0,750,4000,6416,4194304,8000),
(63,24,'8.0',40000,4000,2500,2000,250,500,2000,20000,6000,80,20,10,20,0,750,2000,6416,4194304,10000),
(64,25,'8.0',80000,8000,2500,4000,250,500,2000,40000,8000,500,125,25,125,0,750,4000,6416,8368608,12000),
(65,26,'8.0',80000,8000,2500,4000,250,500,2000,40000,16000,900,225,25,225,0,750,4000,6416,33000000,15000),
(66,27,'8.0',80000,8000,2500,4000,250,500,2000,40000,16000,900,225,25,225,0,750,4000,6416,80000000,8000),
(67,28,'8.0',80000,8000,2500,4000,250,500,2000,40000,16000,900,225,25,225,0,750,4000,6416,80000000,8000);


/*!40000 ALTER TABLE `panos_capacity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `platforms`
--

DROP TABLE IF EXISTS `platforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `platforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `icon` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `platforms`
--

LOCK TABLES `platforms` WRITE;
/*!40000 ALTER TABLE `platforms` DISABLE KEYS */;
INSERT INTO `platforms` VALUES
(1,'VM-50','vmseries.png'),
(2,'VM-100','vmseries.png'),
(3,'VM-200','vmseries.png'),
(4,'VM-300','vmseries.png'),
(5,'VM-500','vmseries.png'),
(6,'VM-700','vmseries.png'),
(7,'VM-1000-HV','vmseries.png'),
(8,'PA-200','pa200.png'),
(9,'PA-220','pa200.png'),
(10,'PA-500','pa500.png'),
(11,'PA-820','pa500.png'),
(12,'PA-850','pa500.png'),
(13,'PA-2020','pa2000.png'),
(14,'PA-2050','pa2000.png'),
(15,'PA-3020','pa3000.png'),
(16,'PA-3050','pa3000.png'),
(17,'PA-3060','pa3000.png'),
(18,'PA-4020','pa4000.png'),
(19,'PA-4050','pa4000.png'),
(20,'PA-4060','pa4000.png'),
(21,'PA-5020','pa5000.png'),
(22,'PA-5050','pa5000.png'),
(23,'PA-5060','pa5000.png'),
(24,'PA-5220','pa5000.png'),
(25,'PA-5250','pa5000.png'),
(26,'PA-5260','pa5000.png'),
(27,'PA-7050','pa7000.png'),
(28,'PA-7080','pa7000.png');

/*(1,'VM-100','vmseries.png'),
(2,'VM-200','vmseries.png'),
(3,'VM-300','vmseries.png'),
(4,'VM-1000-HV','vmseries.png'),
(5,'PA-200','pa200.png'),
(6,'PA-500','pa500.png'),
(7,'PA-2020','pa2000.png'),
(8,'PA-2050','pa2000.png'),
(9,'PA-3020','pa3000.png'),
(10,'PA-3050','pa3000.png'),
(11,'PA-3060','pa3000.png'),
(12,'PA-4020','pa4000.png'),
(13,'PA-4050','pa4000.png'),
(14,'PA-4060','pa4000.png'),
(15,'PA-5020','pa5000.png'),
(16,'PA-5050','pa5000.png'),
(17,'PA-5060','pa5000.png'),
(18,'PA-7050','pa7000.png'),
(19,'VM-50','vmseries.png'),
(20,'VM-500','vmseries.png'),
(21,'VM-700','vmseries.png'),
(22,'PA-220','pa200.png'),*/
/*!40000 ALTER TABLE `platforms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `vendors` varchar(255) NOT NULL,
  `date` datetime NOT NULL,
  `progress` int(2) NOT NULL DEFAULT '0',
  `tag` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `snippets`
--

DROP TABLE IF EXISTS `snippets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `snippets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `type` varchar(150) NOT NULL,
  `data` text,
  `description` varchar(255) NOT NULL,
  `panos` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `snippets`
--

LOCK TABLES `snippets` WRITE;
/*!40000 ALTER TABLE `snippets` DISABLE KEYS */;
INSERT INTO `snippets` VALUES (1,'icmp_source_quench','appid','<entry name=\"icmp_source_quench\">\n<category>networking</category>\n<subcategory>ip-protocol</subcategory>\n<technology>network-protocol</technology>\n<risk>1</risk>\n<consume-big-bandwidth>no</consume-big-bandwidth>\n<able-to-transfer-file>no</able-to-transfer-file>\n<used-by-malware>no</used-by-malware>\n<evasive-behavior>no</evasive-behavior>\n<has-known-vulnerability>no</has-known-vulnerability>\n<pervasive-use>no</pervasive-use>\n<prone-to-misuse>no</prone-to-misuse>\n<tunnel-applications>no</tunnel-applications>\n<tunnel-other-application>no</tunnel-other-application>\n<data-ident>no</data-ident>\n<virus-ident>no</virus-ident>\n<file-type-ident>no</file-type-ident>\n<spyware-ident>no</spyware-ident>\n<default>\n<ident-by-icmp-type>4</ident-by-icmp-type>\n</default>\n</entry>','Custom appID to control icmp_source_quench','4.0'),(2,'icmp_any','appid','<entry name=\"icmp_any\">\n<category>networking</category>\n<subcategory>ip-protocol</subcategory>\n<technology>network-protocol</technology>\n<risk>1</risk>\n<consume-big-bandwidth>no</consume-big-bandwidth>\n<able-to-transfer-file>no</able-to-transfer-file>\n<used-by-malware>no</used-by-malware>\n<evasive-behavior>no</evasive-behavior>\n<has-known-vulnerability>no</has-known-vulnerability>\n<pervasive-use>no</pervasive-use>\n<prone-to-misuse>no</prone-to-misuse>\n<tunnel-applications>no</tunnel-applications>\n<tunnel-other-application>no</tunnel-other-application>\n<data-ident>no</data-ident>\n<virus-ident>no</virus-ident>\n<file-type-ident>no</file-type-ident>\n<spyware-ident>no</spyware-ident>\n<default>\n<ident-by-ip-protocol>1</ident-by-ip-protocol>\n</default>\n</entry>','Custom appID to control icmp_any','4.0'),(3,'icmp_timestamp','appid','<entry name=\"icmp_timestamp\">\n<category>networking</category>\n<subcategory>ip-protocol</subcategory>\n<technology>network-protocol</technology>\n<risk>1</risk>\n<consume-big-bandwidth>no</consume-big-bandwidth>\n<able-to-transfer-file>no</able-to-transfer-file>\n<used-by-malware>no</used-by-malware>\n<evasive-behavior>no</evasive-behavior>\n<has-known-vulnerability>no</has-known-vulnerability>\n<pervasive-use>no</pervasive-use>\n<prone-to-misuse>no</prone-to-misuse>\n<tunnel-applications>no</tunnel-applications>\n<tunnel-other-application>no</tunnel-other-application>\n<data-ident>no</data-ident>\n<virus-ident>no</virus-ident>\n<file-type-ident>no</file-type-ident>\n<spyware-ident>no</spyware-ident>\n<default>\n<ident-by-icmp-type>13</ident-by-icmp-type>\n</default>\n</entry>','Custom appID to control icmp_timestamp','4.0'),(4,'icmp_info','appid','<entry name=\"icmp_info\">\n<category>networking</category>\n<subcategory>ip-protocol</subcategory>\n<technology>network-protocol</technology>\n<risk>1</risk>\n<consume-big-bandwidth>no</consume-big-bandwidth>\n<able-to-transfer-file>no</able-to-transfer-file>\n<used-by-malware>no</used-by-malware>\n<evasive-behavior>no</evasive-behavior>\n<has-known-vulnerability>no</has-known-vulnerability>\n<pervasive-use>no</pervasive-use>\n<prone-to-misuse>no</prone-to-misuse>\n<tunnel-applications>no</tunnel-applications>\n<tunnel-other-application>no</tunnel-other-application>\n<data-ident>no</data-ident>\n<virus-ident>no</virus-ident>\n<file-type-ident>no</file-type-ident>\n<spyware-ident>no</spyware-ident>\n<default>\n<ident-by-icmp-type>15</ident-by-icmp-type>\n</default>\n</entry>','Custom appID to control icmp_info','4.0'),(5,'icmp_address_mask','appid','<entry name=\"icmp_address_mask\">\n<category>networking</category>\n<subcategory>ip-protocol</subcategory>\n<technology>network-protocol</technology>\n<risk>1</risk>\n<consume-big-bandwidth>no</consume-big-bandwidth>\n<able-to-transfer-file>no</able-to-transfer-file>\n<used-by-malware>no</used-by-malware>\n<evasive-behavior>no</evasive-behavior>\n<has-known-vulnerability>no</has-known-vulnerability>\n<pervasive-use>no</pervasive-use>\n<prone-to-misuse>no</prone-to-misuse>\n<tunnel-applications>no</tunnel-applications>\n<tunnel-other-application>no</tunnel-other-application>\n<data-ident>no</data-ident>\n<virus-ident>no</virus-ident>\n<file-type-ident>no</file-type-ident>\n<spyware-ident>no</spyware-ident>\n<default>\n<ident-by-icmp-type>17</ident-by-icmp-type>\n</default>\n</entry>','Custom appID to control icmp_address_mask','4.0'),(6,'icmp_redirect','appid','<entry name=\"icmp_redirect\">\n<category>networking</category>\n<subcategory>ip-protocol</subcategory>\n<technology>network-protocol</technology>\n<risk>1</risk>\n<consume-big-bandwidth>no</consume-big-bandwidth>\n<able-to-transfer-file>no</able-to-transfer-file>\n<used-by-malware>no</used-by-malware>\n<evasive-behavior>no</evasive-behavior>\n<has-known-vulnerability>no</has-known-vulnerability>\n<pervasive-use>no</pervasive-use>\n<prone-to-misuse>no</prone-to-misuse>\n<tunnel-applications>no</tunnel-applications>\n<tunnel-other-application>no</tunnel-other-application>\n<data-ident>no</data-ident>\n<virus-ident>no</virus-ident>\n<file-type-ident>no</file-type-ident>\n<spyware-ident>no</spyware-ident>\n<default>\n<ident-by-icmp-type>5</ident-by-icmp-type>\n</default>\n</entry>','Custom appID to control icmp_redirect','4.0'),(7,'icmp_destination_unreachable','appid','<entry name=\"icmp_destination_unreachable\">\n<category>networking</category>\n<subcategory>ip-protocol</subcategory>\n<technology>network-protocol</technology>\n<risk>1</risk>\n<consume-big-bandwidth>no</consume-big-bandwidth>\n<able-to-transfer-file>no</able-to-transfer-file>\n<used-by-malware>no</used-by-malware>\n<evasive-behavior>no</evasive-behavior>\n<has-known-vulnerability>no</has-known-vulnerability>\n<pervasive-use>no</pervasive-use>\n<prone-to-misuse>no</prone-to-misuse>\n<tunnel-applications>no</tunnel-applications>\n<tunnel-other-application>no</tunnel-other-application>\n<data-ident>no</data-ident>\n<virus-ident>no</virus-ident>\n<file-type-ident>no</file-type-ident>\n<spyware-ident>no</spyware-ident>\n<default>\n<ident-by-icmp-type>3</ident-by-icmp-type>\n</default>\n</entry>','Custom appID to control icmp_destination_unreachable','4.0'),(8,'icmp_time_exceeded','appid','<entry name=\"icmp_time_exceeded\">\n<category>networking</category>\n<subcategory>ip-protocol</subcategory>\n<technology>network-protocol</technology>\n<risk>1</risk>\n<consume-big-bandwidth>no</consume-big-bandwidth>\n<able-to-transfer-file>no</able-to-transfer-file>\n<used-by-malware>no</used-by-malware>\n<evasive-behavior>no</evasive-behavior>\n<has-known-vulnerability>no</has-known-vulnerability>\n<pervasive-use>no</pervasive-use>\n<prone-to-misuse>no</prone-to-misuse>\n<tunnel-applications>no</tunnel-applications>\n<tunnel-other-application>no</tunnel-other-application>\n<data-ident>no</data-ident>\n<virus-ident>no</virus-ident>\n<file-type-ident>no</file-type-ident>\n<spyware-ident>no</spyware-ident>\n<default>\n<ident-by-icmp-type>11</ident-by-icmp-type>\n</default>\n</entry>','Custom appID to control icmp_time_exceeded','4.0'),(9,'icmp_echo_reply','appid','<entry name=\"icmp_echo_reply\">\n<category>networking</category>\n<subcategory>ip-protocol</subcategory>\n<technology>network-protocol</technology>\n<risk>1</risk>\n<consume-big-bandwidth>no</consume-big-bandwidth>\n<able-to-transfer-file>no</able-to-transfer-file>\n<used-by-malware>no</used-by-malware>\n<evasive-behavior>no</evasive-behavior>\n<has-known-vulnerability>no</has-known-vulnerability>\n<pervasive-use>no</pervasive-use>\n<prone-to-misuse>no</prone-to-misuse>\n<tunnel-applications>no</tunnel-applications>\n<tunnel-other-application>no</tunnel-other-application>\n<data-ident>no</data-ident>\n<virus-ident>no</virus-ident>\n<file-type-ident>no</file-type-ident>\n<spyware-ident>no</spyware-ident>\n<default>\n<ident-by-icmp-type>0</ident-by-icmp-type>\n</default>\n</entry>','Custom appID to control icmp_echo_reply','4.0'),(10,'icmp_echo','appid','<entry name=\"icmp_echo\">\n<category>networking</category>\n<subcategory>ip-protocol</subcategory>\n<technology>network-protocol</technology>\n<risk>1</risk>\n<consume-big-bandwidth>no</consume-big-bandwidth>\n<able-to-transfer-file>no</able-to-transfer-file>\n<used-by-malware>no</used-by-malware>\n<evasive-behavior>no</evasive-behavior>\n<has-known-vulnerability>no</has-known-vulnerability>\n<pervasive-use>no</pervasive-use>\n<prone-to-misuse>no</prone-to-misuse>\n<tunnel-applications>no</tunnel-applications>\n<tunnel-other-application>no</tunnel-other-application>\n<data-ident>no</data-ident>\n<virus-ident>no</virus-ident>\n<file-type-ident>no</file-type-ident>\n<spyware-ident>no</spyware-ident>\n<default>\n<ident-by-icmp-type>8</ident-by-icmp-type>\n</default>\n</entry>','Custom appID to control icmp_echo','4.0'),(11,'Profile_AV_Default','av_profile','<entry name=\"AV_Profile\"><decoder><entry name=\"ftp\"><action>default</action><wildfire-action>default</wildfire-action></entry><entry name=\"http\"><action>default</action><wildfire-action>default</wildfire-action></entry><entry name=\"imap\"><action>default</action><wildfire-action>default</wildfire-action></entry><entry name=\"pop3\"><action>default</action><wildfire-action>default</wildfire-action></entry><entry name=\"smb\"><action>default</action><wildfire-action>default</wildfire-action></entry><entry name=\"smtp\"><action>default</action><wildfire-action>default</wildfire-action></entry></decoder><description>Profile AV</description><packet-capture>yes</packet-capture></entry>','Av template','5.0'),(16,'Logs2Panorama','log_profile','<entry name=\"Logs2Panorama\">\n<traffic>\n<any>\n<send-to-panorama>yes</send-to-panorama>\n</any>\n</traffic>\n<alarm>\n<critical>\n<send-to-panorama>yes</send-to-panorama>\n</critical>\n<high>\n<send-to-panorama>yes</send-to-panorama>\n</high>\n<medium>\n<send-to-panorama>yes</send-to-panorama>\n</medium>\n<low>\n<send-to-panorama>yes</send-to-panorama>\n</low>\n<informational>\n<send-to-panorama>yes</send-to-panorama>\n</informational>\n</alarm>\n</entry>','Log Forwarding Profile','5.0');
/*!40000 ALTER TABLE `snippets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `snippets_type`
--

DROP TABLE IF EXISTS `snippets_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `snippets_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `description` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `snippets_type`
--

LOCK TABLES `snippets_type` WRITE;
/*!40000 ALTER TABLE `snippets_type` DISABLE KEYS */;
INSERT INTO `snippets_type` VALUES (1,'appid','Custom appID signatures'),(2,'url_profile','URL Profiles'),(3,'av_profile','AV Profiles'),(4,'ips_profile','IPS Profiles'),(5,'file_profile','FILE Profiles'),(6,'log_profile','LOG Profiles'),(7,'custom_report','Custom Reports'),(8,'address','Predefined Address'),(9,'services','Predefined Services'),(10,'All','All Types'),(11,'management_profile','Interface Management Profiles'),(12,'applications_groups','Applications Groups'),(13,'wildfire_profile','Wildfire Profile');
/*!40000 ALTER TABLE `snippets_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `updates`
--

DROP TABLE IF EXISTS `updates`;
CREATE TABLE `updates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `datetime` datetime DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `updates`
--

LOCK TABLES `updates` WRITE;
/*!40000 ALTER TABLE `updates` DISABLE KEYS */;
INSERT INTO `updates` VALUES (1,'2015-02-10 19:59:01','1230201401_alter_table_interfaces.common'),(2,'2015-02-10 19:59:02','2015020500_add_table_platforms.pandb'),(3,'2015-02-10 19:59:02','1222201401_vr_support_panos6.common'),(4,'2015-02-10 19:59:02','1231201401_alter_table_interfaces.common'),(5,'2015-02-10 19:59:02','1230201402_alter_table_interfaces.common'),(6,'2015-02-10 19:59:02','2015020200_alter_table_virtualrouters_multicast.common'),(7,'2015-02-10 19:59:02','2015012600_alter_output_mapping.common'),(8,'2015-02-10 19:59:02','12302014_alter_table_interfaces.common'),(9,'2015-02-10 19:59:02','2015012800_add_table_updates_proxy.pandb'),(10,'2015-02-10 19:59:02','20150105_1_alter_table_interfaces.common'),(11,'2015-02-10 19:59:02','20150105_create_table_vwires.common'),(12,'2015-02-10 19:59:02','1222201401_add_manegement_to_devices.pandb'),(13,'2015-02-10 19:59:03','2015020900_add_table_device_usage.common'),(14,'2015-02-10 19:59:03','2015020501_add_table_panos_capacity.pandb'),(15,'2015-02-10 19:59:03','2015012100_alter_table_externals.common'),(16,'2015-02-10 19:59:03','12242014_add_table_management_profile.common'),(17,'2015-02-10 20:08:17','2015021000_add_content_panos_capacity.pandb'),(18,'2015-02-13 16:13:25','2015021100_alter_table_interfaces_add_netflowprofile.common'),(19,'2015-02-13 16:13:25','2015021200_add_snippet_type_management_profile.pandb');
/*!40000 ALTER TABLE `updates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `updates_proxy`
--

DROP TABLE IF EXISTS `updates_proxy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_proxy` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `hostname` varchar(255) NOT NULL,
  `port` int(11) NOT NULL,
  `protocol` varchar(45) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `updates_proxy`
--

LOCK TABLES `updates_proxy` WRITE;
/*!40000 ALTER TABLE `updates_proxy` DISABLE KEYS */;
/*!40000 ALTER TABLE `updates_proxy` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-02-16 20:26:21


