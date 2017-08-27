function connectWS() {
    if(Notification.permission !== "granted") return
    var reconnect = true
    var ws = require("./streaming-call")("home")
    ws.addEventListener("message", function(mes){
        if (mes.data == "error:not-login") reconnect = false
        try{
            mes = JSON.parse(mes.data)
        } catch (e) {
            console.log(mes.data)
        }
        console.log(mes)
        if(mes.type != "notification") return
        if(localStorage.getItem("notification."+mes.value.type) == null) return
        if(!mes.value.content.user && mes.value.content.post && mes.value.content.post.user) {
            mes.value.content.user = mes.value.content.post.user
        }
        var notify = new Notification(mes.value.type+" from @"+mes.value.content.user.screenName,{
            body: mes.value.content.post ? mes.value.content.post.text : undefined
        })
        notify.onclick = function() {
            if (mes.value.content.post) {
                window.open("/"+(mes.value.type == "mention" ? mes.value.content.user.screenName : USER.screenName)+"/"+mes.value.content.post.id, "_blank")
            } else {
                window.open("/"+mes.value.content.user.screenName, "_blank")
            }
        }
    })
    ws.addEventListener("close", function(){
        console.log("websocket disconnected(notification)")
        if (!reconnect) return
        setTimeout(function(){
            connectWS()
        }, 250)
    })
}
module.exports = connectWS
