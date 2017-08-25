misskey-login
    h2 ログイン
    form(ref="form")
        input(type="text", name="screen-name",placeholder="screen-name")
        input(type="password", name="password",placeholder="password")
        button(type="button", onclick="{post}") ログイン
    script.
        this.post = function () {
            apiCall("../webapi/login", new FormData(this.refs.form)).then(function(){
                location.reload()
            })
        }.bind(this)
