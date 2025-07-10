-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: shoes_db
-- ------------------------------------------------------
-- Server version	8.4.5

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
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `product_variant_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_product_variant_id_foreign` (`product_variant_id`),
  KEY `cart_order_id_foreign` (`order_id`),
  CONSTRAINT `cart_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `cart_product_variant_id_foreign` FOREIGN KEY (`product_variant_id`) REFERENCES `singleproduct` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Sneakers','Scarpe casual e versatili'),(2,'Running','Scarpe da corsa performanti'),(3,'Trekking','Scarpe per escursionismo'),(4,'Eleganti','Scarpe formali da uomo e donna'),(5,'Casual','Scarpe per uso quotidiano'),(6,'Basket','Scarpe da basket professionali'),(7,'Calcio','Scarpe da calcio'),(8,'Trail','Scarpe per percorsi sterrati'),(9,'Sandali','Scarpe aperte estive'),(10,'Invernali','Scarpe calde per l’inverno'),(11,'Tennis','Scarpe da tennis'),(12,'Lifestyle','Moda urbana'),(13,'Minimal','Scarpe barefoot/minimaliste'),(14,'Waterproof','Scarpe impermeabili'),(15,'Slip-on','Scarpe senza lacci');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupon_redemptions`
--

DROP TABLE IF EXISTS `coupon_redemptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupon_redemptions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) DEFAULT NULL,
  `coupon_id` int DEFAULT NULL,
  `redemption_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `coupon_redemptions_email_coupon_id_unique` (`email`,`coupon_id`),
  KEY `coupon_redemptions_coupon_id_foreign` (`coupon_id`),
  CONSTRAINT `coupon_redemptions_coupon_id_foreign` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupon_redemptions`
--

LOCK TABLES `coupon_redemptions` WRITE;
/*!40000 ALTER TABLE `coupon_redemptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `coupon_redemptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupons`
--

DROP TABLE IF EXISTS `coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `description` text,
  `discount_type` varchar(20) NOT NULL,
  `discount_value` decimal(10,2) NOT NULL,
  `min_order_amount` decimal(10,2) DEFAULT NULL,
  `max_uses` int DEFAULT NULL,
  `used_count` int DEFAULT NULL,
  `start_date` timestamp NULL DEFAULT NULL,
  `end_date` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `coupons_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupons`
--

LOCK TABLES `coupons` WRITE;
/*!40000 ALTER TABLE `coupons` DISABLE KEYS */;
INSERT INTO `coupons` VALUES (1,'WELCOME10','10% di sconto per nuovi clienti','percent',10.00,50.00,100,0,'2025-07-09 14:49:33','2025-08-08 14:49:33',1),(2,'FREESHIP','Spedizione gratuita sopra 80€','fixed',5.00,80.00,200,10,'2025-07-09 14:49:33','2025-09-07 14:49:33',1),(3,'RUNNER15','15% su scarpe da running','percent',15.00,90.00,50,5,'2025-07-09 14:49:33','2025-07-29 14:49:33',1),(4,'TREK20','20€ su scarpe da trekking','fixed',20.00,120.00,30,7,'2025-07-09 14:49:33','2025-08-03 14:49:33',1),(5,'ELEGANT5','5% su scarpe eleganti','percent',5.00,70.00,80,9,'2025-07-09 14:49:33','2025-08-18 14:49:33',1);
/*!40000 ALTER TABLE `coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_coupons`
--

DROP TABLE IF EXISTS `order_coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_coupons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `coupon_id` int DEFAULT NULL,
  `discount_applied` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_coupons_order_id_foreign` (`order_id`),
  KEY `order_coupons_coupon_id_foreign` (`coupon_id`),
  CONSTRAINT `order_coupons_coupon_id_foreign` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`),
  CONSTRAINT `order_coupons_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_coupons`
--

