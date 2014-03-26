//
//  iSpeechPlugin.h
//
//  Version 1.1
//
//  Created by Rahul Pandey on 26/03/2014.



#import <Cordova/CDV.h>
#import <Cordova/CDVPlugin.h>
#import "iSpeechSDK.h"

@interface iSpeechPlugin : CDVPlugin <ISSpeechSynthesisDelegate,ISSpeechRecognitionDelegate>

-(void)speak:(CDVInvokedUrlCommand*)command;
-(void)recognize:(CDVInvokedUrlCommand*)command;
-(void)init:(CDVInvokedUrlCommand*)command;
@end
