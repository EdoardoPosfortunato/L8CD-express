import connection from "../db.js";
import slugify from "slugify";

//index
const index = (req, res, next) => {
  const gender = req.query.gender;
  const isNew = req.query.isNew;
  const name = req.query.name;
  const brand = req.query.brand;

  let sql = "SELECT * from products";
  let params = [];
  let conditions = [];

  // filtro per per prezzo
  if (isNew === "true") {
    conditions.push("price >= ?");
    params.push(160);
  }

  // filtro per genere
  if (gender) {
    conditions.push("gender = ?");
    params.push(gender);
  }

  // filtro per nome. Usiamo il like per far si che i filtri sono anche parziali
  if (name) {
    conditions.push("name LIKE ?");
    params.push(`%${name}%`);
  }

  // filtro per marca delle scarpe. Usiamo il like per far si che i filtri sono anche parziali
  if (brand) {
    conditions.push("brand LIKE ?");
    params.push(`%${brand}%`);
  }

  // condizioni finali dove vengono sommate tutte le condizioni inserite prima
  if (conditions.length > 0) {
    sql += " WHERE " + conditions.join(" AND ");
  }

  connection.query(sql, params, (err, result) => {
    if (err) {
      return next(new Error(err));
    }

    const shoes = result.map((curShoe) => {
      return {
        ...curShoe,
        image: curShoe.image ? `${req.imagePath}/${curShoe.image}` : null,
      };
    });

    res.status(200).json({
      info: isNew === "true" ? "Scarpe novità (prezzo ≥ 160)" : gender ? `Scarpe per genere: ${gender}` : "Tutte le scarpe",
      totalcount: result.length,
      data: shoes,
    });
  });
};

//show
const show = (req, res) => {
  const id = req.params.id;

  const shoeRequest = `SELECT products.*
                         FROM products
                         WHERE products.id = ?;`;

  connection.query(shoeRequest, [id], (err, result) => {
    if (err) {
      return res.status(404).json({
        status: "404",
        info: "Scarpa non trovata",
      });
    } else {
      const shoeData = result[0];
      res.status(200).json({
        data: {
          ...shoeData,
          image: shoeData.image ? `${req.imagePath}/${shoeData.image}` : null,
        },
      });
    }
  });
};

const shoesController = {
  index,
  show,
};

export default shoesController;
