misskey-app
    misskey-header-bar
    #app
        misskey-loading
    script.
        import "./header-bar.tag"
        import "./pages/login.tag"
        import "./loading.tag"
        import "./pages/home.tag"
        import "./pages/user-profile.tag"
        import "./pages/post-page.tag"
        import "./pages/notfound.tag"
        var route = require("page")
        var pages = [
            {path: "/", tag: "home", login: true},
            {path: "/:user", tag: "user-profile", params:{type: "timeline"}},
            {path: "/:user/following", tag: "user-profile", params:{type: "following"}},
            {path: "/:user/followers", tag: "user-profile", params:{type: "followers"}},
            {path: "/:user/:post_id", tag: "post-page"},
            {path: "*", tag: "notfound"}
        ]
        apiCall("account/show").then(function(res) {
            console.log(res)
            var isLogin = res.error == null
            pages.forEach(function(page) {
                route(page.path, function(info){
                    console.log(page.path, arguments)
                    if (page.login && !isLogin) {
                        riot.mount("#app", "misskey-login")
                        return
                    }
                    riot.mount("#app", "misskey-"+page.tag, Object.assign(page.params || {}, info.params))
                })
            })
            route.stop()
            route.start()
        })
    style.
        #app {
            display:flex;
            justify-content: center;
        }
