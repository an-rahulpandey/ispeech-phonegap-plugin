var cordova = require('cordova'),
    exec = require('cordova/exec');


  var TTSPlugin = function() {
      
      this.options = {};
  }
  
  TTSPlugin.prototype = {
  
  init:function(speechkey) {
      cordova.exec(null,null,"TTSAndSpeechRecognitionPlugin","init",[speechkey]);
  },

  speak: function(callback, errCallbac, message) {
      cordova.exec(callback, errCallbac, "TTSAndSpeechRecognitionPlugin", "speak",[message]);
  },
      
  recognize: function (callback, errCallbac) {
      cordova.exec(callback, errCallbac, "TTSAndSpeechRecognitionPlugin", "recognize",[]);
  }
  };
  

 var TTSPluginInstance = new TTSPlugin();
                        
 module.exports = TTSPluginInstance;
 