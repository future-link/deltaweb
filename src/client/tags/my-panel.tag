misskey-my-panel
    .section
        a(href="/{opts.user.screenName}")
            i.fa.fa-user
            | Profile
    .section
        a(href="#",onclick="{logout}")
            i.fa.fa-sign-out
            | Logout
    script.
        this.logout = function() {
            if(!confirm("ログアウトしていいんか?")) return
            apiCall("../webapi/logout", {}).then(function() {
                location.reload()
            })
        }
    style.
        misskey-my-panel {
            background: #fff;
            width: 10em;
        }
        .section {
            margin: 0.5em 0;
        }
        i.fa {
            width: 1.5em;
            text-align: center;
            margin-right: .5em;
        }
        a {
            display:block;
            padding: 0 1em;
        }
        a:hover {
            background: #11491d;
            color: white;
        }
