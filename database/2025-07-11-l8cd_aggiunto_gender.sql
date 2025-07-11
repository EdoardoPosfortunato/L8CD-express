-- ============== AGGIUNTA colonna GENDER ==============-===


-- 1. Aggiunta della colonna `gender`
ALTER TABLE products ADD COLUMN gender ENUM('uomo', 'donna', 'bambino');

-- 2. Aggiorna tutti i record con un genere distribuito casualmente e in modo bilanciato
WITH ranked_products AS (
    SELECT id, 
           ROW_NUMBER() OVER (ORDER BY RAND()) AS row_num,
           (SELECT COUNT(*) FROM products) AS total
    FROM products
)
UPDATE products p
JOIN ranked_products rp ON p.id = rp.id
SET p.gender = CASE
    WHEN rp.row_num <= FLOOR(rp.total / 3) THEN 'uomo'
    WHEN rp.row_num <= FLOOR(rp.total * 2 / 3) THEN 'donna'
    ELSE 'bambino'
END;
