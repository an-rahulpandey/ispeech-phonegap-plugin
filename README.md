##iSpeech Plugin for iOS


iSpeech Plugin for Phonegap/Cordova based on 

https://github.com/jcesarmobile/my-phonegap-plugins/tree/master/iOS/iSpeechPlugin


## Plugin Usage Guide


1)Initialize the plugin by calling this method - 

	iSpeechPlugin.init("YouriSpeechSDKkey");

2)Speech Recognition (Not Tested Yet)-
```javascript
    var options = {
                    silenceDetection : NO,
                    locale : null, //see ISSpeechRecognitionLocales.h for options
                    timeout: 100
                  };

	iSpeechPlugin.recognize(function(result){alert("Output = "+result);},
									function(){alert("sorry didn't catch that");},
                                    options);
```
									
3) Text to Speech (Not Tested Yet)- 
```javascript
    var options = {
                    msg : "Your Text Goes here",
                    voice : "ISVoiceUSEnglishFemale", //see ISSpeechSynthesisVoices.h for options
                    bitrate: 48,
                    speed  : 0
    };

	iSpeechPlugin.speak(success,error,options);
```	