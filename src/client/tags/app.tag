misskey-app
    h1 misskey
    #app
        misskey-loading
    script.
        import "./login.tag"
        import "./loading.tag"
        apiCall("../webapi/login-check").then(function(res) {
            if(res.login) {
                riot.mount("#app", "misskey-home")
            } else {
                riot.mount("#app", "misskey-login")
            }
        })
