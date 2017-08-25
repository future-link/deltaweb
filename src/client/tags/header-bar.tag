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
        }
        a {
            padding: 1em;
            display:inline-block;
        }
