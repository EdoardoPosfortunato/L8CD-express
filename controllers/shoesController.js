import connection from "../db.js"


const index = (req, res) => {

res.json({
                data: "pagina delle scarpe",
            })

}

const show = (req, res) => {

    const { id } = req.params

res.json({
                data: `pagina di uan scarpa ${id}`,
            })
   
}

const shoesController = {
    index,
    show,
}

export default shoesController