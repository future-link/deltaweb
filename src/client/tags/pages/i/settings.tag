misskey-i-settings
    .container
        .tabs
            a(href="/i/settings/profile",class="{active:isActive('profile')}")
                i.fa.fa-user
                span プロフィール
            a(href="/i/settings/notification",class="{active:isActive('notification')}",show="{Notification}")
                i.fa.fa-bell
                span 通知
            a(href="/i/settings/web",class="{active:isActive('web')}")
                i.fa.fa-desktop
                span Web
        .content
            misskey-i-settings-default(if="{isActive('default')}")
            misskey-i-settings-profile(if="{isActive('profile')}")
            misskey-i-settings-notification(if="{isActive('notification')}")
            misskey-i-settings-web(if="{isActive('web')}")
    script.
        this.isActive = function (name) {
            return name === this.opts.tab
        }
    style.
        .container{
            background: white;
        }
        .tabs {
            display: flex;
            a {
                flex: 1;
                padding: .5em 0;
                text-align: center;
                &.active {
                   border-bottom: solid 3px #11491d;
                }
                i.fa {
                    margin-right: 0.7em;
                }
            }
        }
        .content {
            padding: 1em;
        }
misskey-i-settings-default
    p 上からタブを選択して欲しい
misskey-i-settings-profile
    h1 プロフィール
    label 名前
    input(type="text", ref="name", value="{window.USER.name}", placeholder="Shibuya Rin")
    label コメント
    input(type="text", ref="comment", value="{window.USER.comment}", placeholder="ふーん、あんたが私のプロデューサー？まあ、悪くないかな。私は渋谷凛。今日からよろしくね。")
    label タグ
    input(type="text", ref="tags", value="{window.USER.tags.join(' ')}", placeholder="このように スペースで 区切る")
    label URL
    input(type="text", ref="url", value="{window.USER.url}", placeholder="https://www.example.com")
    label Location
    input(type="text", ref="location", value="{window.USER.location}", placeholder="Shibuya-ku, Tokyo")
    button(type="button",onclick="{submit}")
        i.fa.fa-check(if="{!now_updating}")
        i.fa.fa-refresh.fa-spin(if="{now_updating}")
        |  更新
    script.
        this.submit = function() {
            if(this.now_updating) return
            this.now_updating = true
            Promise.all([
                apiCall("account/name/update", {name: this.refs.name.value}),
                apiCall("account/comment/update", {comment: this.refs.comment.value}),
                apiCall("account/tags/update", {tags: this.refs.tags.value}),
                apiCall("account/url/update", {url: this.refs.url.value}),
                apiCall("account/location/update", {location: this.refs.location.value}),
            ]).then(function(){
                location.reload()
            })
        }
misskey-i-settings-notification
    span(if="{!Notification}") このブラウザはデスクトップ通知に対応していません :(
    button(if="{Notification.permission == 'default'}",onclick="{request_permission}")
        | 通知を許可する
    span(if="{Notification.permission == 'denied'}") 通知要求が拒否されました :(
    span(if="{Notification.permission == 'granted'}") 通知要求は許可されています :-)
    virtual(if="{Notification.permission == 'granted'}")
        h2 通知内容の設定
        p ブラウザに保存されます。アカウントを変更しても共通です
        p 設定後はリロードせえや
        misskey-i-settings-notification-checkbox(name="notification.follow") フォロー
        misskey-i-settings-notification-checkbox(name="notification.mention") メンション
        misskey-i-settings-notification-checkbox(name="notification.repost") RePost
        misskey-i-settings-notification-checkbox(name="notification.like") いいね
    script.
        this.request_permission = function() {
            Notification.requestPermission(function(){
                location.reload()
            })
        }
misskey-i-settings-notification-checkbox
    label
        input(type="checkbox", ref="checkbox", checked="{state}", onchange="{change}", value="true")
        span: <yield/>
    script.
        this.state = false
        this.change = function() {
            if(this.refs.checkbox.checked)
                localStorage.setItem(this.opts.name, "true")
            else
                localStorage.removeItem(this.opts.name)
        }
        this.on("mount", function() {
            this.state = !!localStorage.getItem(this.opts.name)
            this.update()
        })
    style.
        label{
            display: block;
            line-height: 2em;
            > span {
                line-height: 2em;
            }
        }
misskey-i-settings-web
    h2 カスタムCSS(上級者向け)
    textarea(ref="custom_css") {localStorage.getItem("web.customcss")}
    button(onclick="{save_custom_css}")
        i.fa.fa-save
        |  保存
    p Tips: CSSの設定を間違ってUIが崩壊した場合は、ブラウザのJavaScriptコンソールで<code>localStorage.removeItem("web.customcss")</code>を実行することでカスタムCSSをクリアできます
    style.
        textarea {
            resize: vertical;
            min-height: 5em;
        }
    script.
        this.save_custom_css = function() {
            localStorage.setItem("web.customcss", this.refs.custom_css.value)
            alert("保存しました!\n反映するにはリロードしてください。")
        }
