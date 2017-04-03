//
//  CBFormFieldView.h
//  ChaseBook
//
//  Created by Engel Alipio on 5/7/13.
//  Copyright (c) 2013 Engel Alipio. All rights reserved.
//

#import <UIKit/UIKit.h>

enum CBFieldValidationType {
	CBFieldValidationNone			= 0,
	CBFieldValidationMandatory		= 1,
	CBFieldValidationAlphanumeric	= 2,
	CBFieldValidationEmail			= 4,
	CBFieldValidationNumeric		= 8,
	CBFieldValidationPhone			= 16,
    CBFieldValidationCreditCard	    = 32
};

typedef int CBFieldValidation;

@class CBFormLineCell;

@interface CBFormFieldView : UIView <UIPopoverControllerDelegate>

@property (nonatomic, strong) IBOutlet UIView	*keyboardToolbar;
@property (nonatomic, strong) IBOutlet UILabel	*valueLabel;

@property (nonatomic, strong) UIView					*separatorView;
@property (nonatomic, strong) NSString					*description;
@property (nonatomic, strong) UIViewController			*viewControllerForPopover;
@property (nonatomic, assign) NSInteger					widthProportionInLine;
@property (nonatomic, strong) CBFormLineCell			*line;
@property (nonatomic, strong) NSString					*displayValue;
@property (nonatomic, readonly) BOOL					hasValue;
@property (nonatomic, readonly) BOOL					hasChanges;
@property (nonatomic, assign) CBFieldValidation			validationType;
@property (nonatomic, assign) UIPopoverArrowDirection	popoverArrowDirection;
@property (nonatomic, strong) UIColor					*normalStyleColor;
@property (nonatomic, strong) UIColor					*placeholderStyleColor;
@property (nonatomic, assign) UILabel                   *validationMark;

- (void)reset;
- (void)beginEditing;
- (void)endEditing;
- (void)triggerValueChanged;
- (void)disableField;
- (void)enableField;

@end
