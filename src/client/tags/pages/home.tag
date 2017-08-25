misskey-home
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
