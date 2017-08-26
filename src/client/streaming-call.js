module.exports = function(endpoint){
    return new WebSocket(location.origin.replace("http", "ws")+"/_/api/ws/"+endpoint+"?csrf="+(document.querySelector("meta[name=csrf-token]").content))
}
