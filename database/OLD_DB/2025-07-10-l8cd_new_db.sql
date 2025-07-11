-- MySQL Dump Completo 10.13 Distrib 8.0.42
-- Host: localhost    Database: shoes_db
-- Server version 8.4.5

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


-- Disabilita temporaneamente i controlli di chiave esterna per consentire l'eliminazione delle tabelle in qualsiasi ordine
SET FOREIGN_KEY_CHECKS = 0;

-- Drop di tutte le tabelle esistenti per un inizio pulito
DROP TABLE IF EXISTS `cart`;
DROP TABLE IF EXISTS `coupon_redemptions`;
DROP TABLE IF EXISTS `order_coupons`;
DROP TABLE IF EXISTS `payments`;
DROP TABLE IF EXISTS `shipping`;
DROP TABLE IF EXISTS `singleproduct`;
DROP TABLE IF EXISTS `orders`;
DROP TABLE IF EXISTS `coupons`;
DROP TABLE IF EXISTS `products`;
DROP TABLE IF EXISTS `categories`;

-- Abilita nuovamente i controlli di chiave esterna
SET FOREIGN_KEY_CHECKS = 1;


--
-- Struttura della tabella `categories`
--

CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Inserimento dati per la tabella `categories`
--
INSERT INTO `categories` VALUES
(1,'Sneakers','Scarpe casual e versatili'),
(2,'Running','Scarpe da corsa performanti'),
(3,'Trekking','Scarpe per escursionismo'),
(4,'Eleganti','Scarpe formali da uomo e donna'),
(5,'Casual','Scarpe per uso quotidiano'),
(6,'Basket','Scarpe da basket professionali'),
(7,'Calcio','Scarpe da calcio'),
(8,'Trail','Scarpe per percorsi sterrati'),
(9,'Sandali','Scarpe aperte estive'),
(10,'Invernali','Scarpe calde per l’inverno'),
(11,'Tennis','Scarpe da tennis'),
(12,'Lifestyle','Moda urbana'),
(13,'Minimal','Scarpe barefoot/minimaliste'),
(14,'Waterproof','Scarpe impermeabili'),
(15,'Slip-on','Scarpe senza lacci');

--
-- Struttura della tabella `products`
--

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Struttura della tabella `singleproduct`
--

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Struttura della tabella `coupons`
--

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Struttura della tabella `orders`
--
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

--
-- Struttura della tabella `cart`
--
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

--
-- Struttura della tabella `coupon_redemptions`
--
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

--
-- Struttura della tabella `order_coupons`
--
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

--
-- Struttura della tabella `payments`
--
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

--
-- Struttura della tabella `shipping`
--
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

--
-- Inserimento dati per la tabella `coupons`
--
INSERT INTO `coupons` VALUES
(1,'WELCOME10','10% di sconto per nuovi clienti','percent',10.00,50.00,100,0,'2025-07-10 11:29:06','2025-08-09 11:29:06',1),
(2,'FREESHIP','Spedizione gratuita sopra 80€','fixed',5.00,80.00,200,10,'2025-07-10 11:29:06','2025-09-08 11:29:06',1),
(3,'RUNNER15','15% su scarpe da running','percent',15.00,90.00,50,5,'2025-07-10 11:29:06','2025-07-30 11:29:06',1),
(4,'TREK20','20€ su scarpe da trekking','fixed',20.00,120.00,30,7,'2025-07-10 11:29:06','2025-08-04 11:29:06',1),
(5,'ELEGANT5','5% su scarpe eleganti','percent',5.00,70.00,80,9,'2025-07-10 11:29:06','2025-08-19 11:29:06',1);


-- *** INSERIMENTO DEI PRODOTTI E DELLE LORO VARIANTI PER BRAND (ALMENO 5-7 PER BRAND) ***

