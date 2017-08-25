misskey-home
    .container
        h2 ホーム
        misskey-post-form
        misskey-timeline(posts="{posts}")
    script.
        import "../common/post-form.tag"
        import "../common/timeline.tag"
        var self = this
        this.posts = []
        apiCall("posts/timeline").then(function(res){
            console.log(res)
            self.posts = res
            self.update()
        })
    style.
        .container {
            flex: 1 1 560px;
            max-width:560px;
            box-sizing: border-box;
        }
        misskey-timeline {
            max-width: 560px;
        }
