//
//  CBFormTextViewField.m
//  ChaseBook
//
//  Created by Ricky on 6/13/13.
//  Copyright (c) 2013 Engel Alipio. All rights reserved.
//

#import "CBFormTextViewField.h"
#import "CBForm.h"
#import "CBFormLineCell.h"

@interface CBFormTextViewField () <UITextViewDelegate>

@property (nonatomic, strong) NSString* description;

@end

@implementation CBFormTextViewField

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.valueLabel.hidden = YES;
    self.textView.delegate = self;
    [self setTextViewTapEnabled:NO];
}

- (void) setFieldDescription:(NSString*)description
{
    self.isEmpty = YES;
    self.description = description;
    self.textView.textColor = [UIColor lightGrayColor];
    [self setDisplayValue:description];
}

- (void)configureKeyboardToolbar
{
    self.textView.inputAccessoryView = self.keyboardToolbar;
    
    NSInteger indexOfField = [self.line.fields indexOfObject:self];
    NSInteger indexOfLine = [self.line.form.allLines indexOfObject:self.line];
    self.nextButton.enabled = (indexOfField < self.line.fields.count - 1 || indexOfLine < self.line.form.allLines.count - 1);
    self.previousButton.enabled = (indexOfField > 0 || indexOfLine > 0);
    [self.textView becomeFirstResponder];
}

- (void)beginEditing
{
    [super beginEditing];
    
    [self configureKeyboardToolbar];
    [self.textView becomeFirstResponder];
    self.textView.textColor = [UIColor blackColor];
    self.textView.hidden = NO;
    self.textView.delegate = self;
    if ([self.valueLabel.text isEqualToString:self.description])
    {
        self.textView.text = @"";
        [self setDisplayValue:@""];
    } else
    {
        self.textView.text = self.valueLabel.text;
    }
    [self setTextViewTapEnabled:YES];
}

- (void)endEditing
{
    [super endEditing];
    [self.textView resignFirstResponder];
    if ([self.textView.text isEqualToString:@""] || [self.textView.text isEqualToString:self.description])
    {
        self.textView.textColor = [UIColor lightGrayColor];
        [self setDisplayValue:self.description];
        self.isEmpty = YES;
    }
    else
    {
        [self setDisplayValue:self.textView.text];
        self.isEmpty = NO;
    }
    [self setTextViewTapEnabled:NO];
}

- (void)setDisplayValue:(NSString *)displayValue
{
    [super setDisplayValue:displayValue];
    self.textView.text = self.displayValue;
}

- (void)enableField
{
    [super enableField];
    self.textView.editable = YES;
}

- (void)disableField
{
    [super disableField];
    self.textView.editable = NO;
}

- (void)setTextViewTapEnabled:(BOOL)enabled
{
    for(UIGestureRecognizer *gestureRecognizer in self.textView.gestureRecognizers)
    {
        if([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]])
        {
            gestureRecognizer.enabled = enabled;
        }
    }
}

- (void)disableTextViewTap
{
    
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self beginEditing];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self endEditing];
}

#pragma mark - Toolbar actions

- (IBAction)onPrevious:(id)sender
{
    [self.line.form setFocusOnPreviousField];
}

- (IBAction)onNext:(id)sender
{
    [self.line.form setFocusOnNextField];
}

- (IBAction)onDone:(id)sender
{
    [self.line.form leaveFocusOnField:self];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSUInteger newLength = (textView.text.length - range.length) + text.length;
    if(newLength <= _maxNumberOfCharacters || !_maxNumberOfCharacters)
    {
        return YES;
    } else {
        NSUInteger emptySpace = _maxNumberOfCharacters - (textView.text.length - range.length);
        textView.text = [[[textView.text substringToIndex:range.location]
                          stringByAppendingString:[text substringToIndex:emptySpace]]
                         stringByAppendingString:[textView.text substringFromIndex:(range.location + range.length)]];
        return NO;
    }
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    textView.inputAccessoryView = self.keyboardToolbar;
    
    return YES;
}

@end
