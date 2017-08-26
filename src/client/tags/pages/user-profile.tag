misskey-user-profile
    .container(if="{loaded && !notfound}")
        .user-profile(ref="panel",style="background-image: url({this.user.bannerUrl})")
            .profile-main
                img(src="{this.user.avatarUrl}")
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
            .user-profile {
                background-color: #222;
                background-repeat: no-repeat;
                background-position: center 50%;
                background-size: cover;
                border-radius: 8px;
                text-align: center;
                color: white;
                text-shadow: 0 0 6px rgba(0,0,0,0.9);
                .profile-main {
                    padding: 2em;
                    background: rgba(0, 0, 0, 0.4);
                    border-radius: 8px;
                }
                img {
                    height: 96px;
                    width: 96px;
                    border-radius: 96px;
                }
            }
        }
        misskey-timeline {
            max-width: 560px;
        }
