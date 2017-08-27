misskey-home
    .container
        h2 ホーム
        misskey-post-form
        misskey-timeline(posts="{posts}",readmore="{readmore}")
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
        this.readmore = function() {
            var last_post = self.posts[self.posts.length-1]
            console.log(last_post)
            apiCall("posts/timeline",{"max-cursor": last_post.cursor}).then(function(res){
                if(res.error) return alert(res.error)
                self.posts = self.posts.concat(res)
                self.update()
            })
        }
        function connectWS() {
            var reconnect = true
            var ws = require("../../streaming-call.js")("home")
            ws.addEventListener("message", function(mes){
                if (mes.data == "error:not-login") reconnect = false
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
                }, 500)
            })
            self.on("unmount", function() { // 省エネ
                reconnect = false
                ws.close()
            })
        }
        connectWS()
