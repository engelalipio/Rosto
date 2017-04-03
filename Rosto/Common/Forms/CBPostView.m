//
//  CBPostView.m
//  ChaseBook
//
//  Created by Engel Alipio on 5/3/13.
//  Copyright (c) 2013 Engel Alipio. All rights reserved.
//

#import "CBPostView.h"
#import <QuartzCore/QuartzCore.h>

#import "AppDelegate.h"
//#import "HPCContainerController.h"
//#import "HPContentViewController.h"
#import "UIAlertView+Blocks.h"
#import "CBColors.h"
#import "Constants.h"
#import "CBReusableMethods.h"

@interface CBPostView () <UITextViewDelegate>

@property (nonatomic,strong) IBOutlet UINavigationBar *topBar;
@property (nonatomic,strong) IBOutlet UINavigationItem *topBarItem;
@property (nonatomic,strong) IBOutlet UITextView *textView;
@property (nonatomic,strong) IBOutlet UIView *overlayView;
@property (nonatomic,strong) IBOutlet UILabel *placeholderTextLabel;
@property (nonatomic,assign) BOOL isDismissing;
@property (nonatomic,copy) void (^onDone) (NSString *newText, BOOL canceled);
@property (nonatomic, weak) /*HPContentViewController*/ NSObject *contentViewController;

@end

@implementation CBPostView

- (void)dealloc
{
    [self removeKeyboardListener];
}

- (void)awakeFromNib
{
    //Set default state
    self.readonly = NO;
    self.textView.text = @"";
    self.acceptButtonTitle = kSave;
    self.cancelButtonTitle = kCancel;
    self.text = @"";
    self.title = @"";
    self.isDismissing = NO;
    self.numberOfCharsAllowed = INT_MAX;
    self.showsAlertOnUnsavedWork = NO;
    
    //Add border and rounded corners to text view
    self.textView.layer.cornerRadius = 10;
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    //Listen keyboard notifications
    [self addKeyboardListener];
}

#pragma mark - Keyboard listener

- (void)addKeyboardListener
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)removeKeyboardListener
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

- (void)onKeyboardWillChangeFrame:(NSNotification *)notification
{
    if (self.isDismissing)
        return;
    
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardRect = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    [self adjustPositionWithKeyboardSize:[self convertRect:keyboardRect fromView:nil].size];
}

- (void)onKeyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardRect = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    [self showAnimatedWithKeyboardSize:[self convertRect:keyboardRect fromView:nil].size];
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0)
    {
        if (self.placeholderText != nil)
        {
            self.placeholderTextLabel.text = self.placeholderText;
        }
    }
    else
    {
        self.placeholderTextLabel.text = @"";
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{    
    if ([[textView text] length] - range.length + text.length > self.numberOfCharsAllowed)
        return NO;
    
    return YES;
}

#pragma mark - Showing the view

- (void)layoutSubviews
{
    [self.textView resignFirstResponder];
    [self.textView becomeFirstResponder];
}

- (void)adjustPositionWithKeyboardSize:(CGSize)keyboardSize
{
    //self.left = self.superview.width / 2 - self.width / 2;
    
   /* CGFloat offset = UIInterfaceOrientationIsPortrait([[[AppDelegate currentDelegate].navController visibleViewController] interfaceOrientation])
                        ? 50
                        : 15;*/
    //self.bottom = self.superview.bottom - keyboardSize.height - offset;
}

- (void)showInView:(UIView *)view onDone:(void(^)(NSString *newText, BOOL canceled))onDone
{
    //Setup navigation item
    self.topBarItem.leftBarButtonItem.title = self.cancelButtonTitle;
    self.topBarItem.rightBarButtonItem.title = self.acceptButtonTitle;
    self.topBarItem.rightBarButtonItem.style = UIBarButtonItemStyleDone;
    self.topBarItem.rightBarButtonItem.tintColor = [CBColors saveButtonBackgroundColor];
    self.topBarItem.title = self.title;
    
    //Set text view initial text
    self.textView.text = self.text;
    
    //Set the placeholder
    if (self.text == nil || self.text.length == 0)
    {
        if (self.placeholderText != nil)
        {
            self.placeholderTextLabel.text = self.placeholderText;
        }
    }        
    
    //Set completion block
    self.onDone = onDone;
    
    //Set view's behavior whether it's readonly
    if (self.readonly)
    {
        /*CGSize textSize = [self.text sizeWithFont:self.textView.font constrainedToSize:CGSizeMake(self.textView.width, INT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        
        self.textView.autoresizingMask = UIViewAutoresizingNone;
        self.textView.height = textSize.height + 30;
        self.height = self.textView.bottom + 16;
        self.left = view.width / 2 - self.width / 2;
        self.bottom = view.height - 66;
        self.topBarItem.rightBarButtonItem = nil;
        self.textView.userInteractionEnabled = NO;*/
    }
    else
    {
        [self.textView becomeFirstResponder];
    }
    
    //Finally, add it to the superview
    self.overlayView = [[UIView alloc] initWithFrame:view.bounds];
    self.overlayView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.75];
    [view addSubview:self.overlayView];
    
    [view addSubview:self];
    
    /*UIViewController *container = [[amsAppDelegate currentDelegate].navController visibleViewController];
    self.contentViewController = (HPContentViewController *)[((HPCContainerController *)container).contentViewController.navigationController topViewController];
    [self.contentViewController disableNavigation];*/
}

- (void)showAnimatedWithKeyboardSize:(CGSize)keyboardSize
{
    [self adjustPositionWithKeyboardSize:keyboardSize];
    self.alpha = 0;
    self.overlayView.alpha = 0;
    
    [UIView animateWithDuration:0.2 animations:^{
       
        self.alpha = 1;
        self.overlayView.alpha = 1;
        
    }];
}

- (void)hideAnimated
{
    self.isDismissing = YES;
    
    if (self.readonly == NO)
    {
        [self.textView resignFirstResponder];
    }
    
    [UIView animateWithDuration:0.2 animations:^{
       
        self.alpha = 0;
        self.overlayView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        [self.overlayView removeFromSuperview];
        
    }];
}

- (IBAction)onAccept:(id)sender
{
    if(self.avoidEmptyText && !self.textView.text.length)
    {
        [CBReusableMethods showGenericAlertWithMessage:self.emptyTextMessage];
    }
    else
    {
        [self hideAnimated];
        
        if (self.onDone)
        {
           // [self.contentViewController restoreNavigation];
            self.onDone(self.textView.text, NO);
        }
    }
}

- (IBAction)onCancel:(id)sender
{
    if (self.showsAlertOnUnsavedWork && ([self hasChanges] || self.isNewComment))
    {
       /* [UIAlertView alertWithTitle:@"" message:kUnsavedDataMsg cancelButtonTitle:kCancel acceptButtonTitle:@"OK" completionBlock:^(NSUInteger buttonIndex) {
            if (buttonIndex == 1)
            {
                [self cancel];
            }
        }];*/
    }
    else
    {
        [self cancel];
    }
}

- (void)cancel
{
    [self hideAnimated];
    
    if (self.onDone)
    {
        //[self.contentViewController restoreNavigation];
        self.onDone(self.textView.text, YES);
    }
}

- (BOOL)hasChanges
{
    return ([self.text isEqualToString:self.textView.text] == NO);
}

@end
