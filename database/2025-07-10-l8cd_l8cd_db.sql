
-- ============================ DATABASE ======================================================== --

CREATE TABLE `categories`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL,
    `description` TEXT NULL,
    `created_at` TIMESTAMP NOT NULL,
    `updated_at` TIMESTAMP NOT NULL
);

CREATE TABLE `products`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `sku` VARCHAR(255) NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `description` TEXT NULL,
    `stock` INT NOT NULL,
    `brand` VARCHAR(50) NULL,
    `category_id` BIGINT UNSIGNED NULL,
    `price` DECIMAL(8, 2) NULL,
    `color` VARCHAR(50) NULL,
    `size` DECIMAL(6, 2) NULL,
    `image` VARCHAR(255) NULL,
    `created_at` TIMESTAMP NOT NULL,
    `updated_at` TIMESTAMP NOT NULL
);

ALTER TABLE `products`
    ADD UNIQUE `products_sku_unique`(`sku`);

CREATE TABLE `invoices`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `custom_name` VARCHAR(255) NOT NULL,
    `custom_email` VARCHAR(255) NULL,
    `custom_address` TEXT NULL,
    `total_amount` DECIMAL(10, 2) NULL,
    `payment_method` VARCHAR(50) NULL,
    `shipping_address` TEXT NULL,
    `shipping_method` VARCHAR(50) NULL,
    `tracking_number` VARCHAR(255) NULL,
    `coupon_id` BIGINT UNSIGNED NULL,
    `status` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP NOT NULL,
    `updated_at` TIMESTAMP NOT NULL
);

CREATE TABLE `coupons`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `code` VARCHAR(255) NOT NULL,
    `description` TEXT NULL,
    `discount_value` DECIMAL(8, 2) NULL,
    `start_date` TIMESTAMP NULL,
    `end_date` TIMESTAMP NULL,
    `min_order_amount` DECIMAL(8, 2) NOT NULL,
    `is_active` BOOLEAN NOT NULL,
    `updated_at` TIMESTAMP NOT NULL,
    `created_at` TIMESTAMP NOT NULL
);

ALTER TABLE `coupons`
    ADD UNIQUE `coupons_code_unique`(`code`);

CREATE TABLE `products_invoices`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `product_id` BIGINT UNSIGNED NOT NULL,
    `invoice_id` BIGINT UNSIGNED NOT NULL,
    `quantity` INT NOT NULL
);

ALTER TABLE `products_invoices`
    ADD INDEX `products_invoices_product_id_invoice_id_index`(`product_id`, `invoice_id`);

ALTER TABLE `products_invoices`
    ADD CONSTRAINT `products_invoices_invoice_id_foreign`
    FOREIGN KEY (`invoice_id`) REFERENCES `invoices`(`id`);

ALTER TABLE `products_invoices`
    ADD CONSTRAINT `products_invoices_product_id_foreign`
    FOREIGN KEY (`product_id`) REFERENCES `products`(`id`);

ALTER TABLE `products`
    ADD CONSTRAINT `products_category_id_foreign`
    FOREIGN KEY (`category_id`) REFERENCES `categories`(`id`);

ALTER TABLE `invoices`
    ADD CONSTRAINT `invoices_coupon_id_foreign`
    FOREIGN KEY (`coupon_id`) REFERENCES `coupons`(`id`);



-- ======================================= SEEDER ==================================== --


-- Seeder per categorie
INSERT INTO `categories` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Running', 'Scarpe ideali per la corsa.', '2025-01-01 10:00:00', '2025-01-01 10:00:00'),
(2, 'Basketball', 'Scarpe da basket performanti.', '2025-01-02 10:00:00', '2025-01-02 10:00:00'),
(3, 'Casual', 'Scarpe da tutti i giorni, stile casual.', '2025-01-03 10:00:00', '2025-01-03 10:00:00'),
(4, 'Training', 'Scarpe per allenamenti e palestra.', '2025-01-04 10:00:00', '2025-01-04 10:00:00'),
(5, 'Outdoor', 'Scarpe per attività all\'aperto.', '2025-01-05 10:00:00', '2025-01-05 10:00:00'),
(6, 'Lifestyle', 'Scarpe alla moda per il tempo libero.', '2025-01-06 10:00:00', '2025-01-06 10:00:00');

