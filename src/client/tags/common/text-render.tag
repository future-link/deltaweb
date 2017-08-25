misskey-text-render
    script.
        function escapeHtml(text) {
            return text.replace(/>/g,'&gt;').replace(/</g,'&lt;');
        }
        function analyzeUrl(text) {
            'use strict';
            return text.replace(/https?:\/\/[0-9a-z_\.\-~%!$&'()*+,;=@:]+[\/0-9a-z_\.\-~%!$&'()*+,;=@:\?#]*/gi, function(url) {
                return '<a href="' + url + '" title="' + url + '" target="_blank" class="url" rel="nofollow noopener">' + url + '</a>';
            });
        }
        function analyzeMentions(text) {
            'use strict';
            return text.replace(/(^|\s)@([a-zA-Z0-9\-]+)/g, function(arg, space, screenName) {
                return space + '<a href="/' + screenName + '" class="mention">@' + screenName + '</a>';
            });
        }
        
        function analyzeBold(text) {
            'use strict';
            return text.replace(/\*\*(.+?)\*\*/g, function(arg, boldee) {
                return '<strong>' + boldee + '</strong>';
            });
        }
        
        function analyzeStrike(text) {
            'use strict';
            return text.replace(/~~(.+?)~~/g, function(arg, strikeee){
                return '<del>' + strikeee + '</del>';
            });
        }
        function analyzeHashtags(text) {
            'use strict';
            return text.replace(/(^|\s)#(\S+)/g, function(arg, space, tag) {
                return space + '<a href="/_/search?q=' + encodeURIComponent("#"+tag) + '" class="hashtag">#' + tag + '</a>';
            });
        }
        this.on("update", function() {
            this.root.innerHTML = analyzeHashtags(analyzeMentions(analyzeUrl(analyzeStrike(analyzeBold(escapeHtml(this.opts.text || "")))))).replace(/\r?\n/g, '<br>')
        })
        this.on("mount", function() {
            this.update()
        })
    style.
        .url:after{
            content: "\f14c";
            display: inline-block;
            padding-left: 2px;
            font-family: FontAwesome;
            font-size: 0.9em;
            font-weight: normal;
            font-style: normal;
        }
