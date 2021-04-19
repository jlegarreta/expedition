-- MySQL dump 10.16  Distrib 10.1.14-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: pandbRBAC
-- ------------------------------------------------------
-- Server version	10.1.14-MariaDB

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
DROP TABLE IF EXISTS `auditlogs`;
CREATE TABLE `auditlogs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(45) NOT NULL,
  `level` int(11) NOT NULL,
  `task` varchar(50) NOT NULL,
  `message` text NOT NULL,
  `action` text NOT NULL,
  `fixed` int(1) NOT NULL DEFAULT '0',
  `datetime` datetime NOT NULL,
  `obj_type` varchar(75) NOT NULL,
  `obj_id` int(11) NOT NULL,
  `obj_table` varchar(75) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `index1` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `updates`;
CREATE TABLE `updates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `datetime` datetime DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
--
-- Table structure for table `activations`
--
-- DROP TABLE IF EXISTS `ml_settings`;
CREATE TABLE `ml_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server` varchar(255) DEFAULT '127.0.0.1',
  `parquetPath` VARCHAR(255) NULL DEFAULT '/data',
  `tempDataPath` VARCHAR(255) NULL DEFAULT '/data',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- DROP TABLE IF EXISTS `activations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `completed` tinyint(1) NOT NULL DEFAULT '0',
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `activations` WRITE;
/*!40000 ALTER TABLE `activations` DISABLE KEYS */;
INSERT INTO `activations` VALUES (1,1,'CZ7PnoTpD7pZJUzrh3c5QqHUN0ELijot',1,'2016-03-21 23:25:26','2016-03-21 23:25:26','2016-03-21 23:25:26');
/*!40000 ALTER TABLE `activations` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

--
-- Table structure for table `curlConnections`
--

-- DROP TABLE IF EXISTS `curlConnections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `curlConnections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `origin` varchar(255) NOT NULL,
  `destination` varchar(255) NOT NULL,
  `hostedConnections` int(11) NOT NULL DEFAULT '0',
  `status` varchar(45) NOT NULL DEFAULT 'Invalid',
  `created_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `connectionPos` varchar(255) NOT NULL,
  `connection` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `device_keys`
--

-- DROP TABLE IF EXISTS `device_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_keys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_id` int(10) unsigned NOT NULL,
  `key_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `api_key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `role` varchar(45) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'admin',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


-- DROP TABLE IF EXISTS `licenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `licenses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `feature` varchar(255) DEFAULT NULL,
  `issued` datetime DEFAULT NULL,
  `expires` datetime DEFAULT NULL,
  `expired` varchar(3) DEFAULT 'no',
  `device_id` varchar(45) DEFAULT NULL,
  `serial` varchar(255) NOT NULL,
  `baselicensename` varchar(1024) DEFAULT NULL,
  `authcode` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `devices`
--

-- DROP TABLE IF EXISTS `devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devices` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `devicename` varchar(255) NOT NULL,
  `hostname` varchar(255) NOT NULL,
  `port` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `panos` varchar(255) NOT NULL,
  `threats` tinyint(4) NOT NULL,
  `apps` tinyint(4) NOT NULL,
  `ispanorama` tinyint(4) NOT NULL,
  `config` tinyint(4) NOT NULL,
  `serial` varchar(255) NOT NULL,
  `serialHA` TEXT NULL,
  `vsys` varchar(255) NOT NULL,
  `appversion` varchar(255) NOT NULL,
  `appreleasedate` datetime NOT NULL,
  `threatversion` varchar(255) NOT NULL,
  `threatreleasedate` datetime NOT NULL,
  `device` varchar(255) DEFAULT NULL,
  `management` varchar(255) DEFAULT '',
  `urldb` varchar(255) DEFAULT NULL,
  `connected` varchar(3) DEFAULT NULL,
  `deactivated` varchar(3) DEFAULT NULL,
  `wildfireversion` varchar(255) DEFAULT  NULL,
  `uptime` varchar(255) DEFAULT NULL,
  `avversion` varchar(255) DEFAULT NULL,
  `urlfilteringversion` varchar(255) DEFAULT NULL,
  `logtype` varchar(255) DEFAULT NULL,
  `csv_path` varchar(1024) DEFAULT '',
  `avoidToday` TINYINT NOT NULL DEFAULT 0 ,
  `afterProcess` VARCHAR(45) NULL DEFAULT 'Nothing',
  `autoProcessCSV` tinyint(4) not NULL DEFAULT 0,

  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
--
-- Table structure for table `jobs`
--

-- DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(45) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `completed` int(11) DEFAULT '0',
  `failed` int(11) DEFAULT '0',
  `tasks` int(11) NOT NULL DEFAULT '0',
  `parentType` varchar(45) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `description` TEXT DEFAULT NULL,
  `parentJob` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1024 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `logs`
--

-- DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL,
  `msg` text,
  `logCode` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `persistences`
--

-- DROP TABLE IF EXISTS `persistences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `persistences` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `persistences_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=203682 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_devices`
--

-- DROP TABLE IF EXISTS `project_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_devices` (
  `project_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `device_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `selectedBy` tinytext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`project_name`,`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projects`
--

-- DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `vendors` varchar(255) NOT NULL,
  `tag` varchar(255) DEFAULT NULL,
  `progress` int(2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `appversion` varchar(255) DEFAULT NULL,
  `panos` varchar(255) DEFAULT NULL,
  `purpose` varchar(255) DEFAULT 'Migration',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reminders`
--

-- DROP TABLE IF EXISTS `reminders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reminders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `completed` tinyint(1) NOT NULL DEFAULT '0',
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `remote_LDAP_server`
--

-- DROP TABLE IF EXISTS `remote_LDAP_server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `remote_LDAP_server` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) NOT NULL,
  `port` int(11) DEFAULT NULL,
  `dn` text NOT NULL,
  `admin_user` varchar(255) DEFAULT NULL,
  `admin_password` varchar(255) DEFAULT NULL,
  `ldap_type` varchar(45) DEFAULT NULL,
  `uses_ssl` tinyint(4) NOT NULL DEFAULT '0',
  `uses_tls` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `name` varchar(45) NOT NULL,
  `account_suffix` varchar(255) DEFAULT NULL,
  `account_prefix` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `remote_Radius_server`
--

-- DROP TABLE IF EXISTS `remote_Radius_server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `remote_Radius_server` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) NOT NULL,
  `port` int(11) DEFAULT '1812',
  `shared_key` varchar(255) NOT NULL,
  `active` tinyint(4) DEFAULT '1',
  `name` varchar(45) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role_users`
--

