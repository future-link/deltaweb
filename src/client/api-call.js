module.exports = function(endpoint, params) {
    if (params instanceof FormData) {
        var n_params = {}
        Array.from(params.keys()).forEach(name => {
            n_params[name] = params.get(name)
        })
        params = n_params
        console.log(params)
    }
    return fetch("/_/api/"+endpoint, {
        method: "POST",
        body: JSON.stringify(params),
        headers: {
            "Content-Type": "application/json"
        }
    }).then(function(res) {
        return res.json()
    })
}
