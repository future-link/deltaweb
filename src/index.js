require("dotenv").config()
const express = require("express")
const app = express()
const rndstr = require("rndstr")
require("express-ws")(app)

app.use(require("express-session")({
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: false
}))

app.use((req, res, next) => {
    if (req.session.csrf == null) req.session.csrf = rndstr()
    next()
})

app.use(require("body-parser").urlencoded())
app.use(require("body-parser").json())

app.use(require("./utils/csrf-check"))
app.use("/_/resources", express.static(__dirname+"/../dist"))
app.use("/_/api", require("./api-proxy"))
app.use("/_/webapi", require("./webapi"))
app.use("/_/api/ws", require("./websocket-proxy"))
app.set("views", __dirname+"/views")
app.set("view engine", "pug")

app.get("/", (req, res) => {
    res.render("bootstrap",{
        csrf: req.session.csrf
    })
})

app.listen(process.env.PORT || 3000, () => {
    console.log("listen for "+(process.env.PORT || 3000)+" port")
})
