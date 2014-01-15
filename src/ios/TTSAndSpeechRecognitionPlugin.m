//
//  TTSAndSpeechRecognitionPlugin.m
//  TTSPlugin
//
//  Created by Admin on 30/04/13.
//
//

#import "TTSAndSpeechRecognitionPlugin.h"
#import "ISSpeechSynthesis.h"
#import "ISSpeechRecognition.h"


@implementation TTSAndSpeechRecognitionPlugin


-(void)speak:(CDVInvokedUrlCommand*)command {
    
    CDVPluginResult* pluginResult = nil;
    NSString* myarg = [command.arguments objectAtIndex:0];
    
    if (myarg != nil) {
        
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Arg was null"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    
    
    ISSpeechSynthesis *synthesis = [[ISSpeechSynthesis alloc] initWithText:myarg];
    /* Configuration changes here: */
    //[synthesis setVoice:ISVoiceEURSpanishMale];
    //[synthesis setBitrate:48];
    //[synthesis setSpeed:0];
    
    [synthesis setDelegate:self];
    
    
    NSError *error;
    
    if(![synthesis speak:&error]) {
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"error speak"] callbackId:command.callbackId];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

- (void)recognize:(CDVInvokedUrlCommand*)command {
   NSLog(@"Pugin called");
    ISSpeechRecognition *recognition = [[ISSpeechRecognition alloc] init];
    [recognition setDelegate:self];
    [recognition setSilenceDetectionEnabled:NO];
    //[recognition setLocale:ISLocaleESSpanish];
    [recognition setFreeformType:ISFreeFormTypeDictation];
    
    [recognition listenAndRecognizeWithTimeout:100 handler:^(NSError *error, ISSpeechRecognitionResult *result, BOOL cancelledByUser) {
        
        if (cancelledByUser) {
            [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"cancel"] callbackId:command.callbackId];
        } else {
            if(!error){
                if (result.confidence < 0.3) {
                    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"no confidence"] callbackId:command.callbackId];
                } else {
                    NSLog(@"Output = %@",result.text);
                    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result.text] callbackId:command.callbackId];
                }
                
            } else {
                [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"error recognicing"] callbackId:command.callbackId];
            }
        }
        
        
        
    }];
    
}

-(void)init:(CDVInvokedUrlCommand *)command{
    
    NSLog(@"Init Called");
    CDVPluginResult *plresult = nil;
    NSString* appKey = [command.arguments objectAtIndex:0];
    [[iSpeechSDK sharedSDK] setAPIKey:appKey];
	NSLog(@"Speech API = %@",appKey);
    iSpeechSDK *sdk = [iSpeechSDK sharedSDK];
    sdk.APIKey = appKey;
    plresult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:plresult callbackId:@"Ok"];
}

@end