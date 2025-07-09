-- Tabella dei brand
CREATE TABLE brands (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) UNIQUE NOT NULL
);

-- Tipi di scarpe (es. sneaker, running, stivali, ecc.)
CREATE TABLE tipi_scarpa (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) UNIQUE NOT NULL
);

-- Modelli di scarpe
CREATE TABLE models (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    id_brand INT NOT NULL,
    id_tipo_scarpa INT NOT NULL,
    descrizione TEXT,
    FOREIGN KEY (id_brand) REFERENCES brands(id),
    FOREIGN KEY (id_tipo_scarpa) REFERENCES tipi_scarpa(id)
);

-- Prodotti specifici in vendita (es. colore, sconti)
CREATE TABLE prodotti (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_modello INT NOT NULL,
    colore VARCHAR(50),
    prezzo_base DECIMAL(10,2) NOT NULL,
    prezzo_scontato DECIMAL(10,2),
    disponibilita INT DEFAULT 0,
    FOREIGN KEY (id_modello) REFERENCES models(id)
);

-- Immagini dei prodotti
CREATE TABLE immagini (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_prodotto INT NOT NULL,
    url VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_prodotto) REFERENCES prodotti(id)
);

-- Utenti registrati
CREATE TABLE utenti (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    data_registrazione DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Ordini effettuati dagli utenti
CREATE TABLE ordini (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_utente INT NOT NULL,
    data_ordine DATETIME DEFAULT CURRENT_TIMESTAMP,
    stato VARCHAR(50) DEFAULT 'in elaborazione',
    FOREIGN KEY (id_utente) REFERENCES utenti(id)
);

-- Dettagli dei prodotti negli ordini
CREATE TABLE dettagli_ordini (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_ordine INT NOT NULL,
    id_prodotto INT NOT NULL,
    quantita INT NOT NULL,
    prezzo_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_ordine) REFERENCES ordini(id),
    FOREIGN KEY (id_prodotto) REFERENCES prodotti(id)
);

-- Recensioni dei prodotti
CREATE TABLE recensioni (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_prodotto INT NOT NULL,
    id_utente INT NOT NULL,
    voto INT CHECK (voto BETWEEN 1 AND 5),
    commento TEXT,
    data DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_prodotto) REFERENCES prodotti(id),
    FOREIGN KEY (id_utente) REFERENCES utenti(id)
);