-- Seeder per prodotti (scarpe) - 50 prodotti con SKU univoci e date diverse
INSERT INTO `products` 
(`sku`, `name`, `description`, `stock`, `brand`, `category_id`, `price`, `color`, `size`, `image`, `created_at`, `updated_at`) VALUES
('SKU0001', 'Nike Air Zoom Pegasus 39', 'Scarpa running leggera e reattiva.', 20, 'Nike', 1, 120.00, 'Black', 42.5, 'https://example.com/shoes/pegasus39.jpg', '2025-06-01 08:00:00', '2025-06-01 08:00:00'),
('SKU0002', 'Adidas Ultraboost 22', 'Scarpa running con ammortizzazione Boost.', 15, 'Adidas', 1, 180.00, 'White', 43, 'https://example.com/shoes/ultraboost22.jpg', '2025-06-02 08:00:00', '2025-06-02 08:00:00'),
('SKU0003', 'Puma Deviate Nitro', 'Scarpa running veloce e leggera.', 25, 'Puma', 1, 150.00, 'Blue', 42, 'https://example.com/shoes/deviate_nitro.jpg', '2025-06-03 08:00:00', '2025-06-03 08:00:00'),
('SKU0004', 'New Balance FuelCell Rebel', 'Scarpa running con buon ritorno di energia.', 18, 'New Balance', 1, 140.00, 'Grey', 41.5, 'https://example.com/shoes/fuelcell_rebel.jpg', '2025-06-04 08:00:00', '2025-06-04 08:00:00'),
('SKU0005', 'Asics Gel-Kayano 28', 'Supporto e stabilità per lunghe distanze.', 22, 'Asics', 1, 160.00, 'Red', 42, 'https://example.com/shoes/gel_kayano28.jpg', '2025-06-05 08:00:00', '2025-06-05 08:00:00'),

('SKU0006', 'Nike LeBron 20', 'Scarpa da basket con ammortizzazione avanzata.', 12, 'Nike', 2, 200.00, 'White/Red', 44, 'https://example.com/shoes/lebron20.jpg', '2025-06-01 09:00:00', '2025-06-01 09:00:00'),
('SKU0007', 'Adidas Harden Vol. 6', 'Scarpa basket confortevole e stabile.', 14, 'Adidas', 2, 160.00, 'Black', 43.5, 'https://example.com/shoes/harden_vol6.jpg', '2025-06-02 09:00:00', '2025-06-02 09:00:00'),
('SKU0008', 'Under Armour Curry Flow 9', 'Scarpa da basket agile e reattiva.', 10, 'Under Armour', 2, 180.00, 'Blue', 42.5, 'https://example.com/shoes/curry_flow9.jpg', '2025-06-03 09:00:00', '2025-06-03 09:00:00'),
('SKU0009', 'Puma Clyde All Pro', 'Scarpa basket leggera e performante.', 11, 'Puma', 2, 140.00, 'Grey', 43, 'https://example.com/shoes/clyde_all_pro.jpg', '2025-06-04 09:00:00', '2025-06-04 09:00:00'),
('SKU0010', 'New Balance OMN1S', 'Scarpa basket versatile e robusta.', 13, 'New Balance', 2, 170.00, 'Black/White', 44, 'https://example.com/shoes/omn1s.jpg', '2025-06-05 09:00:00', '2025-06-05 09:00:00'),

('SKU0011', 'Nike Air Force 1', 'Scarpa casual iconica.', 30, 'Nike', 3, 90.00, 'White', 42, 'https://example.com/shoes/air_force1.jpg', '2025-06-01 10:00:00', '2025-06-01 10:00:00'),
('SKU0012', 'Adidas Stan Smith', 'Scarpa casual elegante e semplice.', 25, 'Adidas', 3, 85.00, 'Green/White', 42.5, 'https://example.com/shoes/stan_smith.jpg', '2025-06-02 10:00:00', '2025-06-02 10:00:00'),
('SKU0013', 'Puma Suede Classic', 'Scarpa casual dal design classico.', 28, 'Puma', 3, 75.00, 'Black', 41, 'https://example.com/shoes/suede_classic.jpg', '2025-06-03 10:00:00', '2025-06-03 10:00:00'),
('SKU0014', 'New Balance 574', 'Scarpa casual vintage.', 22, 'New Balance', 3, 80.00, 'Grey', 42.5, 'https://example.com/shoes/nb_574.jpg', '2025-06-04 10:00:00', '2025-06-04 10:00:00'),
('SKU0015', 'Asics GEL-Lyte III', 'Scarpa casual confortevole.', 20, 'Asics', 3, 95.00, 'Blue', 42, 'https://example.com/shoes/gel_lyte_iii.jpg', '2025-06-05 10:00:00', '2025-06-05 10:00:00'),

