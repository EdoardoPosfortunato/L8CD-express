import { GoogleGenAI } from "@google/genai";
import { systemPrompt } from "../prompt/systemPrompt.js";

const ai = new GoogleGenAI({ apiKey: process.env.GEMINI_API_KEY });

let chatHistory = [{ role: "user", parts: [{ text: systemPrompt }] }];

export const chatWithBot = async (req, res) => {
  const { message } = req.body;

  try {
    chatHistory.push({ role: "user", parts: [{ text: message }] });

    res.setHeader("Content-Type", "text/plain; charset=utf-8");
    res.setHeader("Transfer-Encoding", "chunked");
    res.setHeader("Cache-Control", "no-cache");
    res.setHeader("Connection", "keep-alive");

    const response = await ai.models.generateContentStream({
      model: "gemini-2.0-flash-001",
      contents: chatHistory,
    });

    let modelResponse = "";
    for await (const chunk of response) {
      const text = chunk.text || "";
      modelResponse += text;
      res.write(text);
    }

    chatHistory.push({ role: "model", parts: [{ text: modelResponse }] });
    res.end();
  } catch (error) {
    console.error("Errore nella chat:", error.message);
    res.status(500).json({ error: "Errore durante la conversazione" });
  }
};

export const resetChat = (req, res) => {
  chatHistory = [chatHistory[0]]; // solo il prompt iniziale
  res.json({ message: "Conversazione resettata" });
};
