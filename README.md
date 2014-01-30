iSpeech Plugin for iOS
=============================

iSpeech Plugin for Phonegap/Cordova based on https://github.com/jcesarmobile/my-phonegap-plugins/tree/master/iOS/iSpeechPlugin


Plugin Usage Guide
==========================

1)Initialize the plugin by calling this method - 

	cordova.iSpeechPlugin.init("YouriSpeechSDKkey")

2)Speech Recognition -

	cordova.iSpeechPlugin.recognize(function(result){alert("Output = "+result);},
									function(){alert("sorry didn't catch that");});
									
3) Text to Speech (Not Tested Yet)- 

	cordova.iSpeechPlugin.speak(success,error,"Your text goes here");
	