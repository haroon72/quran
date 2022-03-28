-- MariaDB dump 10.17  Distrib 10.4.11-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: test
-- ------------------------------------------------------
-- Server version	10.4.18-MariaDB

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
-- Dumping routines for database 'test'
--

--
-- Temporary table structure for view `quran_view`
--

DROP TABLE IF EXISTS `quran_view`;
/*!50001 DROP VIEW IF EXISTS `quran_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `quran_view` (
  `id` tinyint NOT NULL,
  `english` tinyint NOT NULL,
  `token` tinyint NOT NULL,
  `verse` tinyint NOT NULL,
  `chapter` tinyint NOT NULL,
  `root_word` tinyint NOT NULL,
  `buckwalter` tinyint NOT NULL,
  `type` tinyint NOT NULL,
  `type_detail` tinyint NOT NULL,
  `verse_text` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `quran-view`
--

DROP TABLE IF EXISTS `quran-view`;
/*!50001 DROP VIEW IF EXISTS `quran-view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `quran-view` (
  `english` tinyint NOT NULL,
  `token` tinyint NOT NULL,
  `verse` tinyint NOT NULL,
  `chapter` tinyint NOT NULL,
  `root_word` tinyint NOT NULL,
  `buckwalter` tinyint NOT NULL,
  `type` tinyint NOT NULL,
  `type_detail` tinyint NOT NULL,
  `verse_text` tinyint NOT NULL,
  `id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `quran_view`
--

/*!50001 DROP TABLE IF EXISTS `quran_view`*/;
/*!50001 DROP VIEW IF EXISTS `quran_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `quran_view` AS select `quran_detail`.`id` AS `id`,`quran`.`english` AS `english`,`quran`.`token` AS `token`,`quran`.`verse` AS `verse`,`quran`.`chapter` AS `chapter`,`quran`.`root_word` AS `root_word`,`quran`.`buckwalter` AS `buckwalter`,`quran_detail`.`type` AS `type`,`quran_detail`.`type_detail_v2` AS `type_detail`,`verse`.`verse_text` AS `verse_text` from ((`quran` left join `quran_detail` on(`quran`.`id` = `quran_detail`.`quran_id`)) left join `verse` on(`quran`.`verse` = `verse`.`verse` and `quran`.`chapter` = `verse`.`chapter`)) order by `quran`.`chapter`,`quran`.`verse`,`quran`.`token` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `quran-view`
--

/*!50001 DROP TABLE IF EXISTS `quran-view`*/;
/*!50001 DROP VIEW IF EXISTS `quran-view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `quran-view` AS select `quran`.`english` AS `english`,`quran`.`token` AS `token`,`quran`.`verse` AS `verse`,`quran`.`chapter` AS `chapter`,`quran`.`root_word` AS `root_word`,`quran`.`buckwalter` AS `buckwalter`,`quran_detail`.`type` AS `type`,`quran_detail`.`type_detail` AS `type_detail`,`verse`.`verse_text` AS `verse_text`,`quran_detail`.`id` AS `id` from ((`quran` left join `quran_detail` on(`quran`.`id` = `quran_detail`.`quran_id`)) left join `verse` on(`quran`.`verse` = `verse`.`verse` and `quran`.`chapter` = `verse`.`chapter`)) order by `quran`.`chapter`,`quran`.`verse`,`quran`.`token` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping events for database 'test'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-28  6:34:29
