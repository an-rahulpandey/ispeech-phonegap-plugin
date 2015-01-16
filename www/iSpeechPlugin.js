var exec = require('cordova/exec');

exports.init = function(speechkey) {
    //console.log("speechkey = "+speechkey);
    exec(null,null,"iSpeechPlugin","init",[speechkey]);
};

exports.speak  =function(callback, errCallbac, options) {
    
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
               // console.log("options = "+defaults[key]);
            }
        }
    }
    
    exec(callback, errCallbac, "iSpeechPlugin", "speak",[defaults]);
};

exports.recognize = function (callback, errCallbac, options) {
    
    var defaults = {
        silenceDetection : 'NO',
        locale : 'ISLocaleUSEnglish',
        timeout: 100
    };
    
    if(options){
        for (var key in defaults){
            if(options[key] != undefined) {
                defaults[key] = options[key];
               // console.log("options = "+defaults[key]);
            }
        }
    }
    
    exec(callback, errCallbac, "iSpeechPlugin", "recognize",[defaults]);
};