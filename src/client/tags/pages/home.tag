misskey-home
    .container
        h2 ホーム
        misskey-post-form
        misskey-timeline(posts="{posts}")
        misskey-loading(if="{!loaded}")
    script.
        import "../common/post-form.tag"
        import "../common/timeline.tag"
        import "../loading.tag"
        var self = this
        this.posts = []
        this.loaded = false
        apiCall("posts/timeline").then(function(res){
            console.log(res)
            self.posts = res
            self.loaded = true
            self.update()
        })
        function connectWS() {
            var reconnect = true
            var ws = new WebSocket(location.origin.replace("http", "ws")+"/_/api/ws/home?csrf="+(document.querySelector("meta[name=csrf-token]").content))
            ws.addEventListener("message", function(mes){
                try{
                    mes = JSON.parse(mes.data)
                } catch (e) {
                    console.log(mes.data)
                }
                console.log(mes)
                switch(mes.type) {
                    case "post":
                        self.posts.unshift(mes.value)
                        self.update()
                        break;
                }
            })
            ws.addEventListener("close", function(){
                console.log("websocket disconnected")
                if (!reconnect) return
                setTimeout(function(){
                    connectWS()
                }, 250)
            })
            self.on("unmount", function() { // 省エネ
                reconnect = false
                ws.close()
            })
        }
        connectWS()
    style.
        .container {
            flex: 1 1 560px;
            max-width:560px;
            box-sizing: border-box;
        }
        misskey-timeline {
            max-width: 560px;
        }
        @media screen and (max-width: 580px) {
            .container {
                max-width: 100vw;
                max-width: calc(100vw - 20px);
            }
        }