('SKU0016', 'Nike Metcon 7', 'Scarpa training stabile e resistente.', 18, 'Nike', 4, 130.00, 'Black/White', 42, 'https://example.com/shoes/metcon7.jpg', '2025-06-01 11:00:00', '2025-06-01 11:00:00'),
('SKU0017', 'Adidas Adipower', 'Scarpa training con supporto elevato.', 15, 'Adidas', 4, 140.00, 'Blue', 43, 'https://example.com/shoes/adipower.jpg', '2025-06-02 11:00:00', '2025-06-02 11:00:00'),
('SKU0018', 'Under Armour TriBase', 'Scarpa training leggera e agile.', 17, 'Under Armour', 4, 120.00, 'Grey', 42, 'https://example.com/shoes/triBase.jpg', '2025-06-03 11:00:00', '2025-06-03 11:00:00'),
('SKU0019', 'Puma Fuse', 'Scarpa training confortevole.', 14, 'Puma', 4, 110.00, 'Red', 42.5, 'https://example.com/shoes/fuse.jpg', '2025-06-04 11:00:00', '2025-06-04 11:00:00'),
('SKU0020', 'New Balance Minimus', 'Scarpa training con ottima stabilità.', 16, 'New Balance', 4, 115.00, 'Black', 41.5, 'https://example.com/shoes/minimus.jpg', '2025-06-05 11:00:00', '2025-06-05 11:00:00'),

('SKU0021', 'Salomon Speedcross 5', 'Scarpa outdoor per terreni tecnici.', 20, 'Salomon', 5, 150.00, 'Black/Orange', 43, 'https://example.com/shoes/speedcross5.jpg', '2025-06-01 12:00:00', '2025-06-01 12:00:00'),
('SKU0022', 'Merrell Moab 2', 'Scarpa outdoor resistente e confortevole.', 18, 'Merrell', 5, 140.00, 'Brown', 42.5, 'https://example.com/shoes/moab2.jpg', '2025-06-02 12:00:00', '2025-06-02 12:00:00'),
('SKU0023', 'The North Face Ultra Fastpack', 'Scarpa outdoor leggera.', 15, 'The North Face', 5, 160.00, 'Grey', 42, 'https://example.com/shoes/ultrafastpack.jpg', '2025-06-03 12:00:00', '2025-06-03 12:00:00'),
('SKU0024', 'Columbia Redmond', 'Scarpa outdoor versatile.', 17, 'Columbia', 5, 130.00, 'Green', 42.5, 'https://example.com/shoes/redmond.jpg', '2025-06-04 12:00:00', '2025-06-04 12:00:00'),
('SKU0025', 'La Sportiva Bushido II', 'Scarpa outdoor tecnica.', 13, 'La Sportiva', 5, 170.00, 'Yellow', 42, 'https://example.com/shoes/bushido2.jpg', '2025-06-05 12:00:00', '2025-06-05 12:00:00'),

('SKU0026', 'Vans Old Skool', 'Scarpa lifestyle iconica.', 30, 'Vans', 6, 65.00, 'Black/White', 42, 'https://example.com/shoes/oldskool.jpg', '2025-06-01 13:00:00', '2025-06-01 13:00:00'),
('SKU0027', 'Converse Chuck Taylor', 'Scarpa lifestyle classica.', 28, 'Converse', 6, 60.00, 'White', 42, 'https://example.com/shoes/chuck_taylor.jpg', '2025-06-02 13:00:00', '2025-06-02 13:00:00'),
('SKU0028', 'Nike Air Max 90', 'Scarpa lifestyle con ammortizzazione.', 25, 'Nike', 6, 140.00, 'Grey', 42.5, 'https://example.com/shoes/airmax90.jpg', '2025-06-03 13:00:00', '2025-06-03 13:00:00'),
('SKU0029', 'Adidas Superstar', 'Scarpa lifestyle iconica.', 27, 'Adidas', 6, 85.00, 'White/Black', 42, 'https://example.com/shoes/superstar.jpg', '2025-06-04 13:00:00', '2025-06-04 13:00:00'),
('SKU0030', 'Puma RS-X', 'Scarpa lifestyle colorata.', 22, 'Puma', 6, 110.00, 'Red/White', 42, 'https://example.com/shoes/rsx.jpg', '2025-06-05 13:00:00', '2025-06-05 13:00:00'),

