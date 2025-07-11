import express from "express";
import router from "./routers/shoes.js";
import cors from "cors";

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

app.use("/shoes", router);

//404

//500 errore generico

app.listen(port, () => {
  console.log(`la porta ${port} è aperta, chiudi fa freddo`);
});
