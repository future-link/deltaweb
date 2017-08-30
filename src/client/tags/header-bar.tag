misskey-header-bar
    .left
        a(href="/")
            i.fa.fa-home
            |  Home
    .right
        a(href="javascript://",if="{user}")
            | @{user.screenName}
            img(src="{user.avatarThumbnailUrl}")
            misskey-my-panel(user="{user}")
    script.
        import "./my-panel.tag"
        var self = this
        apiCall("account/show", {}).then(function(res) {
            if(res.error) return
            self.user = res
            self.update()
        })
    style.
        misskey-header-bar {
            background: white;
            position: fixed;
            top:0;
            left:0;
            width: 100vw;
            display: block;
            height:3em;
            line-height:3em;
            z-index:5000; /* 兆円ほしい！ */
        }
        > div > a {
            padding: 0 1em;
            display:inline-block;
            height: 3em;
        }
        .left {
            display: inline-block;
        }
        .right{
            position:absolute;
            right: 1em;
            top: 0;
        }
        img {
            width: 2em;
            height: 2em;
            margin: -0.5em 0;
            margin-left: 0.5em;
        }
        misskey-my-panel {
            position: fixed;
            top: 3em;
            right: 0;
            display: none;
        }
        a:hover misskey-my-panel {
            display: block;
        }
