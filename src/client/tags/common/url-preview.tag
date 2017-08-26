misskey-url-preview
    virtual(each="{url in urls()}")
        misskey-url-preview-url(url="{url}")
    script.
        this.urls = function() {
            var urls = []
            var regex = /https?:\/\/[0-9a-z_\.\-~%!$&'()*+,;=@:]+[\/0-9a-z_\.\-~%!$&'()*+,;=@:\?#]*/gi
            var result
            while (result = regex.exec(this.opts.text)) {
                urls.push(result[0])
            }
            return urls
        }
    style.
        misskey-url-preview {
            display:block;
        }
misskey-url-preview-url
    a(href="{opts.url}",if="{loaded}",target="_blank")
        h1(if="{info.title}") {info.title}
        .description {info.description}
    script.
        this.loaded = false
        var self = this
        this.on("mount", function() {
            fetch("https://analizzatore.prezzemolo.ga/?url="+this.opts.url).then(function(res){
                return res.json()
            }).then(function(res){
                self.info = res
                self.loaded = true
                self.update()
            })
        })
    style.
        misskey-url-preview-url {
            display:block;
        }
        a{
            display:block;
            padding: 12px;
            margin: 8px 0 0 0;
            border: solid 1px #EFE4DF;
            border-radius: 4px;
        }
        h1 {
            margin: 0;
            font-size: 1em;
            color: #A07A6D;
        }
        .description {
            margin: 4px;
            font-size: 0.9em;
            color: #AF7C65;
        }
