const riot = require("riot")

import "./style.css"
import "./tags/app.tag"

window.addEventListener("load", function() {
    riot.mount("*")
})
