module.exports = function(req, res, next) {
    if (req.method != "POST") return next()
    if (req.session.csrf == req.body.csrf) return next()
    res.status(403).send("invalid-csrf-token")
}
