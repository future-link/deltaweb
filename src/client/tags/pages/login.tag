misskey-login
    .container
        h2 ログイン
        form(ref="form")
            input(type="text", name="screen-name",placeholder="screen-name")
            input(type="password", name="password",placeholder="password")
            button(type="button", onclick="{post}") ログイン
    script.
        this.post = function () {
            apiCall("../webapi/login", this.refs.form).then(function(){
                location.reload()
            })
        }.bind(this)
    style.
        .container {
            margin: 16px;
            padding: 16px;
            background: white;
            max-width:320px;
            flex: 1 1 320px;
            border-radius: 4px;
            text-align: center;
        }
        input {
            display: block;
            padding: 0.5em;
            margin: 16px 0;
            border: solid 2px #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            width: 100%;
            font-size: 1em;
        }
        h2 {
            margin-top: 0;
        }