-- Brand: UrbanStep (Sneakers, Lifestyle, Casual)
INSERT INTO `products` (`id`, `name`, `description`, `brand`, `category_id`, `base_price`) VALUES
(1,'UrbanStep AirFlex One','Sneakers leggere e traspiranti con ammortizzazione avanzata.','UrbanStep',1,79.99),
(2,'UrbanStep City Glide','Una scarpa lifestyle moderna e confortevole, ideale per l''uso quotidiano in città.','UrbanStep',12,85.00),
(3,'UrbanStep Daily Walker','Comoda scarpa casual per lunghe passeggiate, design essenziale.','UrbanStep',5,75.00),
(4,'UrbanStep Trendsetter','Sneaker di tendenza per il lifestyle metropolitano, dettagli premium.','UrbanStep',12,88.00),
(5,'UrbanStep Rain Guard','Scarpa impermeabile per affrontare ogni condizione meteo, stile urbano.','UrbanStep',14,105.00),
(6,'UrbanStep Sprinter','Scarpa leggera per la corsa urbana, ottimo ammortizzamento e reattività.','UrbanStep',2,90.00),
(7,'UrbanStep Comfy Slip','Mocassino slip-on ultra comodo e facile da indossare, ideale per il relax.','UrbanStep',15,65.00);

INSERT INTO `singleproduct` (`id`, `product_id`, `color`, `size`, `sku`, `price`, `stock`, `image`) VALUES
(1,1,'Bianco','42','US-AF1-WHT-42',79.99,20,'us_airflexone_white_42.jpg'),
(2,1,'Nero','43','US-AF1-BLK-43',79.99,15,'us_airflexone_black_43.jpg'),
(3,2,'Grigio','41','US-CG-GRY-41',85.00,25,'us_cityglide_gray_41.jpg'),
(4,2,'Bianco','44','US-CG-WHT-44',85.00,30,'us_cityglide_white_44.jpg'),
(5,3,'Blu','40','US-DW-BLU-40',75.00,28,'us_dailywalker_blue_40.jpg'),
(6,3,'Beige','42','US-DW-BEI-42',75.00,22,'us_dailywalker_beige_42.jpg'),
(7,4,'Rosso','45','US-TS-RED-45',88.00,18,'us_trendsetter_red_45.jpg'),
(8,4,'Nero','43','US-TS-BLK-43',88.00,12,'us_trendsetter_black_43.jpg'),
(9,5,'Verde Oliva','41','US-RG-OLV-41',105.00,10,'us_rainguard_olive_41.jpg'),
(10,5,'Marrone','44','US-RG-BRN-44',105.00,8,'us_rainguard_brown_44.jpg'),
(11,6,'Nero','42','US-SPR-BLK-42',90.00,20,'us_sprinter_black_42.jpg'),
(12,6,'Bianco','43','US-SPR-WHT-43',90.00,15,'us_sprinter_white_43.jpg'),
(13,7,'Grigio','40','US-CS-GRY-40',65.00,35,'us_comfyslip_gray_40.jpg'),
(14,7,'Blu Navy','41','US-CS-BLU-41',65.00,30,'us_comfyslip_blue_41.jpg');

-- Brand: RunFit (Running, Trail)
INSERT INTO `products` (`id`, `name`, `description`, `brand`, `category_id`, `base_price`) VALUES
(8,'RunFit SpeedRun X','Scarpa running ultra leggera con massima reattività.','RunFit',2,99.90),
(9,'RunFit Trail Blazer','Scarpa robusta per trail running, offre grip e protezione su terreni sconnessi.','RunFit',8,115.00),
(10,'RunFit Marathon Elite','Progettata per lunghe distanze, comfort e supporto eccezionali.','RunFit',2,130.00),
(11,'RunFit Sprint Pro','Scarpa da corsa con piastra in carbonio per velocità esplosiva.','RunFit',2,160.00),
(12,'RunFit Cross-Training Max','Versatile per allenamenti misti, stabile e flessibile.','RunFit',5,95.00),
(13,'RunFit Aqua Trail','Scarpa da trail con drenaggio rapido, ideale per percorsi bagnati.','RunFit',8,105.00),
(14,'RunFit Barefoot Flow','Scarpa minimalista che favorisce una corsa naturale e sensibile.','RunFit',13,80.00);

