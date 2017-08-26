module.exports = function(endpoint){
    var ws = new WebSocket(location.origin.replace("http", "ws")+"/_/api/ws/"+endpoint+"?csrf="+(document.querySelector("meta[name=csrf-token]").content))
    var interval = setInterval(function(){
        ws.send("ping")
    }, 10 * 1000)
    ws.addEventListener("close", function() {
        clearInterval(interval)
    })
    return ws
}
