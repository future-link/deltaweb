const cluster = require("cluster")
const cpuLength = process.env.CLUSTER_LIMIT || require("os").cpus.length

if (cluster.isMaster) {
    for (var i = 0; i < cpuLength ; i++) {
        cluster.fork()
    }
} else {
    require("./index")
}
