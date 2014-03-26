//
//  iSpeechPlugin.m
//
//  Version 1.1
//
//  Created by Rahul Pandey on 26/03/2014.

#import "iSpeechPlugin.h"
#import <Cordova/CDV.h>
#import "ISSpeechSynthesis.h"
#import "ISSpeechRecognition.h"

@implementation iSpeechPlugin

-(void)speak:(CDVInvokedUrlCommand*)command {
    
    CDVPluginResult* pluginResult = nil;
    NSArray *args = [command arguments];
    NSError *error;
    if (args.count > 0) {
        NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
        NSString *msg = [options objectForKey:@"text"];
        NSString *voice = [options objectForKey:@"voice"];
        NSInteger bitrate = [[options objectForKey:@"bitrate"] integerValue];
        NSInteger speed = [[options objectForKey:@"speed"] integerValue];
        
        NSLog(@"[iSpeechPlugin] Arguments = %@",args);
        ISSpeechSynthesis *synthesis = [[ISSpeechSynthesis alloc] initWithText:msg];

        [synthesis setVoice:voice];
        [synthesis setBitrate:bitrate];
        [synthesis setSpeed:speed];

    
        [synthesis setDelegate:self];
    
       if(![synthesis speak:&error]) {
           NSLog(@"Error = %@",[error description]);
           [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[error description]] callbackId:command.callbackId];
       } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
           [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
       }
    } else {
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid Arguments"] callbackId:command.callbackId];
    }
}

- (void)recognize:(CDVInvokedUrlCommand*)command {

    ISSpeechRecognition *recognition = [[ISSpeechRecognition alloc] init];
    
    NSArray *args = [command arguments];

    if (args.count > 0) {
        NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
        
        BOOL silenceDetection = [[options objectForKey:@"silenceDetection"] boolValue];
        NSString *locale = [options objectForKey:@"locale"];
        NSTimeInterval timeout = [[options objectForKey:@"timeout"] intValue];
        
        [recognition setDelegate:self];
        [recognition setSilenceDetectionEnabled:silenceDetection];
        if (![locale isEqual:[NSNull null]]) {
            [recognition setLocale:locale];
        }
        
        [recognition setFreeformType:ISFreeFormTypeDictation];
    
        [recognition listenAndRecognizeWithTimeout:timeout handler:^(NSError *error, ISSpeechRecognitionResult *result, BOOL cancelledByUser) {
        
        if (cancelledByUser) {
            [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Cancelled by User"] callbackId:command.callbackId];
        } else {
            if(!error){
                if (result.confidence < 0.3) {
                    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"No Confidence"] callbackId:command.callbackId];
                } else {
                    NSLog(@"Output = %@",result.text);
                    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result.text] callbackId:command.callbackId];
                }
                
            } else {
                [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"error recognicing"] callbackId:command.callbackId];
            }
        }
        
        }];
    } else {
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid Arguments"] callbackId:command.callbackId];
    }
}

-(void)init:(CDVInvokedUrlCommand *)command
{
    NSLog(@"[iSpeechPlugin] Init Called");
    CDVPluginResult *plresult = nil;
    NSString* appKey = [command.arguments objectAtIndex:0];
    [[iSpeechSDK sharedSDK] setAPIKey:appKey];
    iSpeechSDK *sdk = [iSpeechSDK sharedSDK];
    sdk.APIKey = appKey;
    plresult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:plresult callbackId:@"Ok"];
}

@end
