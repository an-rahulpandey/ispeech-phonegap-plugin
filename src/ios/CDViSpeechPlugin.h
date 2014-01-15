/********* CDViSpeechPlugin.h Cordova Plugin Header *******/

#import <Cordova/CDV.h>
#import "iSpeechSDK.h"

@interface CDViSpeechPlugin : CDVPlugin <ISSpeechSynthesisDelegate,ISSpeechRecognitionDelegate>

-(void)speak:(CDVInvokedUrlCommand*)command;
-(void)recognize:(CDVInvokedUrlCommand*)command;
-(void)init:(CDVInvokedUrlCommand*)command;
@end
