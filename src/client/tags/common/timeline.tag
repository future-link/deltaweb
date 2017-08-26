misskey-timeline
    virtual(each="{post in opts.posts}")
        misskey-post(post="{post}")
    script.
        import "./post.tag"
    style.
        misskey-timeline{
            display:block;
            margin: 8px 0;
        }
        misskey-post:first-child {
            border-top-left-radius: 8px;
            border-top-right-radius: 8px;
        }
        misskey-post:last-child {
            border-bottom-left-radius: 8px;
            border-bottom-right-radius: 8px;
        }
