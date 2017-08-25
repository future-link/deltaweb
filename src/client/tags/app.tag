misskey-app
    misskey-header-bar
    #app
        misskey-loading
    script.
        import "./header-bar.tag"
        import "./pages/login.tag"
        import "./loading.tag"
        import "./pages/home.tag"
        apiCall("../webapi/login-check").then(function(res) {
            if(res.login) {
                riot.mount("#app", "misskey-home")
            } else {
                riot.mount("#app", "misskey-login")
            }
        })
    style.
        #app {
            display:flex;
            justify-content: center;
        }
