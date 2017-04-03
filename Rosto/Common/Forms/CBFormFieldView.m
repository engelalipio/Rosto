//
//  CBFormFieldView.m
//  ChaseBook
//
//  Created by Engel Alipio on 5/7/13.
//  Copyright (c) 2013 Engel Alipio. All rights reserved.
//

#import "CBFormFieldView.h"
#import "CBFormFieldView_Protected.h"
#import "CBForm.h"

#define kWidthProportionInLine 100

@interface CBFormFieldView ()

@property (nonatomic, strong) NSString			*valueBeforeEditing;
@property (nonatomic, unsafe_unretained) BOOL	disabled;

@end

@implementation CBFormFieldView

- (void)awakeFromNib
{
	// Make the field to extend to the entire with of the line by default
	self.widthProportionInLine	= kWidthProportionInLine;
	self.displayValue			= @"";
	self.validationType			= CBFieldValidationNone;
	self.popoverArrowDirection	= UIPopoverArrowDirectionAny;
	self.normalStyleColor		= [UIColor blackColor];
	self.placeholderStyleColor	= [UIColor lightGrayColor];
}

- (BOOL)hasChanges
{
	return self.valueBeforeEditing != nil && [self.valueBeforeEditing isEqualToString:self.displayValue] == NO;
}

- (void)didMoveToSuperview
{
	self.backgroundColor = [UIColor clearColor];// Let the field show the background color of the line
    
	// Separator
	self.separatorView					= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, self.height)];
	self.separatorView.hidden			= YES;
	self.separatorView.backgroundColor	= [UIColor lightGrayColor];
	[self addSubview:self.separatorView];
    
	// Make the field show the placeholder text if needed
	if (self.hasValue == NO) {
		[self setDisplayValue:@""];
	}
    
	[self reset];
}

#pragma mark - Editing

- (void)reset
{}

- (NSString *)displayValue
{
	if (self.hasValue) {
		return self.valueLabel.text;
	} else {
		return @"";	// Avoid returning placeholder text
	}
}

- (void)setDisplayValue:(NSString *)displayValue
{
	if ((displayValue.length == 0) || (displayValue == nil)) {
		self.valueLabel.text = self.description;
		[self setPlaceholderStyle];
		_hasValue = NO;
	} else {
		self.valueLabel.text = displayValue;
        
		if (self.disabled == NO) {
			[self setNormalStyle];
		} else {
			[self setPlaceholderStyle];
		}
        
		_hasValue = YES;
	}
    
	[self triggerValueChanged];
}

- (void)triggerValueChanged
{
	if (self.superview == nil) {
		return;
	}
    
	if ((self.line.form.formDelegate != nil) && [self.line.form.formDelegate respondsToSelector:@selector(form:fieldDidChangeValue:)]) {
		[self.line.form.formDelegate form:self.line.form fieldDidChangeValue:self];
	}
}

- (void)beginEditing
{
	if (self.valueBeforeEditing == nil) {
		self.valueBeforeEditing = self.displayValue;
	}
    
	((UIGestureRecognizer *)[self.gestureRecognizers lastObject]).enabled = NO;
}

- (void)endEditing
{
	((UIGestureRecognizer *)[self.gestureRecognizers lastObject]).enabled = YES;
}

- (void)enableField
{
	self.userInteractionEnabled = YES;
	[self setNormalStyle];
	self.disabled = YES;
}

- (void)disableField
{
	self.userInteractionEnabled = NO;
	[self setPlaceholderStyle];
	self.disabled = YES;
}

- (void)setValueLabel:(UILabel *)valueLabel
{
	_valueLabel = valueLabel;
	self.frame	= _valueLabel.frame;
}

#pragma mark - Styles

- (void)setPlaceholderStyle
{
	self.valueLabel.textColor = self.placeholderStyleColor;
}

- (void)setNormalStyle
{
	self.valueLabel.textColor = self.normalStyleColor;
}

#pragma mark - UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{}

@end