INSERT INTO `singleproduct` (`id`, `product_id`, `color`, `size`, `sku`, `price`, `stock`, `image`) VALUES
(15,8,'Blu','41','RF-SRX-BLU-41',99.90,10,'rf_speedrunx_blue_41.jpg'),
(16,8,'Nero','42','RF-SRX-BLK-42',99.90,12,'rf_speedrunx_black_42.jpg'),
(17,9,'Verde Acido','43','RF-TB-GRN-43',115.00,15,'rf_trailblazer_green_43.jpg'),
(18,9,'Grigio Scuro','42','RF-TB-GRY-42',115.00,10,'rf_trailblazer_gray_42.jpg'),
(19,10,'Bianco','44','RF-ME-WHT-44',130.00,8,'rf_marathonelite_white_44.jpg'),
(20,10,'Rosso','43','RF-ME-RED-43',130.00,7,'rf_marathonelite_red_43.jpg'),
(21,11,'Nero Fluo','42','RF-SP-NF-42',160.00,6,'rf_sprintpro_neonyellow_42.jpg'),
(22,11,'Blu Elettrico','41','RF-SP-BE-41',160.00,5,'rf_sprintpro_blue_41.jpg'),
(23,12,'Grigio','40','RF-CTM-GRY-40',95.00,18,'rf_crosstrainingmax_gray_40.jpg'),
(24,12,'Nero','41','RF-CTM-BLK-41',95.00,16,'rf_crosstrainingmax_black_41.jpg'),
(25,13,'Arancione','43','RF-AT-ORN-43',105.00,10,'rf_aquatrail_orange_43.jpg'),
(26,13,'Blu','44','RF-AT-BLU-44',105.00,9,'rf_aquatrail_blue_44.jpg'),
(27,14,'Nero','39','RF-BF-BLK-39',80.00,20,'rf_barefootflow_black_39.jpg'),
(28,14,'Grigio','40','RF-BF-GRY-40',80.00,18,'rf_barefootflow_gray_40.jpg');

-- Brand: HikeMaster (Trekking, Waterproof)
INSERT INTO `products` (`id`, `name`, `description`, `brand`, `category_id`, `base_price`) VALUES
(15,'HikeMaster TrekKing Pro','Scarpa da trekking impermeabile, supporto e comfort su lunghe distanze.','HikeMaster',3,129.00),
(16,'HikeMaster Aqua Shield','Stivali da escursionismo completamente impermeabili, ideali per clima umido.','HikeMaster',14,150.00),
(17,'HikeMaster Summit Guard','Stivale da trekking ad alte prestazioni, ideale per terreni difficili e alta montagna.','HikeMaster',3,170.00),
(18,'HikeMaster Trail Sandal','Sandalo robusto per escursioni leggere e clima caldo, ottima aderenza.','HikeMaster',9,65.00),
(19,'HikeMaster Quick Slip','Scarpa slip-on resistente per campeggio e attività all''aperto, pratica e robusta.','HikeMaster',15,78.00),
(20,'HikeMaster Winter Explorer','Stivale invernale foderato e impermeabile, per condizioni estreme.','HikeMaster',10,180.00),
(21,'HikeMaster Lite Trek','Scarpa da trekking leggera e traspirante, per escursioni veloci.','HikeMaster',3,110.00);

INSERT INTO `singleproduct` (`id`, `product_id`, `color`, `size`, `sku`, `price`, `stock`, `image`) VALUES
(29,15,'Marrone','44','HM-TKP-BRN-44',129.00,7,'hm_trekkingpro_brown_44.jpg'),
(30,15,'Grigio','43','HM-TKP-GRY-43',129.00,5,'hm_trekkingpro_gray_43.jpg'),
(31,16,'Nero','44','HM-AQS-BLK-44',150.00,8,'hm_aquashield_black_44.jpg'),
(32,16,'Marrone','45','HM-AQS-BRN-45',150.00,5,'hm_aquashield_brown_45.jpg'),
(33,17,'Verde Militare','45','HM-SG-VM-45',170.00,6,'hm_summitguard_militarygreen_45.jpg'),
(34,17,'Nero','44','HM-SG-BLK-44',170.00,4,'hm_summitguard_black_44.jpg'),
(35,18,'Beige','40','HM-TS-BEI-40',65.00,20,'hm_trailsandal_beige_40.jpg'),
(36,18,'Nero','41','HM-TS-BLK-41',65.00,15,'hm_trailsandal_black_41.jpg'),
(37,19,'Grigio','43','HM-QS-GRY-43',78.00,12,'hm_quickslip_gray_43.jpg'),
(38,19,'Arancione','42','HM-QS-ORN-42',78.00,10,'hm_quickslip_orange_42.jpg'),
(39,20,'Marrone Scuro','45','HM-WE-BRS-45',180.00,5,'hm_winterexplorer_darkbrown_45.jpg'),
(40,20,'Nero','44','HM-WE-BLK-44',180.00,4,'hm_winterexplorer_black_44.jpg'),
(41,21,'Blu','42','HM-LT-BLU-42',110.00,15,'hm_litetrek_blue_42.jpg'),
(42,21,'Grigio','41','HM-LT-GRY-41',110.00,12,'hm_litetrek_gray_41.jpg');

