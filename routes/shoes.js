import express from 'express'
import shoesController from '../controllers/shoesController.js';


const router = express.Router();


router.get("/", shoesController.index);

router.get("/:id", shoesController.show);


export default router