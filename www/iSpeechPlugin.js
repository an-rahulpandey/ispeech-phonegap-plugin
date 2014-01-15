var cordova = require('cordova'),
    exec = require('cordova/exec');

var iSpeechPlugin = function() {
        this.options = {};
};

iSpeechPlugin.prototype = {
    /*
        Add your plugin methods here
    */
init:function(speechkey) {
    cordova.exec(null,null,"CDViSpeechPlugin","init",[speechkey]);
},
    
speak: function(callback, errCallbac, message) {
    cordova.exec(callback, errCallbac, "CDViSpeechPlugin", "speak",[message]);
},
    
recognize: function (callback, errCallbac) {
    cordova.exec(callback, errCallbac, "CDViSpeechPlugin", "recognize",[]);
}
};

var iSpeechPlugin = new iSpeechPlugin();

module.exports = iSpeechPlugin;
