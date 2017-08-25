misskey-subpost
    a.avatar-anchor(href="/{opts.post.user.screenName}")
        img(src="{opts.post.user.avatarThumbnailUrl}")
    .header
        a.name(href="/{opts.post.user.screenName}") {opts.post.user.name}
        span.screen-name {opts.post.user.screenName}
    .main
        .text
            misskey-text-render(text="{opts.post.text}")
    script.
        import "./text-render.tag"
    style.
        misskey-subpost {
            display:block;
            padding: 16px 32px 0;
            padding-left:66px;
        }
        .name {
            color: #966961;
            font-weight: bold;
        }
        .screen-name {
            margin-left: 8px;
            color: #DCC6BB;
        }
        .text {
            color: #987469;
        }
        .avatar-anchor {
            display: block;
            float: left;
        }
        .avatar-anchor img{
            display: block;
            width: 32px;
            height: 32px;
            margin: 0 12px 4px 0;
            border-radius: 6px;
            margin-left: -48px;
        }
