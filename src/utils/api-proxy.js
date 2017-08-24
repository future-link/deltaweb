const request = require("request-promise")
module.exports = function(req, res, next) {
    if (req.method != "POST") return next()
    console.log(req.path)
    console.log(req.body)
    request({
        method: "POST",
        uri: process.env.API_ROOT+req.path,
        body: req.body,
        json: true,
        headers: {
            passkey: process.env.API_KEY,
            "user-id": req.session.user_id
        }
    }).then(api_res => {
        res.send(api_res)
    }).catch(err => {
        res.status(err.response.statusCode || 503).send(err.error || {"error": "api-connect-error"})
    })
}
