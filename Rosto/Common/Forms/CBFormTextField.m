//
//  CBFormTextField.m
//  ChaseBook
//
//  Created by Engel Alipio on 5/7/13.
//  Copyright (c) 2013 Engel Alipio. All rights reserved.
//

#import "CBFormTextField.h"
#import "CBFormFieldView_Protected.h"
#import "CBForm.h"
#import "HPCFormatter.h"

@interface CBFormTextField () <UITextFieldDelegate>

@end

@implementation CBFormTextField

- (void)awakeFromNib
{
    [super awakeFromNib];
    //Disable text field in order to let the cell capture the tap gesture and beginEditing is called
    self.textField.hidden = YES;
    self.maximumCharsAllowed = INT_MAX;
}

- (void)configureKeyboardToolbar
{
    self.textField.inputAccessoryView = self.keyboardToolbar;
    
    NSInteger indexOfField = [self.line.fields indexOfObject:self];
    NSInteger indexOfLine = [self.line.form.allLines indexOfObject:self.line];
    self.nextButton.enabled = (indexOfField < self.line.fields.count - 1 || indexOfLine < self.line.form.allLines.count - 1);
    self.previousButton.enabled = (indexOfField > 0 || indexOfLine > 0);
}

- (void)setDisplayValue:(NSString *)displayValue
{
    if (self.formatter != nil)
    {
        self.value = [self.formatter plainValueString:displayValue];
    }
    else
    {
        self.value = displayValue;
    }
    
    [super setDisplayValue:displayValue];
}

- (void)beginEditing
{
    [super beginEditing];
    
    //Configure toolbar
    [self configureKeyboardToolbar];
    
    self.textField.hidden = NO;
    self.textField.delegate = self;
    self.textField.text = ([self.valueLabel.text isEqualToString:self.description]) ? @"" : self.valueLabel.text;
    self.valueLabel.text = @"";
    [self.textField becomeFirstResponder];
}

- (void)endEditing
{
    [super endEditing];
    
    [self.textField resignFirstResponder];
    
    //Disable text field in order to let the cell capture the tap gesture and beginEditing is called
    self.textField.hidden = YES;
        
    [self setDisplayValue:self.textField.text];
}

- (void)setTextField:(UITextField *)textField
{
    _textField = textField;
    self.frame = _textField.frame;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{

}

- (BOOL)textFieldShouldClear:(UITextField *)textFielddgfg
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self endEditing];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"About to type %i chars", [[textField text] length] - range.length + string.length);
    
    if ([[textField text] length] - range.length + string.length > self.maximumCharsAllowed)
        return NO;
        
    if (self.formatter)
    {
        self.textField.text = [self.formatter maskedStringForTextField:textField withRange:range replacementString:string];
        return NO;
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
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

-(void) changeDisplayValue:(NSString*)displayValue
{
    self.textField.text = displayValue;
}

@end
