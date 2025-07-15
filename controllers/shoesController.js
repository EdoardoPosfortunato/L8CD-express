import connection from "../db.js";
import slugify from "slugify";

const index = (req, res, next) => {
  const { gender, isNew, minPrice, maxPrice, brand } = req.query;

  let sql = "SELECT * FROM products";
  let conditions = [];
  let params = [];

  if (gender) {
    conditions.push("gender = ?");
    params.push(gender);
  }

  if (brand) {
    conditions.push("brand LIKE ?");
    params.push(`%${brand}%`);
  }

  if (minPrice) {
    conditions.push("price >= ?");
    params.push(minPrice);
  }

  if (maxPrice) {
    conditions.push("price <= ?");
    params.push(maxPrice);
  }

  if (isNew === "true") {
    conditions.push("DATE(created_at) >= ?");
    params.push("2025-06-06");
  }

  if (conditions.length > 0) {
    sql += " WHERE " + conditions.join(" AND ");
  }

  connection.query(sql, params, (err, result) => {
    if (err) return next(new Error(err));

    const shoes = result.map((curShoe) => ({
      ...curShoe,
      image: curShoe.image ? `${req.imagePath}/${curShoe.image}` : null,
    }));

    res.status(200).json({
      info: isNew === "true" ? "Aggiunti di recente" : gender === "offerte" ? "Scarpe in offerta (prezzo < 100)" : gender ? `Scarpe per genere: ${gender}` : "Tutte le scarpe",
      totalcount: shoes.length,
      data: shoes,
    });
  });
};

const show = (req, res) => {
  const id = req.params.id;
  const shoeRequest = `SELECT * FROM products WHERE id = ?`;

  connection.query(shoeRequest, [id], (err, result) => {
    if (err || result.length === 0) {
      return res.status(404).json({
        status: "404",
        info: "Scarpa non trovata",
      });
    }

    const shoeData = result[0];
    res.status(200).json({
      data: {
        ...shoeData,
        image: shoeData.image ? `${req.imagePath}/${shoeData.image}` : null,
      },
    });
  });
};

const storeInvoice = (req, res) => {
  const {
    custom_name,
    custom_email,
    custom_address,
    total_amount,
    payment_method,
    shipping_address,
    shipping_method,
    tracking_number,
    coupon_id,
    status,
    products, // <-- array di prodotti [{product_id, quantity, price}, ...]
  } = req.body;

  const sqlInvoice = `
    INSERT INTO invoices (
      custom_name,
      custom_email,
      custom_address,
      total_amount,
      payment_method,
      shipping_address,
      shipping_method,
      tracking_number,
      coupon_id, status
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
  `;

  const valuesInvoice = [custom_name, custom_email, custom_address, total_amount, payment_method, shipping_address, shipping_method, tracking_number, coupon_id, status];

  connection.query(sqlInvoice, valuesInvoice, (err, results) => {
    if (err) {
      console.error("Errore inserimento ordine:", err);
      return res.status(500).json({ error: "Errore server durante l'inserimento dell'ordine" });
    }

    const orderId = results.insertId;

    // Ora inseriamo i prodotti nella tabella ponte (es. invoice_items)
    const sqlItems = `
      INSERT INTO products_invoices (
      invoice_id,
      product_id,
      quantity)
      VALUES ?
    `;

    // Creiamo array per inserimento multiplo [ [orderId, product_id, qty, price], ... ]
    const itemsValues = products.map((p) => [orderId, p.product_id, p.quantity]);

    connection.query(sqlItems, [itemsValues], (err2) => {
      if (err2) {
        console.error("Errore inserimento prodotti:", err2);
        return res.status(500).json({ error: "Errore server durante l'inserimento dei prodotti" });
      }

      return res.status(201).json({
        message: "Ordine e prodotti salvati con successo",
        order_id: orderId,
      });
    });
  });
};

const shoesController = {
  index,
  show,
  storeInvoice,
};

export default shoesController;
