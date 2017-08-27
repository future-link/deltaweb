const riot = require("riot")

import "./style.css"
import "./tags/app.tag"

window.addEventListener("load", function() {
    riot.mount("*")
    var fontawesome_style = document.createElement("link")
    fontawesome_style.rel = "stylesheet"
    fontawesome_style.href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
    document.head.appendChild(fontawesome_style)
    var style = document.createElement("style")
    style.innerHTML = localStorage.getItem("web.customcss")
    document.head.appendChild(style)
})