-- Brand: GentStyle (Eleganti, Casual, Lifestyle)
INSERT INTO `products` (`id`, `name`, `description`, `brand`, `category_id`, `base_price`) VALUES
(22,'GentStyle Classic Derby','Scarpa elegante in pelle, timeless e raffinata.','GentStyle',4,119.90),
(23,'GentStyle Weekend Loafer','Mocassino leggero e versatile, perfetto per il tempo libero con un tocco di classe.','GentStyle',5,95.00),
(24,'GentStyle Urban Loafer','Mocassino elegante ma comodo per l''uso quotidiano, versatile per look smart casual.','GentStyle',5,100.00),
(25,'GentStyle City Chic','Sneaker dal design sofisticato per un look lifestyle, con dettagli in pelle.','GentStyle',12,115.00),
(26,'GentStyle Oxford Premium','Classica Oxford in pelle di alta qualità, ideale per occasioni formali.','GentStyle',4,140.00),
(27,'GentStyle Casual Boot','Stivaletto casual in pelle scamosciata, perfetto per l''autunno/inverno.','GentStyle',5,125.00),
(28,'GentStyle Summer Breeze','Sandalo elegante in pelle, ideale per le serate estive.','GentStyle',9,70.00);

INSERT INTO `singleproduct` (`id`, `product_id`, `color`, `size`, `sku`, `price`, `stock`, `image`) VALUES
(43,22,'Nero','43','GS-CD-BLK-43',119.90,9,'gs_classicderby_black_43.jpg'),
(44,22,'Marrone Scuro','42','GS-CD-BRN-42',119.90,8,'gs_classicderby_darkbrown_42.jpg'),
(45,23,'Blu Navy','42','GS-WL-BLU-42',95.00,20,'gs_weekendloafer_blunavy_42.jpg'),
(46,23,'Grigio Chiaro','41','GS-WL-GRY-41',95.00,18,'gs_weekendloafer_lightgray_41.jpg'),
(47,24,'Nero','42','GS-UL-BLK-42',100.00,15,'gs_urbanloafer_black_42.jpg'),
(48,24,'Blu Scuro','43','GS-UL-BLU-43',100.00,10,'gs_urbanloafer_darkblue_43.jpg'),
(49,25,'Bianco','40','GS-CC-WHT-40',115.00,18,'gs_citychic_white_40.jpg'),
(50,25,'Beige','41','GS-CC-BEI-41',115.00,14,'gs_citychic_beige_41.jpg'),
(51,26,'Nero','44','GS-OP-BLK-44',140.00,7,'gs_oxfordpremium_black_44.jpg'),
(52,26,'Marrone','43','GS-OP-BRN-43',140.00,6,'gs_oxfordpremium_brown_43.jpg'),
(53,27,'Marrone','42','GS-CB-BRN-42',125.00,10,'gs_casualboot_brown_42.jpg'),
(54,27,'Grigio','41','GS-CB-GRY-41',125.00,9,'gs_casualboot_gray_41.jpg'),
(55,28,'Nero','40','GS-SB-BLK-40',70.00,15,'gs_summerbreeze_black_40.jpg'),
(56,28,'Marrone Chiaro','39','GS-SB-BRC-39',70.00,12,'gs_summerbreeze_lightbrown_39.jpg');

-- Brand: JumpMax (Basket, Sneakers, Lifestyle)
INSERT INTO `products` (`id`, `name`, `description`, `brand`, `category_id`, `base_price`) VALUES
(29,'JumpMax SkyDunk','Scarpa alta da basket con massimo supporto alla caviglia.','JumpMax',6,139.99),
(30,'JumpMax Cross-Court Trainer','Scarpa da allenamento versatile, adatta per diverse attività sportive indoor e outdoor.','JumpMax',5,110.00),
(31,'JumpMax Street Hoop','Sneaker ispirata al basket per lo stile urbano, design accattivante.','JumpMax',1,110.00),
(32,'JumpMax Daily Step','Scarpa comoda e resistente per l''uso quotidiano, ammortizzazione reattiva.','JumpMax',5,80.00),
(33,'JumpMax Court Dominator','Scarpa da basket con ammortizzazione reattiva e trazione superiore.','JumpMax',6,120.00),
(34,'JumpMax Urban Glide','Sneaker lifestyle leggera e traspirante, ideale per la città.','JumpMax',12,90.00),
(35,'JumpMax Performance Low','Scarpa da basket low-cut per massima agilità e velocità.','JumpMax',6,130.00);