LOCK TABLES `order_coupons` WRITE;
/*!40000 ALTER TABLE `order_coupons` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(100) DEFAULT NULL,
  `customer_email` varchar(100) DEFAULT NULL,
  `customer_address` text,
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(50) DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `payment_date` timestamp NULL DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `method` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payments_order_id_foreign` (`order_id`),
  CONSTRAINT `payments_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `description` text,
  `brand` varchar(50) DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `base_price` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `products_category_id_foreign` (`category_id`),
  CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'AirFlex One','Sneakers leggere e traspiranti','UrbanStep',1,79.99,'2025-07-09 14:48:23'),(2,'SpeedRun X','Scarpa running ultra leggera','RunFit',2,99.90,'2025-07-09 14:48:23'),(3,'TrekKing Pro','Scarpa da trekking impermeabile','HikeMaster',3,129.00,'2025-07-09 14:48:23'),(4,'Classic Derby','Scarpa elegante in pelle','GentStyle',4,119.90,'2025-07-09 14:48:23'),(5,'Relax Casual','Scarpa comoda per ogni giorno','FeetFree',5,69.90,'2025-07-09 14:48:23'),(6,'SkyDunk','Scarpa alta da basket','JumpMax',6,139.99,'2025-07-09 14:48:23'),(7,'GoalPro 22','Scarpa calcio con tacchetti','KickPro',7,89.90,'2025-07-09 14:48:23'),(8,'TrailGrip Z','Perfetta per sentieri sterrati','GripGear',8,109.50,'2025-07-09 14:48:23'),(9,'SunStep','Sandalo estivo traspirante','BreezeWalk',9,49.90,'2025-07-09 14:48:23'),(10,'IceWalk','Scarpa invernale foderata','NorthFeet',10,119.00,'2025-07-09 14:48:23'),(11,'CourtAce','Scarpa stabile da tennis','AceFit',11,89.00,'2025-07-09 14:48:23'),(12,'CityWave','Stile urbano e comfort','MetroStyle',12,74.50,'2025-07-09 14:48:23'),(13,'BareMove','Scarpa barefoot flessibile','FreeToes',13,84.00,'2025-07-09 14:48:23'),(14,'StormShield','Scarpa impermeabile urbana','RainStep',14,94.90,'2025-07-09 14:48:23'),(15,'SlipMax','Slip-on comodo e rapido','FastWear',15,59.00,'2025-07-09 14:48:23');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipping`
--

DROP TABLE IF EXISTS `shipping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipping` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `shipping_address` text,
  `shipped_date` timestamp NULL DEFAULT NULL,
  `delivery_date` timestamp NULL DEFAULT NULL,
  `tracking_number` varchar(100) DEFAULT NULL,
  `carrier` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shipping_order_id_foreign` (`order_id`),
  CONSTRAINT `shipping_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipping`
--

LOCK TABLES `shipping` WRITE;
/*!40000 ALTER TABLE `shipping` DISABLE KEYS */;
/*!40000 ALTER TABLE `shipping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `singleproduct`
--

DROP TABLE IF EXISTS `singleproduct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `singleproduct` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `size` varchar(10) DEFAULT NULL,
  `sku` varchar(50) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `stock` int DEFAULT NULL,
  `image` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `singleproduct_sku_unique` (`sku`),
  KEY `singleproduct_product_id_foreign` (`product_id`),
  CONSTRAINT `singleproduct_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `singleproduct`
--

LOCK TABLES `singleproduct` WRITE;
/*!40000 ALTER TABLE `singleproduct` DISABLE KEYS */;
INSERT INTO `singleproduct` VALUES (1,1,'Bianco','42','AIRFLEX-WHT-42',79.99,20,'airflex_white_42.jpg'),(2,1,'Nero','43','AIRFLEX-BLK-43',79.99,15,'airflex_black_43.jpg'),(3,2,'Blu','41','SPEED-BLU-41',99.90,10,'speedrun_blue_41.jpg'),(4,3,'Marrone','44','TREK-MAR-44',129.00,7,'trekkingpro_brown_44.jpg'),(5,4,'Nero','43','DERBY-BLK-43',119.90,9,'classicderby_black_43.jpg'),(6,5,'Grigio','42','RELAX-GRY-42',69.90,12,'relaxcasual_gray_42.jpg'),(7,6,'Rosso','45','DUNK-RED-45',139.99,6,'skydunk_red_45.jpg'),(8,7,'Verde','44','GOAL-GRN-44',89.90,11,'goalpro_green_44.jpg'),(9,8,'Nero','43','TRAIL-BLK-43',109.50,8,'trailgrip_black_43.jpg'),(10,9,'Beige','41','SUN-BEI-41',49.90,18,'sunstep_beige_41.jpg'),(11,10,'Blu','44','ICEWALK-BLU-44',119.00,10,'icewalk_blue_44.jpg'),(12,11,'Bianco','42','COURT-WHT-42',89.00,12,'courtace_white_42.jpg'),(13,12,'Rosso','43','CITY-RD-43',74.50,15,'citywave_red_43.jpg'),(14,13,'Nudo','41','BAREMV-NUD-41',84.00,9,'baremove_nude_41.jpg'),(15,14,'Nero','42','STORM-BLK-42',94.90,11,'stormshield_black_42.jpg'),(16,15,'Blu','42','SLIP-BLU-42',59.00,14,'slipmax_blue_42.jpg'),(17,3,'Grigio','43','TREK-GRY-43',129.00,5,'trekkingpro_gray_43.jpg'),(18,6,'Bianco','44','DUNK-WHT-44',139.99,7,'skydunk_white_44.jpg'),(19,2,'Giallo','42','SPEED-YLW-42',99.90,6,'speedrun_yellow_42.jpg'),(20,13,'Grigio','42','BAREMV-GRY-42',84.00,8,'baremove_gray_42.jpg'),(21,10,'Nero','43','ICEWALK-BLK-43',119.00,10,'icewalk_black_43.jpg');
/*!40000 ALTER TABLE `singleproduct` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-09 16:54:14
