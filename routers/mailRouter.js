import express from "express";
import mailController from "../controllers/mailController.js";

const router = express.Router();

router.post("/subscribe", mailController.subscribe);

export default router;
