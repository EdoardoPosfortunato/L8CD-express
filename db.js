import mysql from 'mysql2'

const connection = mysql.createConnection({

    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PSW,
    database: process.env.DB_DATABASE

})

connection.connect((err) => {
    if (err) throw err;
    console.log("la connessione al DB i mySQL funziona")
})

export default connection