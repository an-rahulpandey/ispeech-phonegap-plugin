//
//  ISViewController.m
//  iSpeechSample
//
//  Created by Grant Butler on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ISViewController.h"
#import "ISTextInputAlertView.h"

@implementation ISViewController

@synthesize label;

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
	self.label = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

- (IBAction)speak:(id)sender {
	ISTextInputAlertView *textInputAlert = [[ISTextInputAlertView alloc] initWithTitle:@"Enter text to speak." okButtonTitle:@"Speak" callback:^(NSString *text) {
		ISSpeechSynthesis *synthesis = [[ISSpeechSynthesis alloc] initWithText:text];
		
		NSError *err;
		
		if(![synthesis speak:&err]) {
			NSLog(@"ERROR: %@", err);
		}
	}];

	[textInputAlert show];
}

- (IBAction)recognize:(id)sender {
	ISSpeechRecognition *recognition = [[ISSpeechRecognition alloc] init];
	
	NSError *err;
	
	[recognition setDelegate:self];
	
	if(![recognition listen:&err]) {
		NSLog(@"ERROR: %@", err);
	}
}

- (IBAction)commands:(id)sender {
	ISSpeechRecognition *recognition = [[ISSpeechRecognition alloc] init];
	
	NSError *err;
	
	[recognition setDelegate:self];
	
	[recognition addAlias:@"officers" forItems:[NSArray arrayWithObjects:@"Mike", @"Rocco", @"Grant", @"Alex", nil]];
	[recognition addCommand:@"call %officers%"];
	
	if(![recognition listen:&err]) {
		NSLog(@"ERROR: %@", err);
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
	return (interfaceOrientation == UIDeviceOrientationPortrait);
}

- (void)recognition:(ISSpeechRecognition *)speechRecognition didGetRecognitionResult:(ISSpeechRecognitionResult *)result {
	NSLog(@"Method: %@", NSStringFromSelector(_cmd));
	NSLog(@"Result: %@", result.text);
	
	[label setText:result.text];
}

- (void)recognition:(ISSpeechRecognition *)speechRecognition didFailWithError:(NSError *)error {
	NSLog(@"Method: %@", NSStringFromSelector(_cmd));
	NSLog(@"Error: %@", error);
}

- (void)recognitionCancelledByUser:(ISSpeechRecognition *)speechRecognition {
	NSLog(@"Method: %@", NSStringFromSelector(_cmd));
}

- (void)recognitionDidBeginRecording:(ISSpeechRecognition *)speechRecognition {
	NSLog(@"Method: %@", NSStringFromSelector(_cmd));
}

- (void)recognitionDidFinishRecording:(ISSpeechRecognition *)speechRecognition {
	NSLog(@"Method: %@", NSStringFromSelector(_cmd));
}

@end
