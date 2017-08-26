misskey-user-profile
    .container(if="{loaded && !notfound}")
        .user-profile(ref="panel",style="background-image: url({this.user.bannerUrl})")
            .profile-main
                img(src="{this.user.avatarUrl}")
                h2 {user.name}
                span @{user.screenName}
        .user-info
            ul
                li(class="{active:opts.type == 'timeline'}"): a(href="/{this.user.screenName}")
                    p 投稿
                    span {user.postsCount}
                li(class="{active:opts.type == 'following'}"): a(href="/{this.user.screenName}/following")
                    p フォロー
                    span {user.followingCount}
                li(class="{active:opts.type == 'followers'}"): a(href="/{this.user.screenName}/followers")
                    p フォロワー
                    span {user.followersCount}
        misskey-user-profile-timeline(user="{user}",if="{loaded && opts.type == 'timeline'}")
        misskey-user-profile-following(user="{user}",if="{loaded && opts.type == 'following'}")
        misskey-user-profile-followers(user="{user}",if="{loaded && opts.type == 'followers'}")
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
            })
        })
    style.
        .container {
            .user-profile {
                background-color: #222;
                background-repeat: no-repeat;
                background-position: center 50%;
                background-size: cover;
                border-radius: 8px 8px 0 0;
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
        .user-info{
            background: white;
            ul {
                display: flex;
                list-style: none;
                margin: 0;
                padding: 0;
                li {
                    display: inline-block;
                    margin: 0;
                    padding: 0;
                    flex: 1;
                    &.active {
                        color: #11491d;
                        border-bottom: solid 3px #11491d;
                    }
                    a{
                        display: inline-block;
                        text-align: center;
                        width: 100%;
                        padding: 0.5em 0;
                    }
                    p {
                        margin: 0;
                        padding: 0;
                        font-size: 0.7em;
                    }
                }
            }
        }
misskey-user-profile-timeline
    misskey-timeline(posts="{posts}")
    script.
        var self = this
        this.on("mount", function() {
            apiCall("posts/user-timeline", {
                "user-id": self.opts.user.id
            }).then(function(res){
                self.posts = res
                self.update()
            })
        })
misskey-user-profile-following
    misskey-users(users="{users}")
    script.
        import "../common/users.tag"
        var self = this
        this.on("mount", function() {
            apiCall("users/following", {
                "user-id": self.opts.user.id
            }).then(function(res){
                self.users = res
                self.update()
            })
        })
misskey-user-profile-followers
    misskey-users(users="{users}")
    script.
        import "../common/users.tag"
        var self = this
        this.on("mount", function() {
            apiCall("users/followers", {
                "user-id": self.opts.user.id
            }).then(function(res){
                self.users = res
                self.update()
            })
        })
