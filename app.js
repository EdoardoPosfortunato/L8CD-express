import express from 'express'
import router from './routes/shoes.js';
import cors from 'cors'



const app = express();
const port = process.env.SERVER_PORT;


app.use(express.json());
app.use(express.static("public"))

// connessione con react /////
app.use(
    cors({
        origin: process.env.FE_URL,
    })
);
/////////////////////////////

app.get("/", (req, res) => {
    res.json({
        data: "benvenuto nel API delle scarpe"
    })
})

app.use("/shoes", router)


app.listen(port, () => {
    console.log(`la porta ${port} è aperta, chiudi fa freddo`)
})