INSERT INTO `singleproduct` (`id`, `product_id`, `color`, `size`, `sku`, `price`, `stock`, `image`) VALUES
(57,29,'Rosso','45','JM-SD-RED-45',139.99,6,'jm_skydunk_red_45.jpg'),
(58,29,'Bianco','44','JM-SD-WHT-44',139.99,7,'jm_skydunk_white_44.jpg'),
(59,30,'Nero/Rosso','44','JM-CCT-BLKRD-44',110.00,12,'jm_crosscourttrainer_blackred_44.jpg'),
(60,30,'Blu/Bianco','43','JM-CCT-BLWHT-43',110.00,10,'jm_crosscourttrainer_bluewhite_43.jpg'),
(61,31,'Nero/Bianco','44','JM-SHP-BWH-44',110.00,15,'jm_streethoop_bwh_44.jpg'),
(62,31,'Rosso/Nero','45','JM-SHP-RED-45',110.00,12,'jm_streethoop_red_45.jpg'),
(63,32,'Grigio','42','JM-DS-GRY-42',80.00,20,'jm_dailystep_gray_42.jpg'),
(64,32,'Blu','43','JM-DS-BLU-43',80.00,18,'jm_dailystep_blue_43.jpg'),
(65,33,'Nero','44','JM-CD-BLK-44',120.00,10,'jm_courtdominator_black_44.jpg'),
(66,33,'Bianco','45','JM-CD-WHT-45',120.00,8,'jm_courtdominator_white_45.jpg'),
(67,34,'Verde','41','JM-UG-GRN-41',90.00,15,'jm_urbanglide_green_41.jpg'),
(68,34,'Rosa','39','JM-UG-PNK-39',90.00,12,'jm_urbanglide_pink_39.jpg'),
(69,35,'Bianco/Nero','42','JM-PL-WHTBLK-42',130.00,10,'jm_performancelow_whiteblack_42.jpg'),
(70,35,'Rosso/Bianco','43','JM-PL-REDBLK-43',130.00,9,'jm_performancelow_redwhite_43.jpg');

-- Brand: KickPro (Calcio, Running)
INSERT INTO `products` (`id`, `name`, `description`, `brand`, `category_id`, `base_price`) VALUES
(36,'KickPro GoalPro 22','Scarpa calcio con tacchetti per terreni compatti, controllo di palla superiore.','KickPro',7,89.90),
(37,'KickPro Speed Sprint','Scarpa da corsa leggera e reattiva, ottimizzata per la velocità su pista e strada.','KickPro',2,90.00),
(38,'KickPro Sprint Pro','Scarpa da running leggera per alte prestazioni e massima propulsione.','KickPro',2,95.00),
(39,'KickPro Training Master','Scarpa sportiva versatile per allenamenti intensi, supporto e stabilità.','KickPro',5,80.00),
(40,'KickPro Elite Firm Ground','Scarpa calcio professionale per terreni duri, aderenza e tocco eccezionali.','KickPro',7,150.00),
(41,'KickPro Indoor Ace','Scarpa da calcetto indoor, ottima aderenza e sensibilità sul pallone.','KickPro',7,75.00),
(42,'KickPro Trail Conqueror','Scarpa da trail running robusta, per avventure su terreni misti.','KickPro',8,110.00);

