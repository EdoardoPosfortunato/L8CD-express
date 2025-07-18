import express from "express";
import router from "./routers/shoes.js";
import mailRouter from "./routers/mailRouter.js";
import chatbotRouter from "./routers/chatbotRoute.js";
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


app.use("/shoes", imagePath, router); //route per DB
app.use("/api/mail", mailRouter); // route per mail
app.use("/api", chatbotRouter); // route per chatbot
app.use(notFound);
app.use(errorHandler);

app.listen(port, () => {
  console.log(`Server attivo sulla porta ${port}`);
});
