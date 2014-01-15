//
//  ISTextInputAlertView.h
//  iSpeech
//
//  Created by Grant Butler on 6/30/11.
//  Copyright 2011 iSpeech, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

/**
 * The callback used to get text back from an `ISTextInputAlertView`.
 *
 * A callback is performed after the alert view has disappeared. This callback is not performed if the user taps the "Cancel" button.
 * 
 * @param text The text that the user inputted into the text view.
 */
typedef void(^ISTextInputAlertViewCallback)(NSString *text);

/** Adds an interface for displaying a text view in an alert view. */
@interface ISTextInputAlertView : UIAlertView <UITextViewDelegate>

/**
 * A reference to the underlying text view, allowing the developer to set properties on it.
 * 
 * Take note that you shouldn't call the -text method on the text view provided here to get the inputted text. Instead, set a callback when you initialize the alert view.
 */
@property (nonatomic, strong, readonly) UITextView *textView;

/**
 * The designated Initializer for `ISTextInputAlertView`.
 * 
 * Usually, you would want to set the `okButtonTitle` to a verb that represents the action performed when the user taps that button. For example, in iSpeech Obama, the button title is "Speak", because the text will be spoken after it is tapped.
 * 
 * @param title The title of the alert view.
 * @param okButtonTitle The title of the "OK" button, the button that dismisses the alert view and performs the callback.
 * @param callback The callback to be performed when the user taps the button with the title `okButtonTitle`.
 *
 * @return A new instance of the `ISTextInputAlertView` object.
 */
- (id)initWithTitle:(NSString *)title okButtonTitle:(NSString *)okButtonTitle callback:(ISTextInputAlertViewCallback)callback;

/**
 * Check to see if the alert view can become first responder.
 *
 * This calls -canBecomeFirstResponder the UITextView used by the alert, as well as checks to see if the alert is visible.
 *
 * @return Returns `-[UITextView canBecomeFirstResponder]` and `-[ISTextInputAlertView isVisible]`. If one of those doesn't return `YES`, then this is `NO`.
 */
- (BOOL)canBecomeFirstResponder;

/**
 * Tells the alert view to become first responsder.
 *
 * This basically just calls -becomeFirstResponder the UITextView used by the alert.
 *
 * @return Returns `-[UITextView becomeFirstResponder]`. In other words, `YES` if the text view became first responder, `NO` if it didn't.
 */
- (BOOL)becomeFirstResponder;

/**
 * Check to see if the alert view can resign first responder.
 *
 * This calls -canResignFirstResponder the UITextView used by the alert, as well as checks to see if the alert is visible.
 *
 * @return Returns `-[UITextView canResignFirstResponder]` and `-[ISTextInputAlertView isVisible]`. If one of those doesn't return `YES`, then this is `NO`.
 */
- (BOOL)canResignFirstResponder;

/**
 * Check to see if the alert view can become first responder.
 *
 * This basically just calls -resignFirstResponder the UITextView used by the alert.
 *
 * @return Returns `-[UITextView canBecomeFirstResponder]`. In other words, `YES` if the text view resigned first responder, `NO` if it didn't.
 */
- (BOOL)resignFirstResponder;

/**
 * Check to see if the alert view is first responder.
 *
 * This basically just calls -isFirstResponder the UITextView used by the alert.
 *
 * @return Returns `-[UITextView isFirstResponder]`. In other words, `YES` if the text view is first responder, `NO` if it isn't.
 */
- (BOOL)isFirstResponder;

@end
