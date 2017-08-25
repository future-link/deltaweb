misskey-header-bar
    a(href="/")
        i.fa.fa-home
        |  Home
    script.
        document.body.style.marginTop = "3em"
    style.
        misskey-header-bar {
            background: white;
            position: fixed;
            top:0;
            left:0;
            width: 100vw;
            display: block;
            height:3em;
            line-height:3em;
        }
        a {
            padding: 0 1em;
            display:inline-block;
            height: 3em;
        }