INSERT INTO `singleproduct` (`id`, `product_id`, `color`, `size`, `sku`, `price`, `stock`, `image`) VALUES
(71,36,'Verde','44','KP-GP22-GRN-44',89.90,11,'kp_goalpro22_green_44.jpg'),
(72,36,'Blu','43','KP-GP22-BLU-43',89.90,10,'kp_goalpro22_blue_43.jpg'),
(73,37,'Arancione Fluo','41','KP-SS-ORN-41',90.00,14,'kp_speedsprint_orange_41.jpg'),
(74,37,'Nero','42','KP-SS-BLK-42',90.00,18,'kp_speedsprint_black_42.jpg'),
(75,38,'Verde Fluo','41','KP-SPR-GRN-41',95.00,14,'kp_sprintpro_green_41.jpg'),
(76,38,'Nero','42','KP-SPR-BLK-42',95.00,12,'kp_sprintpro_black_42.jpg'),
(77,39,'Arancione','43','KP-TM-ORN-43',80.00,18,'kp_trainingmaster_orange_43.jpg'),
(78,39,'Blu','44','KP-TM-BLU-44',80.00,16,'kp_trainingmaster_blue_44.jpg'),
(79,40,'Nero/Oro','42','KP-EFG-BKG-42',150.00,8,'kp_elitefirmground_blackgold_42.jpg'),
(80,40,'Blu/Argento','43','KP-EFG-BLS-43',150.00,7,'kp_elitefirmground_bluesilver_43.jpg'),
(81,41,'Bianco/Blu','40','KP-IA-WBL-40',75.00,20,'kp_indoorace_whiteblue_40.jpg'),
(82,41,'Nero/Giallo','41','KP-IA-NRY-41',75.00,18,'kp_indoorace_blackyellow_41.jpg'),
(83,42,'Verde','43','KP-TC-GRN-43',110.00,10,'kp_trailconqueror_green_43.jpg'),
(84,42,'Grigio','44','KP-TC-GRY-44',110.00,9,'kp_trailconqueror_gray_44.jpg');

-- Brand: AceFit (Tennis, Running, Casual)
INSERT INTO `products` (`id`, `name`, `description`, `brand`, `category_id`, `base_price`) VALUES
(43,'AceFit CourtAce','Scarpa stabile da tennis, massima agilità e durata sul campo.','AceFit',11,89.00),
(44,'AceFit Marathon Pro','Scarpa da running progettata per lunghe distanze, ammortizzazione superiore.','AceFit',2,110.00),
(45,'AceFit Gym Supreme','Scarpa sportiva versatile per allenamenti a 360 gradi, stabilità e flessibilità.','AceFit',5,85.00),
(46,'AceFit SpeedServe','Scarpa da tennis leggera e reattiva, per movimenti rapidi.','AceFit',11,100.00),
(47,'AceFit Daily Comfort','Scarpa casual per tutti i giorni, comfort eccezionale e design pulito.','AceFit',5,70.00),
(48,'AceFit Trail Master','Scarpa da trail robusta con grip aggressivo per terreni impegnativi.','AceFit',8,115.00),
(49,'AceFit Cross Trainer','Scarpa ideale per allenamenti incrociati, offre supporto e traspirabilità.','AceFit',5,90.00);

INSERT INTO `singleproduct` (`id`, `product_id`, `color`, `size`, `sku`, `price`, `stock`, `image`) VALUES
(85,43,'Bianco','42','AF-CA-WHT-42',89.00,12,'af_courtace_white_42.jpg'),
(86,43,'Nero','43','AF-CA-BLK-43',89.00,10,'af_courtace_black_43.jpg'),
(87,44,'Bianco/Blu','42','AF-MP-WBL-42',110.00,12,'af_marathonpro_whiteblue_42.jpg'),
(88,44,'Nero/Rosso','43','AF-MP-BKR-43',110.00,10,'af_marathonpro_blackred_43.jpg'),
(89,45,'Grigio','41','AF-GS-GRY-41',85.00,15,'af_gymsupreme_gray_41.jpg'),
(90,45,'Nero','40','AF-GS-BLK-40',85.00,13,'af_gymsupreme_black_40.jpg'),
(91,46,'Bianco/Verde','43','AF-SS-WGR-43',100.00,10,'af_speedserve_whitegreen_43.jpg'),
(92,46,'Blu','42','AF-SS-BLU-42',100.00,9,'af_speedserve_blue_42.jpg'),
(93,47,'Beige','39','AF-DC-BEI-39',70.00,25,'af_dailycomfort_beige_39.jpg'),
(94,47,'Nero','40','AF-DC-BLK-40',70.00,20,'af_dailycomfort_black_40.jpg'),
(95,48,'Marrone','44','AF-TM-BRN-44',115.00,8,'af_trailmaster_brown_44.jpg'),
(96,48,'Verde','43','AF-TM-GRN-43',115.00,7,'af_trailmaster_green_43.jpg'),
(97,49,'Grigio/Rosso','41','AF-CT-GRYRD-41',90.00,14,'af_crosstrainer_grayred_41.jpg'),
(98,49,'Nero/Giallo','42','AF-CT-BKRYL-42',90.00,12,'af_crosstrainer_blackyellow_42.jpg');


/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;