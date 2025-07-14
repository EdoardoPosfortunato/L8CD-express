const imagePath = (req, res, next) => {
  const percorsoImmagine = `${req.protocol}://${req.get("host")}/img/shoes`;
  req.imagePath = percorsoImmagine;
  next();
};

export default imagePath;
