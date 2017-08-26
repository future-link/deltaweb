const request = require("request-promise")
module.exports = function(req, res, next) {
    if (req.method != "POST") return next()
    if (req.path != "/album/files/upload" && req.file) return res.status(400).send({error: "this-api-is-not-support-file-upload"})
    console.log(req.path, req.file)
    var options = {
        method: "POST",
        uri: process.env.API_ROOT+req.path,
        body: req.body,
        json: true,
        headers: {
            passkey: process.env.API_KEY,
            "user-id": req.session.user_id
        },
    }
    if (req.file) {
        options.json = false
        delete options.body
        options.formData = {
            file: {
                value: req.file.buffer,
                options: {
                    contentType: req.file.mimetype,
                    filename: req.file.originalname
                }
            }
        }
    }
    request(options).then(api_res => {
        res.send(api_res)
    }).catch(err => {
        console.error(err)
        res.status(err.response.statusCode || 503).send(err.error || {"error": "api-connect-error"})
    })
}
