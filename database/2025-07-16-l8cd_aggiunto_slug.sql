-- 1. Aggiungi la colonna slug dopo id
ALTER TABLE `products` ADD COLUMN `slug` VARCHAR(255) NOT NULL AFTER `id`;

-- 2. Popola la colonna slug con valori unici
UPDATE `products` p
JOIN (
    SELECT 
        id,
        LOWER(REPLACE(REPLACE(REPLACE(name, ' ', '-'), "'", ""), "°", "")) AS base_slug,
        @rn := IF(@prev = LOWER(REPLACE(REPLACE(REPLACE(name, ' ', '-'), "'", ""), "°", "")), @rn + 1, 1) AS slug_count,
        @prev := LOWER(REPLACE(REPLACE(REPLACE(name, ' ', '-'), "'", ""), "°", "")) 
    FROM `products`, (SELECT @prev := '', @rn := 0) AS vars
    ORDER BY LOWER(REPLACE(REPLACE(REPLACE(name, ' ', '-'), "'", ""), "°", "")), id
) AS slugs ON p.id = slugs.id
SET p.slug = CASE 
    WHEN slugs.slug_count = 1 THEN slugs.base_slug
    ELSE CONCAT(slugs.base_slug, '-', slugs.slug_count)
END;