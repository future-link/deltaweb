require("dotenv").config()
const express = require("express")
const app = express()

app.use("/_/resources", express.static(__dirname+"/../dist"))
app.set("views", __dirname+"/views")
app.set("view engine", "pug")

app.get("/", (req, res) => {
    res.render("bootstrap")
})

app.listen(3000, () => {
    console.log("listen for 3000 port")
})
