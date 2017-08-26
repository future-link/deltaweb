misskey-relative-time(title="{human_readable_time()}")
    span {time} ago
    script.
        var moment = require("moment")
        var self = this
        this.human_readable_time = function() {
            console.log(moment(this.opts.date).format("YYYY/MM/DD HH:mm:ss"))
            return moment(this.opts.date).format("YYYY/MM/DD HH:mm:ss")
        }
        function calc(){
            var d = self.opts.date
            var mt = new Date()-d
            var old_time = self.time
            var time = Math.floor(mt/1000)
            console.log(time)
            var unit = "s" // second
            if(time > 60) {
                time = Math.floor(time/60)
                unit = "m"
                if(time > 60) {
                    time = Math.floor(time/60)
                    unit = "h"
                    if(time > 24) { // >24h (1d)
                        time = Math.floor(time/24)
                        unit = "d"
                    }
                }
            }
            var out_time = time+unit
            if (out_time != old_time) {
                self.time = out_time
                self.update()
            }
        }
        var timer = setInterval(function(){
            calc()
        }, 1000)
        this.on("mount", function() {
            calc()
        })
        this.on("unmount", function() {
            clearInterval(timer)
        })
