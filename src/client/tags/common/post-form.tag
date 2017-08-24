misskey-post-form
    form(ref="form")
        textarea(name="text")
        button(type="button",onclick="{send}") 投稿
        script.
            this.send = function() {
                apiCall("posts/create", new FormData(this.refs.form)).then(function(){
                    location.reload()
                })
            }
