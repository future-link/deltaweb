misskey-timeline
    virtual(each="{post in opts.posts}")
        misskey-post(post="{post}")
    script.
        import "./post.tag"