-- DROP TABLE IF EXISTS `role_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_users` (
  `user_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `role_users` WRITE;
/*!40000 ALTER TABLE `role_users` DISABLE KEYS */;
INSERT INTO `role_users` VALUES (1,3,'2016-05-30 19:44:06','2016-05-30 19:44:06');
/*!40000 ALTER TABLE `role_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

--
-- Table structure for table `roles`
--

-- DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `permissions` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin','Admin','{\"user.update\":true, \"project.create\":true, \"device.create\":true}','2016-03-29 13:12:35','2016-03-29 13:12:35'),(2,'user','User','{\"user.view\":true}','2016-03-29 13:12:35','2016-03-29 13:12:35'),(3,'superuser','Super User','{\"user.create\":true,\"user.admin\":true,\"user.delete\":true, \"role.admin\":true, \"server.admin\":true, \"project.create\":true, \"project.admin\":true, \"device.admin\":true, \"expedition.admin\":true}','0000-00-00 00:00:00','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
--
-- Table structure for table `tasks`
--

-- DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` int(11) NOT NULL,
  `taskType` varchar(45) NOT NULL,
  `processCode` varchar(255) NOT NULL,
  `params` text NOT NULL,
  `statusCode` int(11) DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `statusMessage` text NOT NULL DEFAULT '',
  `taskName` VARCHAR(2000) NOT NULL DEFAULT 'Remote Task',
  `resultCode` varchar(255) DEFAULT NULL,
  `retry` int(11) DEFAULT NULL,
  `pid` INT(11) NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2090 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `throttle`
--

-- DROP TABLE IF EXISTS `throttle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `throttle` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `throttle_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_settings`
--

-- DROP TABLE IF EXISTS `user_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned DEFAULT NULL,
  `project_id` int(11) unsigned DEFAULT NULL,
  `selectedDevices` tinytext,
  `panos_vsys` varchar(45) DEFAULT NULL,
  `source` int(11) unsigned DEFAULT NULL,
  `panorama_template` int(11) unsigned DEFAULT NULL,
  `view` varchar(45) DEFAULT NULL,
  `panorama_rules` varchar(45) DEFAULT NULL,
  `selectedLogConnector` int(11) DEFAULT NULL,
  `selectedUIDConnector` int(11) DEFAULT NULL,
  `version` VARCHAR(45) NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

-- DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `permissions` text COLLATE utf8_unicode_ci,
  `last_login` timestamp NULL DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `location_id` int(10) NOT NULL DEFAULT '0',
  `location_type` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `timezone` varchar(60) CHARACTER SET utf8 NOT NULL,
  `active` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','$2y$10$Nk2/jJmmirfgfLLPEGJ7.erkiaVCgRGUZvSPi5wG/gg8SqYFBvYPO',NULL,'2016-09-21 11:45:25','adminim','Migration Tool admin us','2016-03-29 16:10:39','2016-09-21 11:45:25',0,'local','Europe/Amsterdam',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;


-- DROP TABLE IF EXISTS `sparkJobs`;
CREATE TABLE `sparkJobs` (
  `taskID` int(11) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `message` TEXT DEFAULT NULL,
  `timestamp` datetime DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- DROP TRIGGER IF EXISTS `update_job`;
DELIMITER //
CREATE trigger update_job
  after insert
  on pandbRBAC.sparkJobs for each row
begin
  -- Update the task
  update pandbRBAC.tasks set statusCode=IF(NEW.status='completed',1,IF(NEW.status='start',0.1,-1)),
                             statusMessage=NEW.message,
                             updated_at = NOW()
  where id=NEW.taskID;

  -- Update the direct Job where the task resides
  update pandbRBAC.jobs set completed=completed+ IF(NEW.status='completed' OR NEW.status='failed',1,0),
                            failed=failed+ IF(NEW.status='failed',1,0)
  where id=(select job_id
            from pandbRBAC.tasks
            where id=NEW.taskID);

  -- updating parent job
  update pandbRBAC.jobs set completed=completed+ IF(NEW.status='completed' OR NEW.status='failed',1,0),
                            failed=failed+ IF(NEW.status='failed',1,0)
  where id=
        (select * from (SELECT parentJob
                        FROM pandbRBAC.jobs
                        WHERE id= (select job_id from pandbRBAC.tasks where id=NEW.taskID))t);

end; //
DELIMITER ;

drop procedure IF EXISTS update_parentJobs;
DELIMITER //
CREATE PROCEDURE update_parentJobs(
	IN parentID_In INT(20)
)
BEGIN
  SET @query = '
    UPDATE jobs
    SET completed = ?,
        failed = ?
    WHERE id = ?';
  SET @co = (SELECT sum(completed) FROM jobs where parentJob= parentID_In);
  SET @fa = (SELECT sum(failed) FROM jobs where parentJob= parentID_In);
  SET @pa = parentID_In;
  PREPARE stmt FROM @query;
  EXECUTE stmt USING @co, @fa, @pa;
  DEALLOCATE PREPARE stmt;
END //
DELIMITER ;

-- DROP TRIGGER IF EXISTS `device_logs`;
CREATE TABLE `device_logs` (
  `id` INT(11)                  NOT NULL                            AUTO_INCREMENT,
  `device_serial` varchar(255)  NOT NULL,
  `log_name` TEXT               NOT NULL,
  `date` DATETIME DEFAULT NULL,
  `processed` DATETIME          NULL          DEFAULT '0000-00-00 00:00:00',
  `comment` VARCHAR(255)        NULL,
  `created_at` TIMESTAMP        NULL          DEFAULT NULL,
  `updated_at` TIMESTAMP        NULL          DEFAULT NULL,
  PRIMARY KEY (`id`));

-- Dump completed on 2016-09-21 15:13:37

CREATE TABLE `security` (
  `id` INT(11)              NOT NULL                                AUTO_INCREMENT,
  `type` VARCHAR(255)       NOT NULL,
  `lid` INT(11)             NOT NULL,
  `key` VARCHAR(255)        NOT NULL,
  `iv` VARCHAR(45)          NOT NULL DEFAULT 'l3tsB3$str0ng,a!',
  `created_at` TIMESTAMP    NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` TIMESTAMP    NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`));

CREATE TABLE `device_logsPerDay` (
  `id`          INT NOT NULL AUTO_INCREMENT,
  `serial`      VARCHAR(255)  NOT NULL,
  `serial_vsys` VARCHAR(255)  NOT NULL,
  `date`        DATETIME      NOT NULL DEFAULT '0000-00-00 00:00:00',
  `rule`        VARCHAR(255)  NOT NULL,
  `typology`    VARCHAR(255)  NOT NULL DEFAULT 'unassigned',
  `hits`        BIGINT        NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`));

CREATE TABLE `periodicTasks` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `createdBy` int(11) NOT NULL,
 `processCode` varchar(255) NOT NULL,
 `params` text NOT NULL,
 `description` varchar(1024) DEFAULT NULL,
 `frequency` varchar(45) NOT NULL DEFAULT 'daily',
 `executionTime` time NOT NULL DEFAULT '00:00:00',
 `active` tinyint(4) NOT NULL DEFAULT '1',
 `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
 `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
 `pid` int(11) DEFAULT NULL,
 `started_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
 `completed_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
 PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

