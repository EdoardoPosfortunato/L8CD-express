-- modificato created e updated, in modo che si riempano automaticamente

ALTER TABLE invoices
MODIFY updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE invoices
MODIFY created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;

UPDATE `l8cd_db`.`products` SET `image` = 'Puma-MB-02.webp' WHERE (`id` = '39');
