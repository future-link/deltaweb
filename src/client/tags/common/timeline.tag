misskey-timeline
    virtual(each="{post in opts.posts}")
        misskey-post(post="{post}")
    button.read-more(if="{opts.readmore && opts.posts && opts.posts.length}",onclick="{readmore}",disabled="{isDisabledReadmore}") Read More
    script.
        import "./post.tag"
        var self = this
        this.isDisabledReadmore = false
        this.readmore = function () {
            // Read Moreボタンをロックする
            self.isDisabledReadmore = true
            var result = self.opts.readmore()
            // Promiseっぽくない
            if (!('then' in result) && !('catch' in result)) {
                self.isDisabledReadmore = false
                self.update()
                return
            }
            result.then(function(res){
                console.log(res)
                // finallyがないので一番下のthenをそれっぽく呼ぶ
                return
            }).catch(function(error){
                alert('Read Moreでエラー起きた')
                console.error(error)
                // 同上
                return
            }).then(function(){
                // なんかしらでPromiseが終わった
                self.isDisabledReadmore = false
                self.update()
            })
        }
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
