import express from "express";
import shoesController from "../controllers/shoesController.js";

const router = express.Router();

//index
router.get("/", shoesController.index);
//show
router.get("/:id", shoesController.show);
//store invoice
router.post("/store", shoesController.storeInvoice);

export default router;
