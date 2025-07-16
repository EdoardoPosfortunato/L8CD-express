import express from "express";
import router from "./routers/shoes.js";
import mailRouter from "./routers/mailRouter.js";
import cors from "cors";
import notFound from "./middleware/notFound.js";
import errorHandler from "./middleware/errorHandler.js";
import imagePath from "./middleware/imagePath.js";

const app = express();
const port = process.env.SERVER_PORT;

//body parser aggiunto
app.use(express.json());
//impostazione della cartella public per le immagini
app.use(express.static("public"));

// connessione con react /////
app.use(
  cors({
    origin: process.env.FE_URL,
  })
);

/////////////////////////////
app.get("/", (req, res) => {
  res.json({
    data: "benvenuto nel API delle scarpe",
  });
});

app.use("/shoes", imagePath, router);

app.use("/api/newsletter", mailRouter);

//404
app.use(notFound);

//500 e altri
app.use(errorHandler);

app.listen(port, () => {
  console.log(`la porta ${port} è aperta, chiudi fa freddo`);
});