-- Continuo con altre 20 scarpe mescolando categorie e brand
('SKU0031', 'Nike ZoomX Vaporfly', 'Scarpa running da gara.', 15, 'Nike', 1, 250.00, 'Yellow', 43, 'https://example.com/shoes/vaporfly.jpg', '2025-06-06 08:00:00', '2025-06-06 08:00:00'),
('SKU0032', 'Adidas Adizero Adios', 'Scarpa running veloce.', 12, 'Adidas', 1, 180.00, 'Black/Red', 42, 'https://example.com/shoes/adizero_adios.jpg', '2025-06-07 08:00:00', '2025-06-07 08:00:00'),
('SKU0033', 'Under Armour HOVR Phantom', 'Scarpa running ammortizzata.', 17, 'Under Armour', 1, 160.00, 'Blue/White', 42.5, 'https://example.com/shoes/hovr_phantom.jpg', '2025-06-08 08:00:00', '2025-06-08 08:00:00'),
('SKU0034', 'New Balance 1080v11', 'Scarpa running confortevole.', 14, 'New Balance', 1, 150.00, 'Grey/Blue', 42, 'https://example.com/shoes/1080v11.jpg', '2025-06-09 08:00:00', '2025-06-09 08:00:00'),
('SKU0035', 'Asics Gel-Nimbus 23', 'Scarpa running ammortizzata.', 19, 'Asics', 1, 160.00, 'Pink', 42, 'https://example.com/shoes/gel_nimbus23.jpg', '2025-06-10 08:00:00', '2025-06-10 08:00:00'),

('SKU0036', 'Nike Kyrie 8', 'Scarpa basket agile.', 13, 'Nike', 2, 170.00, 'Black/Orange', 43, 'https://example.com/shoes/kyrie8.jpg', '2025-06-06 09:00:00', '2025-06-06 09:00:00'),
('SKU0037', 'Adidas Dame 8', 'Scarpa basket versatile.', 15, 'Adidas', 2, 150.00, 'White/Red', 42.5, 'https://example.com/shoes/dame8.jpg', '2025-06-07 09:00:00', '2025-06-07 09:00:00'),
('SKU0038', 'Under Armour Spawn 3', 'Scarpa basket performante.', 14, 'Under Armour', 2, 160.00, 'Grey', 43, 'https://example.com/shoes/spawn3.jpg', '2025-06-08 09:00:00', '2025-06-08 09:00:00'),
('SKU0039', 'Puma MB.02', 'Scarpa basket leggera.', 12, 'Puma', 2, 140.00, 'Blue', 42.5, 'https://example.com/shoes/mb02.jpg', '2025-06-09 09:00:00', '2025-06-09 09:00:00'),
('SKU0040', 'New Balance Two WXY', 'Scarpa basket stabile.', 11, 'New Balance', 2, 150.00, 'White', 43, 'https://example.com/shoes/two_wxy.jpg', '2025-06-10 09:00:00', '2025-06-10 09:00:00'),

('SKU0041', 'Nike Air Zoom SuperRep', 'Scarpa training energica.', 16, 'Nike', 4, 130.00, 'Red/Black', 42, 'https://example.com/shoes/superrep.jpg', '2025-06-06 11:00:00', '2025-06-06 11:00:00'),
('SKU0042', 'Adidas CrazyPower', 'Scarpa training con supporto.', 15, 'Adidas', 4, 125.00, 'Black/White', 42.5, 'https://example.com/shoes/crazypower.jpg', '2025-06-07 11:00:00', '2025-06-07 11:00:00'),
('SKU0043', 'Under Armour HOVR Rise', 'Scarpa training ammortizzata.', 14, 'Under Armour', 4, 120.00, 'Blue/Black', 42, 'https://example.com/shoes/hovr_rise.jpg', '2025-06-08 11:00:00', '2025-06-08 11:00:00'),
('SKU0044', 'Puma Tazon 6', 'Scarpa training resistente.', 13, 'Puma', 4, 110.00, 'Grey', 42, 'https://example.com/shoes/tazon6.jpg', '2025-06-09 11:00:00', '2025-06-09 11:00:00'),
('SKU0045', 'New Balance FuelCore', 'Scarpa training versatile.', 17, 'New Balance', 4, 115.00, 'Black', 42.5, 'https://example.com/shoes/fuelcore.jpg', '2025-06-10 11:00:00', '2025-06-10 11:00:00'),

