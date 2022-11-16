const glob = require("glob");

var getDirectories = function (src, callback) {
    glob(src + '/**/', callback);
};

var getDirFiles = function (src, callback) {
    glob(src + '/*', callback);
};

var getJsonFiles = function (src, callback) {
    glob(src + '/.json', callback);
};


module.exports = { getDirectories, getDirFiles, getJsonFiles }