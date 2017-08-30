misskey-post(id="{post().id}")
    .repost-info(if="{opts.post.type == 'repost'}")
        img(src="{opts.post.user.avatarThumbnailUrl}")
        i.fa.fa-retweet
        | Reposted by 
        a.name(href="/{opts.post.user.screenName}") {opts.post.user.name}
    misskey-subpost(if="{opts.post.type == 'reply'}",post="{opts.post.inReplyToPost}")
    .main
        .avatar-area
            a(href="/{post().user.screenName}")
                img(src="{post().user.avatarThumbnailUrl}")
        .header
            .author
                a.name(href="/{post().user.screenName}") {post().user.name}
                span.screen-name {post().user.screenName}
            .right
                a(href="/{post().user.screenName}/{post().id}")
                    misskey-relative-time(date="{new Date(post().createdAt)}")
        .content
            .text: misskey-text-render(text="{post().text}")
            misskey-url-preview(text="{post().text}")
            .files
                ol: li(each="{file in post().files}")
                    video.content(src="{file.url}",if="{file.mimeType.startsWith('video')}",controls,preload="metadata")
                    a(href="{file.url}",if="{file.mimeType.startsWith('image')}",target="_blank")
                        img.content(src="{file.thumbnailUrl}",alt="{file.name}")
    .footer
        ul
            li: button(type="button", onclick="{reply}"): i.fa.fa-reply
            li: button(type="button", onclick="{repost}", class="{active: this.post().isReposted}"): i.fa.fa-retweet
            li: button(type="button", onclick="{like}", class="{active: this.post().isLiked}"): i.fa.fa-thumbs-o-up
    script.
        import "./subpost.tag"
        import "./text-render.tag"
        import "./url-preview.tag"
        import "./relative-time.tag"
        var self = this
        this.post = function() {
            return this.opts.post.post || this.opts.post
        }
        this.reply = function() {
            var text = prompt("@"+this.post().user.screenName+"の投稿「"+this.post().text+"」へのリプライ", "@"+this.post().user.screenName+" ")
            if (text == null) return
            apiCall("posts/reply", {
                "text": text,
                "in-reply-to-post-id": this.post().id
            }).then(function(){
                // いい話
            })
        }
        this.repost = function() {
            apiCall("posts/repost", {
                "post-id": this.post().id
            }).then(function(){
                (self.opts.post.type == "repost" ? self.opts.post.post : self.opts.post).isReposted = true
                self.update()
            })
        }
        this.like = function() {
            apiCall("posts/like", {
                "post-id": this.post().id
            }).then(function(){
                (self.opts.post.type == "repost" ? self.opts.post.post : self.opts.post).isLiked = true
                self.update()
            })
        }
    style.
        misskey-post {
            display:block;
            background: #fffbfb;
            padding: 12px 0;
            margin: 0;
            margin-bottom: 1px;
        }
        .repost-info{
            margin: 0;
            padding: 8px 32px;
            line-height: 28px;
            color: #57bb00;
            > img{
                float:left;
                height:28px;
                width:28px;
                margin-right: 8px;
            }
            > i{
                margin-right: 4px;
            }
        }
        > .main {
            padding: 16px 32px;
            padding-left: 90px;
            > .avatar-area {
                float: left;
                margin-left: -74px;
                > a{
                    display: block;
                    > img{
                        width:58px;
                        height:58px;
                        border-radius: 8px;
                        vertical-align: bottom;
                    }
                }
            }
            > .header {
                border-bottom: 4px;
                > .author {
                    display: inline-block;
                    > a {
                        color: #736060;
                        text-decoration: none;
                    }
                    > .screen-name {
                        margin-left: 8px;
                        color: #e2d1c1; 
                    }
                }
                > .right {
                    float: right;
                    > a{
                        color: #B7A793;
                    }
                }
            }
            > .content > .text {
                color: #8c615a;
            }
        }
        .footer {
            position:relative;
            display: block;
            z-index: 1;
            margin-top: -12px;
            margin-left: -74px;
            &:after {
                content: "";
                display: block;
                clear: both;
            }
            > ul {
                display: block;
                float:right;
                list-style:none;
                margin:0;
                padding:0;
                > li{
                    display: inline-block;
                    margin: 0;
                    padding: 0 16px;
                    min-width: 2.5em;
                    > button {
                        cursor: pointer;
                        background: transparent;
                        padding: 8px;
                        margin: 0;
                        color: #d8c5ad;
                        font-size: 1em;
                        opacity: 0.5;
                        transition: all 0.1s ease-out;
                        
                        &.active,
                        &:hover {
                            color: #11491d;
                            opacity: 1;
                        }
                    }
                }
            }
        }
        misskey-post:hover .footer button{
            opacity: 1;
        }
        a.name{
            font-weight: bold;
        }
        .reply-post {
            padding: 16px 32px 0;
        }
        .files {
            > ol {
                list-style: none;
                margin:0;
                margin-top: 8px;
                padding:0;
                > li{
                    margin: 0;
                    > .content{
                        max-width: 100%;
                        max-height: 256px;
                    }
                }
            }
        }
