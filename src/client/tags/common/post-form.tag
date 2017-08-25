misskey-post-form
    form(ref="form")
        textarea(name="text",onkeydown="{ctrlentercheck}")
        button(type="button") 何らか
        button(type="button",onclick="{send}").post-button 投稿
        script.
            this.send = function() {
                apiCall("posts/create", this.refs.form).then(function(){
                    location.reload()
                })
            }
            this.ctrlentercheck = function(e) {
                if((e.metaKey || e.ctrlKey) && e.keyCode == 13) {
                    this.send()
                }
            }
        style.
            misskey-post-form {
                display:block;
            }
            textarea {
                width: 100%;
                resize: vertical;
                min-height:5em;
            }
            button.post-button {
                float:right;
            }
