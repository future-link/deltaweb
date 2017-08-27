misskey-timeline
    virtual(each="{post in opts.posts}")
        misskey-post(post="{post}")
    button.read-more(if="{opts.readmore && post && post.length}",onclick="{opts.readmore}") Read More
    script.
        import "./post.tag"
    style.
        misskey-timeline{
            display:block;
            margin: 8px 0;
        }
        .read-more{
            user-select: none;
            display: block;
            box-sizing: border-box;
            width: 100%;
            margin: 0;
            padding: 0;
            line-height: 3.25em;
            font-size: 1em;
            color: #A98C76;
            cursor: pointer;
            background: #fffbfb;
            outline: none;
            border: none;
        }
        > *:first-child {
            border-top-left-radius: 8px;
            border-top-right-radius: 8px;
        }
        > *:last-child {
            border-bottom-left-radius: 8px;
            border-bottom-right-radius: 8px;
        }
