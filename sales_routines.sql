-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: sales
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
-- Temporary view structure for view `sales_analysis`
--

DROP TABLE IF EXISTS `sales_analysis`;
/*!50001 DROP VIEW IF EXISTS `sales_analysis`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `sales_analysis` AS SELECT 
 1 AS `Order_Line`,
 1 AS `Order_ID`,
 1 AS `Order_Date`,
 1 AS `Ship_Date`,
 1 AS `Ship_Mode`,
 1 AS `Customer_ID`,
 1 AS `Product_ID`,
 1 AS `Sales`,
 1 AS `Quantity`,
 1 AS `Discount`,
 1 AS `Profit`,
 1 AS `Product_Name`,
 1 AS `Category`,
 1 AS `Sub_Category`,
 1 AS `Customer_Name`,
 1 AS `Segment`,
 1 AS `Age`,
 1 AS `Region`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `sales_performance_category`
--

DROP TABLE IF EXISTS `sales_performance_category`;
/*!50001 DROP VIEW IF EXISTS `sales_performance_category`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `sales_performance_category` AS SELECT 
 1 AS `Category`,
 1 AS `Total_Sales`,
 1 AS `Total_Profit`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `sales_performance_region`
--

DROP TABLE IF EXISTS `sales_performance_region`;
/*!50001 DROP VIEW IF EXISTS `sales_performance_region`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `sales_performance_region` AS SELECT 
 1 AS `Region`,
 1 AS `Total_Sales`,
 1 AS `Total_Profit`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `sales_analysis`
--

/*!50001 DROP VIEW IF EXISTS `sales_analysis`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `sales_analysis` AS select `s`.`Order_Line` AS `Order_Line`,`s`.`Order_ID` AS `Order_ID`,`s`.`Order_Date` AS `Order_Date`,`s`.`Ship_Date` AS `Ship_Date`,`s`.`Ship_Mode` AS `Ship_Mode`,`s`.`Customer_ID` AS `Customer_ID`,`s`.`Product_ID` AS `Product_ID`,`s`.`Sales` AS `Sales`,`s`.`Quantity` AS `Quantity`,`s`.`Discount` AS `Discount`,`s`.`Profit` AS `Profit`,`p`.`Product_Name` AS `Product_Name`,`p`.`Category` AS `Category`,`p`.`Sub_Category` AS `Sub_Category`,`c`.`Customer_Name` AS `Customer_Name`,`c`.`Segment` AS `Segment`,`c`.`Age` AS `Age`,`c`.`Region` AS `Region` from ((`sales` `s` join `customers` `c` on((`s`.`Customer_ID` = `c`.`Customer_ID`))) join `products` `p` on((`s`.`Product_ID` = `p`.`Product_ID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `sales_performance_category`
--

/*!50001 DROP VIEW IF EXISTS `sales_performance_category`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `sales_performance_category` AS select `sales_analysis`.`Category` AS `Category`,sum(`sales_analysis`.`Sales`) AS `Total_Sales`,sum(`sales_analysis`.`Profit`) AS `Total_Profit` from `sales_analysis` group by `sales_analysis`.`Category` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `sales_performance_region`
--

/*!50001 DROP VIEW IF EXISTS `sales_performance_region`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `sales_performance_region` AS select `sales_analysis`.`Region` AS `Region`,sum(`sales_analysis`.`Sales`) AS `Total_Sales`,sum(`sales_analysis`.`Profit`) AS `Total_Profit` from `sales_analysis` group by `sales_analysis`.`Region` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping routines for database 'sales'
--
/*!50003 DROP PROCEDURE IF EXISTS `generate_categorical_report` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `generate_categorical_report`()
BEGIN
    SELECT * FROM sales_performance_category;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `generate_regional_report` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `generate_regional_report`()
BEGIN
    SELECT * FROM sales_performance_region;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-13 21:33:59
