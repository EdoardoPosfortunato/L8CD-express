import connection from "../db.js";
import slugify from "slugify";

//index
const index = (req, res) => {
  const sql = "SELECT * from products";

  connection.query(sql, (err, result) => {
    if (err) {
      return next(new Error(err));
    }

    const shoes = result.map((curShoe) => {
      return {
        ...curShoe,
        // image: `${req.imagePath}/${curShoe.image}`,
      };
    });

    res.status(200).json({
      info: "stampo le scarpe",
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
          // image: `${req.imagePath}/${result.image}`,
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
