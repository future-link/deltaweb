const express = require("express")
const router = express.Router()
const WebSocket = require("ws")
const endpoints = [
    "home",
    "talk",
    "group-talk"
]

endpoints.forEach(function(endpoint) {
    router.ws("/"+endpoint,function(ws, req) {
        if (req.session.user_id == null) {
            console.log("not login")
            ws.send("error:not-login")
            return ws.close()
        }
        if (req.session.csrf != req.query.csrf) {
            console.log("invalid csrf")
            ws.send("error:invalid-csrf")
            return ws.close()
        }
        var queryobject = req.query
        queryobject["passkey"] = process.env.API_KEY
        queryobject["user-id"] = req.session.user_id
        delete queryobject["csrf"]
        var query = Object.entries(queryobject).map(([name, value]) => `${name}=${encodeURIComponent(value)}`).join("&")
        console.log(query)
        const url = process.env.API_ROOT.replace("http", "ws")+"/streams/"+endpoint+"?"+query
        console.log(url)
        var upstream = new WebSocket(url)
        upstream.on("error", () => {
            ws.close()
        })
        upstream.on("close", () => {
            ws.close()
        })
        upstream.on("message", (data) => {
            ws.send(data)
        })
        ws.on("close", () => {
            upstream.close()
        })
    })
})
module.exports = router
