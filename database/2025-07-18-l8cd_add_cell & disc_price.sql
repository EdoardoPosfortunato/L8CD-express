ALTER TABLE invoices
ADD COLUMN costum_cell VARCHAR(20) AFTER custom_address;


ALTER TABLE `products`
ADD COLUMN `discount_price` DECIMAL(10,2) NULL AFTER `price`;


-- Scontati
UPDATE products SET discount_price = 95.00 WHERE sku = 'SKU0001';
UPDATE products SET discount_price = 150.00 WHERE sku = 'SKU0002';
UPDATE products SET discount_price = 128.00 WHERE sku = 'SKU0005';
UPDATE products SET discount_price = 140.00 WHERE sku = 'SKU0007';
UPDATE products SET discount_price = 75.00 WHERE sku = 'SKU0011';
UPDATE products SET discount_price = 65.00 WHERE sku = 'SKU0013';
UPDATE products SET discount_price = 80.00 WHERE sku = 'SKU0015';
UPDATE products SET discount_price = 125.00 WHERE sku = 'SKU0017';
UPDATE products SET discount_price = 130.00 WHERE sku = 'SKU0021';
UPDATE products SET discount_price = 150.00 WHERE sku = 'SKU0025';
UPDATE products SET discount_price = 55.00 WHERE sku = 'SKU0026';
UPDATE products SET discount_price = 75.00 WHERE sku = 'SKU0029';
UPDATE products SET discount_price = 155.00 WHERE sku = 'SKU0032';
UPDATE products SET discount_price = 130.00 WHERE sku = 'SKU0035';
UPDATE products SET discount_price = 130.00 WHERE sku = 'SKU0037';
UPDATE products SET discount_price = 135.00 WHERE sku = 'SKU0040';
UPDATE products SET discount_price = 110.00 WHERE sku = 'SKU0042';
UPDATE products SET discount_price = 100.00 WHERE sku = 'SKU0045';
UPDATE products SET discount_price = 70.00 WHERE sku = 'SKU0048';
UPDATE products SET discount_price = 75.00 WHERE sku = 'SKU0050';

-- Non scontati
UPDATE products SET discount_price = NULL WHERE sku IN (
  'SKU0003','SKU0004','SKU0006','SKU0008','SKU0009','SKU0010','SKU0012','SKU0014','SKU0016','SKU0018',
  'SKU0019','SKU0020','SKU0022','SKU0023','SKU0024','SKU0027','SKU0028','SKU0030','SKU0031','SKU0033',
  'SKU0034','SKU0036','SKU0038','SKU0039','SKU0041','SKU0043','SKU0044','SKU0046','SKU0047','SKU0049'
);
