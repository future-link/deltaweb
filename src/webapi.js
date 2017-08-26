const express = require("express")
const app = express.Router()
const request = require("request-promise")

app.post("/login", function(req, res) {
    request({
        method: "POST",
        uri: process.env.API_ROOT+"/login",
        body: req.body,
        json: true,
        headers: {
            passkey: process.env.API_KEY
        }
    }).then(api_res => {
        req.session.user_id = api_res.id
        req.session.save()
        res.send({result: "success"})
    }).catch(err => {
        res.status(err.response.statusCode || 503).send(err.error || {"error": "api-connect-error"})
    })
})

app.post("/logout", function(req, res) {
    req.session.destroy(function() {
        res.send({status: "ok"})
    })
})

module.exports = app