-- Inserimenti di 70 paia di scarpe
INSERT INTO brands (nome) VALUES ('Nike');
INSERT INTO brands (nome) VALUES ('Adidas');
INSERT INTO brands (nome) VALUES ('Puma');
INSERT INTO brands (nome) VALUES ('New Balance');
INSERT INTO brands (nome) VALUES ('Asics');
INSERT INTO brands (nome) VALUES ('Reebok');
INSERT INTO brands (nome) VALUES ('Converse');
INSERT INTO tipi_scarpa (nome) VALUES ('Sneaker');
INSERT INTO tipi_scarpa (nome) VALUES ('Running');
INSERT INTO tipi_scarpa (nome) VALUES ('Stivale');
INSERT INTO tipi_scarpa (nome) VALUES ('Casual');
INSERT INTO tipi_scarpa (nome) VALUES ('Sportiva');
INSERT INTO tipi_scarpa (nome) VALUES ('Trekking');
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 1', 2, 3, 'Descrizione del modello 1');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (1, 'Nero', 165.7, NULL, 2);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 2', 6, 3, 'Descrizione del modello 2');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (2, 'Verde', 123.5, NULL, 33);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 3', 4, 6, 'Descrizione del modello 3');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (3, 'Bianco', 145.28, NULL, 24);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 4', 7, 6, 'Descrizione del modello 4');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (4, 'Bianco', 100.93, NULL, 34);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 5', 7, 1, 'Descrizione del modello 5');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (5, 'Blu', 95.78, 81.41, 33);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 6', 4, 1, 'Descrizione del modello 6');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (6, 'Beige', 140.62, 119.53, 23);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 7', 2, 4, 'Descrizione del modello 7');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (7, 'Blu', 248.03, 210.83, 7);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 8', 5, 5, 'Descrizione del modello 8');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (8, 'Beige', 72.51, NULL, 25);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 9', 5, 1, 'Descrizione del modello 9');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (9, 'Rosso', 89.03, 75.68, 21);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 10', 3, 2, 'Descrizione del modello 10');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (10, 'Nero', 241.64, NULL, 45);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 11', 3, 1, 'Descrizione del modello 11');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (11, 'Blu', 109.39, 92.98, 41);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 12', 2, 4, 'Descrizione del modello 12');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (12, 'Blu', 101.9, NULL, 17);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 13', 5, 3, 'Descrizione del modello 13');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (13, 'Beige', 142.9, NULL, 2);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 14', 5, 4, 'Descrizione del modello 14');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (14, 'Grigio', 212.05, NULL, 25);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 15', 3, 1, 'Descrizione del modello 15');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (15, 'Blu', 119.62, 101.68, 5);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 16', 3, 1, 'Descrizione del modello 16');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (16, 'Grigio', 190.86, 162.23, 8);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 17', 2, 4, 'Descrizione del modello 17');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (17, 'Nero', 90.76, 77.15, 35);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 18', 5, 4, 'Descrizione del modello 18');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (18, 'Beige', 240.77, NULL, 6);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 19', 7, 5, 'Descrizione del modello 19');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (19, 'Verde', 87.65, 74.5, 1);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 20', 3, 1, 'Descrizione del modello 20');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (20, 'Beige', 191.48, NULL, 27);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 21', 4, 3, 'Descrizione del modello 21');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (21, 'Giallo', 193.02, 164.07, 7);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 22', 1, 5, 'Descrizione del modello 22');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (22, 'Giallo', 171.15, NULL, 15);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 23', 6, 6, 'Descrizione del modello 23');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (23, 'Nero', 225.84, NULL, 16);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 24', 3, 4, 'Descrizione del modello 24');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (24, 'Verde', 223.54, NULL, 22);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 25', 7, 1, 'Descrizione del modello 25');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (25, 'Grigio', 120.8, 102.68, 49);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 26', 3, 6, 'Descrizione del modello 26');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (26, 'Nero', 191.02, 162.37, 19);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 27', 5, 3, 'Descrizione del modello 27');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (27, 'Giallo', 211.91, 180.12, 8);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 28', 3, 4, 'Descrizione del modello 28');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (28, 'Grigio', 246.48, 209.51, 34);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 29', 5, 5, 'Descrizione del modello 29');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (29, 'Grigio', 223.79, NULL, 10);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 30', 5, 4, 'Descrizione del modello 30');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (30, 'Beige', 173.43, 147.42, 42);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 31', 7, 4, 'Descrizione del modello 31');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (31, 'Bianco', 88.72, 75.41, 32);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 32', 3, 5, 'Descrizione del modello 32');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (32, 'Verde', 87.96, NULL, 33);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 33', 1, 1, 'Descrizione del modello 33');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (33, 'Blu', 201.44, 171.22, 24);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 34', 4, 3, 'Descrizione del modello 34');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (34, 'Giallo', 71.16, 60.49, 29);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 35', 3, 4, 'Descrizione del modello 35');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (35, 'Grigio', 110.06, 93.55, 48);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 36', 2, 4, 'Descrizione del modello 36');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (36, 'Rosso', 190.64, NULL, 16);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 37', 4, 2, 'Descrizione del modello 37');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (37, 'Nero', 203.31, 172.81, 41);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 38', 6, 6, 'Descrizione del modello 38');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (38, 'Bianco', 113.15, 96.18, 27);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 39', 7, 4, 'Descrizione del modello 39');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (39, 'Nero', 83.46, 70.94, 41);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 40', 6, 4, 'Descrizione del modello 40');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (40, 'Blu', 143.68, 122.13, 17);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 41', 5, 3, 'Descrizione del modello 41');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (41, 'Giallo', 218.81, 185.99, 19);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 42', 2, 3, 'Descrizione del modello 42');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (42, 'Bianco', 125.5, NULL, 11);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 43', 5, 5, 'Descrizione del modello 43');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (43, 'Blu', 156.71, 133.2, 43);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 44', 6, 5, 'Descrizione del modello 44');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (44, 'Verde', 201.05, NULL, 13);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 45', 7, 3, 'Descrizione del modello 45');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (45, 'Giallo', 139.57, 118.63, 45);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 46', 7, 3, 'Descrizione del modello 46');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (46, 'Beige', 98.08, 83.37, 17);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 47', 2, 1, 'Descrizione del modello 47');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (47, 'Verde', 76.96, NULL, 8);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 48', 4, 6, 'Descrizione del modello 48');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (48, 'Verde', 209.3, NULL, 29);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 49', 2, 1, 'Descrizione del modello 49');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (49, 'Nero', 111.55, 94.82, 41);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 50', 7, 4, 'Descrizione del modello 50');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (50, 'Bianco', 190.63, NULL, 2);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 51', 4, 4, 'Descrizione del modello 51');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (51, 'Rosso', 121.15, 102.98, 14);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 52', 2, 3, 'Descrizione del modello 52');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (52, 'Rosso', 191.12, NULL, 37);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 53', 7, 5, 'Descrizione del modello 53');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (53, 'Verde', 248.73, 211.42, 5);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 54', 3, 1, 'Descrizione del modello 54');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (54, 'Bianco', 92.26, 78.42, 26);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 55', 1, 4, 'Descrizione del modello 55');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (55, 'Giallo', 140.91, NULL, 23);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 56', 2, 4, 'Descrizione del modello 56');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (56, 'Rosso', 120.01, 102.01, 37);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 57', 1, 6, 'Descrizione del modello 57');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (57, 'Beige', 71.23, 60.55, 9);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 58', 3, 6, 'Descrizione del modello 58');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (58, 'Blu', 239.61, 203.67, 7);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 59', 7, 1, 'Descrizione del modello 59');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (59, 'Beige', 73.33, NULL, 39);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 60', 1, 1, 'Descrizione del modello 60');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (60, 'Grigio', 162.73, NULL, 42);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 61', 3, 4, 'Descrizione del modello 61');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (61, 'Nero', 113.4, NULL, 2);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 62', 1, 1, 'Descrizione del modello 62');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (62, 'Beige', 157.76, NULL, 22);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 63', 2, 6, 'Descrizione del modello 63');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (63, 'Nero', 172.69, NULL, 50);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 64', 4, 3, 'Descrizione del modello 64');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (64, 'Beige', 226.06, NULL, 18);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 65', 1, 5, 'Descrizione del modello 65');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (65, 'Beige', 214.56, 182.38, 33);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 66', 5, 3, 'Descrizione del modello 66');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (66, 'Bianco', 150.36, 127.81, 43);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 67', 2, 1, 'Descrizione del modello 67');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (67, 'Grigio', 153.67, 130.62, 48);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 68', 1, 5, 'Descrizione del modello 68');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (68, 'Grigio', 133.96, 113.87, 33);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 69', 5, 3, 'Descrizione del modello 69');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (69, 'Bianco', 164.95, 140.21, 5);
INSERT INTO models (nome, id_brand, id_tipo_scarpa, descrizione) VALUES ('Modello 70', 5, 6, 'Descrizione del modello 70');
INSERT INTO prodotti (id_modello, colore, prezzo_base, prezzo_scontato, disponibilita) VALUES (70, 'Bianco', 128.95, NULL, 12);