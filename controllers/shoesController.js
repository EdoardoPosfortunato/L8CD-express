import connection from "../db.js";
import slugify from "slugify";
import imagePath from "../middleware/imagePath.js";

//index
const index = (req, res, next) => {
  const gender = req.query.gender;
  const isNew = req.query.isNew;

  let sql = "SELECT * from products";
  let params = [];
  

  if (isNew === "true") {
    sql += " WHERE price >= ?";
    params.push(160);
  } else if (gender) {
    sql += " WHERE gender = ?";
    params.push(gender);
  }

  connection.query(sql, params, (err, result) => {
    if (err) {
      return next(new Error(err));
    }

    const shoes = result.map((curShoe) => {
      return {
        ...curShoe,
        image: curShoe.image ? `${req.imagePath}/${curShoe.image}` : null
      };
    });

    res.status(200).json({
      info:
        isNew === "true"
        ? "Scarpe novità (prezzo ≥ 160)"
        : gender
        ? `Scarpe per genere: ${gender}`
        : "Tutte le scarpe",
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
          image: shoeData.image ? `${req.imagePath}/${shoeData.image}` : null
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
