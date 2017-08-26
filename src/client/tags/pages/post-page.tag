misskey-post-page
    .container(if="{loaded && !notfound}")
        a(href="/{post.user.screenName}/{post.nextPost}",if="{post.nextPost}") つぎの
        misskey-post(if="{post}",post="{post}")
        a(href="/{post.user.screenName}/{post.prevPost}",if="{post.prevPost}") まえの
    misskey-notfound(if="{notfound}")
    misskey-loading(if="{!loaded && !notfound}")
    script.
        import "../common/post.tag"
        import "./notfound.tag"
        var self = this
        this.on("mount", function() {
            apiCall("posts/show", {
                "post-id": this.opts.post_id
            }).then(function(res){
                if(res.error) {
                    self.notfound = true
                    self.update()
                    return
                }
                self.loaded = true
                self.post = res
                self.update()
            })
        })
    style.
        > .container{
            margin-top: 1em;
            text-align:center;
        }
        > .container > a{
            display: inline-block;
            margin: 1em 0;
            color: #c8cac3;
        }
        misskey-post{
            text-align: left;
        }
