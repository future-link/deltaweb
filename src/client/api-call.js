module.exports = function(endpoint, params) {
    if (params instanceof HTMLFormElement) {
        var use_formdata = false
        var n_params = {}
        Array.from(params.querySelectorAll("[name]")).forEach(function(dom){
            if(dom.type == "file") use_formdata = true
            n_params[dom.name] = dom.value
        })
        if (use_formdata) {
            params = new FormData(params)
        } else {
            params = n_params
        }
    }
    var headers = {}
    if (params instanceof FormData) {
        // なにもしない
    } else {
        headers["Content-Type"] = "application/json"
        params = JSON.stringify(params)
    }
    return fetch("/_/api/"+endpoint, {
        method: "POST",
        body: params,
        headers: headers,
        credentials: 'include'
    }).then(function(res) {
        return res.json()
    })
}
