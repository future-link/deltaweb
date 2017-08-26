misskey-my-panel
    .section
        a(href="/{opts.user.screenName}")
            i.fa.fa-user
            | Profile
    .section
        a(href="/i/settings")
            i.fa.fa-cog
            | Settings
        a(href="https://github.com/Petitsurume/deltaweb/issues/new",target="_blank")
            i.fa.fa-comment-o
            | Feedback
        a(href="javascript://",onclick="{logout}")
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
            background: rgba(255,255,255,0.5);
            width: 10em;
        }
        .section {
            margin: 0.5em 0 0;
            background: white;
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
