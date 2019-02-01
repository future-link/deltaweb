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
    a(href="{opts.url}",if="{loaded && !embed_player}",target="_blank")
        h1(if="{info.title}") {info.title}
        .description {info.description}
    .embed-player-wrapper(if="{embed_player}")
        iframe.embed-player(allowfullscreen, src="https://www.youtube.com/embed/{video_id}",if="{embed_player == 'youtube'}", sandbox="allow-scripts allow-forms allow-modals allow-popups allow-popups-to-escape-sandbox allow-same-origin")
    script.
        this.loaded = false
        var self = this
        this.on("mount", function() {
            // youtube check
            var url = new URL(this.opts.url)
            var query = {}
            url.search.substring(1).split("&").forEach(function(param){
                param=param.split("=")
                query[param[0]]=param[1]
            })
            console.log(query)
            function youtube_t_to_sec(t){
                var hour = /([0-9]+)h/.test(t) ? parseInt(/([0-9]+)h/.exec(t)[1]) : 0
                var minute = /([0-9]+)m/.test(t) ? parseInt(/([0-9]+)m/.exec(t)[1]) : 0
                var second = /([0-9]+)s/.test(t) ? parseInt(/([0-9]+)s/.exec(t)[1]) : 0
                console.log(hour,minute,second)
                return second + (minute * 60) + (hour * 60 * 60)
            }
            if(url.hostname == "youtu.be") {
                this.video_id = url.pathname.substring(1)+"?rel=0"+(query.t ? "&start="+youtube_t_to_sec(query.t) : "")
                this.embed_player = "youtube"
                this.update()
                return
            }
            console.log(url.hostname, url.pathname, query)
            if(url.hostname.slice(-11) == "youtube.com" && url.pathname == "/watch" && query.v){
                this.video_id = query.v+"?rel=0"+(query.t ? "&start="+youtube_t_to_sec(query.t) : "")
                this.embed_player = "youtube"
                this.update()
                return
            }
            fetch("https://analizzatore.prezzemolo.org/?url="+this.opts.url).then(function(res){
                if (!res.ok) throw new Error('server respond with the status code greater than 400.')
                return res.json()
            }).then(function(res){
                self.info = res
                self.loaded = true
                self.update()
            }).catch(function(err){
                console.error(err)
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
        .embed-player-wrapper{
            position:relative;
            width:100%;
            padding-top: 56%;
        }
        .embed-player{
            position:absolute;
            top:0;
            bottom:0;
            left:0;
            right:0;
            width:100%;
            height:100%;
            border:none;
            border: solid 1px #EFE4DF;
            border-radius: 4px;
        }
