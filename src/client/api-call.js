module.exports = function(endpoint, params) {
    var csrf = document.querySelector("meta[name=csrf-token]").content
    if (params == null) params = {}
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
    console.log(params)
    if (params instanceof FormData) {
        // なにもしない
        params.append("csrf", csrf)
    } else {
        headers["Content-Type"] = "application/json"
        params.csrf = csrf
        params = JSON.stringify(params)
    }
    return fetch("/_/api/"+endpoint, {
        method: "POST",
        body: params,
        headers: headers,
        credentials: 'include'
    }).then(function(res) {
        return res.text()
    }).then(function(res) {
        if(res == "invalid-csrf-token") {
            alert("セッションが切れたのでリロードします！！！")
            location.reload()
        }
        return Promise.resolve(JSON.parse(res))
    }).then(function(res) {
        if (endpoint == "account/show") {
            window.USER = res
        }
        return Promise.resolve(res)
    })
}
