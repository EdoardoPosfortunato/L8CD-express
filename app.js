import express from "express";
import router from "./routers/shoes.js";
import mailRouter from "./routers/mailRouter.js";
import cors from "cors";
import notFound from "./middleware/notFound.js";
import errorHandler from "./middleware/errorHandler.js";
import imagePath from "./middleware/imagePath.js";
import "dotenv/config";
import { GoogleGenAI } from "@google/genai";

const app = express();
const port = process.env.SERVER_PORT;
const ai = new GoogleGenAI({ apiKey: process.env.GEMINI_API_KEY });

app.use(express.json());
app.use(express.static("public"));

app.use(cors({ origin: process.env.FE_URL }));

app.get("/", (req, res) => {
  res.json({ data: "Benvenuto nell'API delle scarpe" });
});

app.post("/api/chat", async (req, res) => {
  const { message } = req.body;

  try {
    res.setHeader("Content-Type", "text/plain; charset=utf-8");
    res.setHeader("Transfer-Encoding", "chunked");
    res.setHeader("Cache-Control", "no-cache");
    res.setHeader("Connection", "keep-alive");

    const systemPrompt = `Sei un assistente virtuale specializzato in scarpe. Rispondi solo a domande su scarpe, calzature, modelli, acquisti, resi, spedizioni o argomenti correlati. Se la domanda non riguarda le scarpe, rispondi gentilmente che puoi solo parlare di scarpe.`;

    const response = await ai.models.generateContentStream({
      model: "gemini-2.0-flash-001",
      contents: [
        { role: "user", parts: [{ text: systemPrompt }] },
        { role: "user", parts: [{ text: message }] }
      ]
    });

    for await (const chunk of response) {
      const text = chunk.text || "";
      console.log("Chunk:", text);
      res.write(text);
    }

    res.end();
  } catch (error) {
    console.error("Error", error.message);
    res.status(500).json({ error: "Something went wrong" });
  }
});

app.use("/shoes", imagePath, router);
app.use("/api/mail", mailRouter);
app.use(notFound);
app.use(errorHandler);

app.listen(port, () => {
  console.log(`La porta ${port} è aperta, chiudi fa freddo`);
});
