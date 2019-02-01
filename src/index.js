require("dotenv").config()
const express = require("express")
const app = express()
const rndstr = require("rndstr")
const multer = require("multer")()
const session = require("express-session")
const RedisStore = require("connect-redis")(session)
require("express-ws")(app)

const sessionOpt = {
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: false
}
if (process.env.REDIS_URL) sessionOpt.store = new RedisStore({url: process.env.REDIS_URL})
app.use(session(sessionOpt))

app.use((req, res, next) => {
    if (req.session.csrf == null) req.session.csrf = rndstr()
    next()
})

app.use(require("body-parser").urlencoded())
app.use(require("body-parser").json())

app.use("/_/resources", express.static(__dirname+"/../dist"))
app.use("/_/api", multer.single("file"), require("./utils/csrf-check"), require("./api-proxy"))
app.use("/_/webapi", require("./utils/csrf-check"), require("./webapi"))
app.use("/_/api/ws", require("./websocket-proxy"))
app.set("views", __dirname+"/views")
app.set("view engine", "pug")

app.ws("/*", (ws, req) => {
    ws.send("error:path-not-found:"+req.path)
    ws.close()
})

app.get("*", (req, res) => {
    res.render("bootstrap",{
        csrf: req.session.csrf
    })
})

app.listen(process.env.PORT || 3000, () => {
    // eslint-disable-next-line no-console
    console.log("listen for "+(process.env.PORT || 3000)+" port")
})
