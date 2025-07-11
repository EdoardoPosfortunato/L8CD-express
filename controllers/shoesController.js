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
      console.log(curShoe);

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
  const { id } = req.params;

  res.json({
    data: `pagina di una scarpa ${id}`,
  });
};

const shoesController = {
  index,
  show,
};

export default shoesController;
