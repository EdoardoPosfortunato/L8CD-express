import express from "express";
import shoesController from "../controllers/shoesController.js";

const router = express.Router();

//index
router.get("/", shoesController.index);
//show
router.get("/:id", shoesController.show);

export default router;
