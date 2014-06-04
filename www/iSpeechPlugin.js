cordova.define("me.rahul.plugins.ispeechplugin.iSpeechPlugin", function(require, exports, module) { var cordova = require('cordova'),
    exec = require('cordova/exec');

var iSpeechPlugin = function() {
        this.options = {};
};

iSpeechPlugin.prototype = {

            init:function(speechkey) {
                console.log("speechkey = "+speechkey);
                    cordova.exec(null,null,"iSpeechPlugin","init",[speechkey]);
            },
    
            speak: function(callback, errCallbac, options) {
                
                    var defaults = {
                                        msg : "Your Text Goes here",
                                        voice : "ISVoiceUSEnglishFemale",
                                        bitrate: 48,
                                        speed  : 0
                    };
                
                
                    if(options){
                            for (var key in defaults){
                                if(options[key] != undefined) {
                                    defaults[key] = options[key];
                                    console.log("options = "+defaults[key]);
                                }
                            }
                    }
                
                    cordova.exec(callback, errCallbac, "iSpeechPlugin", "speak",[defaults]);
            },
    
            recognize: function (callback, errCallbac, options) {
                
                    var defaults = {
                                        silenceDetection : NO,
                                        locale : null,
                                        timeout: 100
                    };
    
                    if(options){
                            for (var key in defaults){
                                if(options[key] != undefined) {
                                    defaults[key] = options[key];
                                    console.log("options = "+defaults[key]);
                                }
                            }
                    }
                
                    cordova.exec(callback, errCallbac, "iSpeechPlugin", "recognize",[defaults]);
            }

};

var iSpeechPlugin = new iSpeechPlugin();

module.exports = iSpeechPlugin;

});
