import express from "express";
import router from "./routers/shoes.js";
import mailRouter from "./routers/mailRouter.js";
import cors from "cors";
import notFound from "./middleware/notFound.js";
import errorHandler from "./middleware/errorHandler.js";
import imagePath from "./middleware/imagePath.js";
import { GoogleGenAI } from "@google/genai";

const app = express();
const port = process.env.SERVER_PORT;

//body parser aggiunto
app.use(express.json());
//impostazione della cartella public per le immagini
app.use(express.static("public"));

const ai = new GoogleGenAI({apiKey: process.env.GEMINI_API_KEY});

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

app.post('/api/chat', async (req, res) => {
  const { message } = req.body


  try {

    res.setHeader("Content-Type", "text/plain; charset=utf-8");
    res.setHeader("Transfer-Encoding", "chunked");
    res.setHeader('Cache-Control', 'no-cache');
    res.setHeader('Connection', 'keep-alive');


    const response = await ai.models.generateContentStream({
      model: 'gemini-2.0-flash-001',
      contents: message,
    });

    for await (const chunk of response) {
      const text = chunk.text || "";
      console.log("Chunk:", text);
      res.write(text);
    }

    res.end();

    } catch (error) {
      console.error('Error', error.message);
      res.status(500).json({error: 'Something went wrong'})
    }
})

app.use("/shoes", imagePath, router);

app.use("/api/mail", mailRouter);

//404
app.use(notFound);

//500 e altri
app.use(errorHandler);

app.listen(port, () => {
  console.log(`la porta ${port} è aperta, chiudi fa freddo`);
});
