misskey-post-form
    form(ref="form")
        textarea(name="text",onkeydown="{ctrlentercheck}",ref="textarea")
        .actions
            button(type="button") 何らか
            .right
                span {errorMessage}
                button(type="button",onclick="{send}").post-button 投稿
        script.
            var self = this
            var errorVer = 0
            this.send = function() {
                apiCall("posts/create", this.refs.form).then(function(res){
                    if(res.error) {
                        self.errorMessage = res.error
                        var nowErrorVer = ++errorVer
                        setTimeout(function(){
                            if(nowErrorVer != errorVer) return
                            self.errorMessage = ""
                            self.update()
                        }, 5 * 1000)
                        self.update()
                        return
                    }
                    self.refs.textarea.value = ""
                })
            }
            this.ctrlentercheck = function(e) {
                if(self.refs.textarea.value === "") return
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
            .actions {
                position:relative;
                .right {
                    position:absolute;
                    right: 0;
                    top:0;
                }
            }
