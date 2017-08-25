misskey-post(id="{post().id}")
    .repost-info(if="{opts.post.type == 'repost'}")
        img(src="{'https://delta.contents.stream/59977e8673e4f37027f726aa/%E3%82%86%E3%81%8B%E3%82%8A%E3%81%95%E3%82%93.jpg.cropped.png?size=64&quality=80' || opts.post.user.avatarThumbnailUrl}")
        i.fa.fa-retweet
        | Reposted by 
        a.name(href="/{opts.post.user.screenName}") {opts.post.user.name}
    .main
        .avatar-area
            a(href="/{post().user.screenName}")
                img(src="{'https://delta.contents.stream/59977e8673e4f37027f726aa/%E3%82%86%E3%81%8B%E3%82%8A%E3%81%95%E3%82%93.jpg.cropped.png?size=64&quality=80' || post().user.avatarThumbnailUrl}")
        .header
            .author
                a.name(href="/{post().user.screenName}") {post().user.name}
                span.screen-name {post().user.screenName}
        .text {post().text}
    .footer
        ul
            li: button(type="button", onclick="{reply}"): i.fa.fa-reply
            li: button(type="button", onclick="{repost}", class="{active: this.post().isReposted}"): i.fa.fa-retweet
            li: button(type="button", onclick="{like}", class="{active: this.post().isLiked}"): i.fa.fa-thumbs-o-up
    script.
        this.post = function() {
            return this.opts.post.post || this.opts.post
        }
        this.repost = function() {
            apiCall("posts/repost", {
                "post-id": this.post().id
            }).then(function(){
                location.reload()
            })
        }
        this.like = function() {
            apiCall("posts/like", {
                "post-id": this.post().id
            }).then(function(){
                location.reload()
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
        .main {
            padding: 16px 32px;
        }
        .header {
            border-bottom: 4px;
        }
        .avatar-area {
            float:left;
            margin-right:16px;
        }
        .avatar-area img{
            width:58px;
            height:58px;
            border-radius: 8px;
            vertical-align: bottom;
        }
        .author a{
            color: #736060;
            text-decoration: none;
        }
        .author .screen-name {
            margin-left: 8px;
            color: #e2d1c1; 
        }
        .text {
            color: #8c615a;
        }
        .footer {
            position:relative;
            display: block;
            z-index: 1;
            margin-left: 112px;
            margin-top: -12px;
        }
        .footer:after {
            content: "";
            display: block;
            clear: both;
        }
        .footer ul{
            display: block;
            float:right;
            list-style:none;
            margin:0;
            padding:0;
        }
        .footer li{
            display: inline-block;
            margin: 0;
            padding: 0 16px;
            min-width: 2.5em;
            opacity: 0.5;
        }
        misskey-post:hover .footer li{
            opacity: 1;
        }
        .footer button {
            background: transparent;
            padding: 8px;
            margin: 0;
            color: #d8c5ad;
            font-size:1em;
        }
        .footer button.active {
            color: #11491d;
        }
        .repost-info{
            margin: 0;
            padding: 8px 32px;
            line-height: 28px;
            color: #57bb00;
        }
        .repost-info img{
            float:left;
            height:28px;
            width:28px;
            margin-right: 8px;
        }
        .repost-info i{
            margin-right: 4px;
        }
        a.name{
            font-weight: bold;
        }
