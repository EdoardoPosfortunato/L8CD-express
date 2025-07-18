import express from "express";
import { chatWithBot, resetChat } from "../controllers/chatbotController.js";

const router = express.Router();

router.post("/chat", chatWithBot);
router.post("/chat/reset", resetChat);

export default router;
