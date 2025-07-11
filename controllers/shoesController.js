import connection from "../db.js";
import slugify from "slugify";

//index
const index = (req, res) => {
  res.json({
    data: "pagina delle scarpe",
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
