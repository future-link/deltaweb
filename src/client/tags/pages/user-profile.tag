misskey-user-profile
    .container(if="{loaded && !notfound}")
        h2 {user.name}
        span @{user.screenName}
        misskey-timeline(posts="{posts}")
    misskey-notfound(if="{notfound}")
    script.
        import "./notfound.tag"
        var self = this
        this.loaded = false
        this.on("mount", function() {
            apiCall("users/show", {
                "screen-name": this.opts.user
            }).then(function(res){
                if(res.error === "not-found") {
                    self.notfound = true
                    self.update()
                }
                self.user = res
                self.loaded = true
                self.update()
                apiCall("posts/user-timeline", {
                    "user-id": self.user.id
                }).then(function(res){
                    self.posts = res
                    self.update()
                })
            })
        })
    style.
        .container {
            flex: 1 1 560px;
            max-width:560px;
            box-sizing: border-box;
        }
        misskey-timeline {
            max-width: 560px;
        }
        @media screen and (max-width: 580px) {
            .container {
                max-width: 100vw;
                max-width: calc(100vw - 20px);
            }
        }
