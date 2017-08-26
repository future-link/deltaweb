misskey-users
    .post(each="{user in opts.users}")
        a(href="/{user.screenName}")
            img(src="{user.avatarThumbnailUrl}")
            .name {user.name}
            div @{user.screenName}
    style.
        .post{
            background: white;
            margin: 0;
            margin-bottom: 1px;
            padding: 0.5em 1em;
            img {
                width: 3em;
                height: 3em;
                float:left;
                margin-right: 1em;
            }
            div {
                line-height: 1.5em;
            }
        }