('SKU0046', 'Vans Authentic', 'Scarpa lifestyle classica.', 20, 'Vans', 6, 60.00, 'White', 42, 'https://example.com/shoes/authentic.jpg', '2025-06-06 13:00:00', '2025-06-06 13:00:00'),
('SKU0047', 'Converse One Star', 'Scarpa lifestyle iconica.', 22, 'Converse', 6, 65.00, 'Black', 42, 'https://example.com/shoes/one_star.jpg', '2025-06-07 13:00:00', '2025-06-07 13:00:00'),
('SKU0048', 'Nike Cortez', 'Scarpa lifestyle retrò.', 18, 'Nike', 6, 80.00, 'White/Red', 42, 'https://example.com/shoes/cortez.jpg', '2025-06-08 13:00:00', '2025-06-08 13:00:00'),
('SKU0049', 'Adidas Gazelle', 'Scarpa lifestyle iconica.', 19, 'Adidas', 6, 90.00, 'Green', 42, 'https://example.com/shoes/gazelle.jpg', '2025-06-09 13:00:00', '2025-06-09 13:00:00'),
('SKU0050', 'Puma Cali', 'Scarpa lifestyle casual.', 21, 'Puma', 6, 85.00, 'White', 42, 'https://example.com/shoes/cali.jpg', '2025-06-10 13:00:00', '2025-06-10 13:00:00');

-- Coupon insert
INSERT INTO `coupons` (`code`, `description`, `discount_value`, `start_date`, `end_date`, `min_order_amount`, `is_active`, `updated_at`, `created_at`) VALUES
('SAVE10', 'Sconto del 10% su ordini superiori a 50 euro.', 10.00, '2025-06-01 00:00:00', '2025-12-31 23:59:59', 50.00, TRUE, NOW(), NOW()),
('FREESHIP', 'Spedizione gratuita su ordini superiori a 75 euro.', 0.00, '2025-06-01 00:00:00', '2025-12-31 23:59:59', 75.00, TRUE, NOW(), NOW()),
('NEWYEAR20', 'Sconto del 20% per il nuovo anno.', 20.00, '2025-12-25 00:00:00', '2026-01-05 23:59:59', 100.00, TRUE, NOW(), NOW()),
('SUMMER15', 'Sconto estivo del 15% su ordini superiori a 60 euro.', 15.00, '2025-06-15 00:00:00', '2025-08-31 23:59:59', 60.00, TRUE, NOW(), NOW()),
('BLACKFRIDAY50', 'Sconto del 50% per il Black Friday.', 50.00, '2025-11-25 00:00:00', '2025-11-29 23:59:59', 150.00, TRUE, NOW(), NOW()),
('SPRING5', 'Sconto del 5% per la primavera.', 5.00, '2025-03-01 00:00:00', '2025-05-31 23:59:59', 30.00, FALSE, NOW(), NOW()),
('WELCOME25', 'Benvenuto! 25% di sconto sul primo ordine.', 25.00, '2025-06-01 00:00:00', '2025-12-31 23:59:59', 0.00, TRUE, NOW(), NOW()),
('FALL10', 'Sconto autunnale del 10% su ordini superiori a 40 euro.', 10.00, '2025-09-01 00:00:00', '2025-11-30 23:59:59', 40.00, TRUE, NOW(), NOW()),
('FLASH30', 'Sconto lampo del 30% per 24 ore.', 30.00, '2025-06-20 00:00:00', '2025-06-21 23:59:59', 80.00, TRUE, NOW(), NOW()),
('LOYALTY15', 'Sconto fedeltà del 15% su ordini superiori a 70 euro.', 15.00, '2025-06-01 00:00:00', '2025-12-31 23:59:59', 70.00, TRUE, NOW(), NOW());




