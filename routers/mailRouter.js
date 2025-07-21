import express from "express";
import mailController from "../controllers/mailController.js";

const router = express.Router();

//newsletter
router.post("/subscribe", mailController.subscribe);
//mail al checkout (client + admin)
router.post("/checkout", mailController.checkout);

export default router;
