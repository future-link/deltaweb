misskey-post-form
    form(ref="form")
        input(type="hidden", name="files", ref="files_input")
        textarea(name="text",onkeydown="{ctrlentercheck}",onpaste="{paste}",ref="textarea")
        .files
            .file(each="{file in files}")
                a(href="{file.url}",target="_blank")
                    img(src="{file.thumbnailUrl}")
                .name {file.name}
                .description {file.mimeType}
                button(type="button", onclick="{removefileclick}")
                    i.fa.fa-close
        .actions
            button(type="button",onclick="{fileattachclick}")
                i.fa.fa-upload
            .right
                span {errorMessage}
                button(type="button",onclick="{send}").post-button 投稿
    form(ref="darkform").darkside
        input(type="file",name="file",ref="fileselector",onchange="{fileinputchange}")
    script.
        var self = this
        this.files = []
        var errorVer = 0
        this.removefileclick = function(e) {
            var select_file = this.file
            self.files = this.files.filter(function(file){
                console.log(select_file, file)
                return select_file.id != file.id
            })
            self.update()
        }
        this.fileattachclick = function() {
            this.refs.fileselector.click()
        }
        function upload(form) {
            return apiCall("../api/album/files/upload", form).then(function(res){
                if(res.error) {
                    alert(res.error)
                    return
                }
                self.files.push(res)
                self.update()
            })
        }
        this.fileinputchange = function() {
            console.log(this.refs.fileselector.value)
            upload(this.refs.darkform)
            this.refs.fileselector.value = ""
        }
        this.paste = function(e) {
            var clipboardData = e.clipboardData || e.originalEvent.clipboardData || window.clipboardData;
            if(!clipboardData && !clipboardData.items && !clipboardData.items.length) return;
            console.log(clipboardData);
            var item;
            Array.prototype.forEach.call(clipboardData.items,function(item_){
                if(item_.kind != "file") return;
                item = item_;
            })
            if(!item) return;
            e.preventDefault();
            var file = item.getAsFile();
            var form = new FormData();
            form.append("file", file)
            upload(form);
        }
        this.send = function() {
            this.refs.files_input.value = this.files.map(function(file){return file.id}).join(",")
            console.log(this.refs.files_input.value)
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
                self.files = []
                self.update()
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
        .darkside{
            display: none;
        }
        .file {
            margin: 0.5em 0;
            position:relative;
            img {
                width: 3em;
                height: 3em;
                float:left;
                padding-right: 0.5em;
            }
            button {
                position:absolute;
                right:0;
                top:0;
                bottom:0;
            }
            line-height: 1.5em;
        }
