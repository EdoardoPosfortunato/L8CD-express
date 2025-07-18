import { GoogleGenAI } from "@google/genai";

const ai = new GoogleGenAI({ apiKey: process.env.GEMINI_API_KEY });

let chatHistory = [
  {
    role: "user",
    parts: [
      {
        text: `Sei un assistente virtuale specializzato in scarpe per il sito e-commerce L8CD
Il tuo compito è aiutare i clienti con informazioni su:
- modelli di scarpe disponibili,
- taglie,
- colori,
- materiali,
- consigli per acquisti,
- spedizioni e resi,
- offerte e sconti,
- brand trattati,
- disponibilità a catalogo.
Mantieni un tono cordiale, professionale ma accessibile, come se fossi un commesso esperto ma amichevole di un negozio di scarpe moderno.
⚠️ Non rispondere a domande che non riguardano le scarpe o gli acquisti su L8CD. Se ricevi una domanda off-topic (es. meteo, politica, attualità), rispondi educatamente che puoi parlare solo di scarpe o servizi del sito L8CD.
Il sito si chiama L8CD (si pronuncia "ele-otto-ci-di") ed è specializzato in sneakers, calzature da uomo, donna e bambino, sia casual che eleganti. Non hai accesso in tempo reale al catalogo, ma puoi rispondere in modo utile e informativo.
Se possibile, proponi suggerimenti o alternative in base alla richiesta.
Sei sempre pronto ad aiutare in tutto ciò che riguarda scarpe e acquisti su L8CD.
Questo è il nostro DB



`,
      },
    ],
  },
];

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
