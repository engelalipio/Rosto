//
//  CBFormTextField.h
//  ChaseBook
//
//  Created by Engel Alipio on 5/7/13.
//  Copyright (c) 2013 Engel Alipio. All rights reserved.
//

#import "CBFormFieldView.h"

@class HPCFormatter;

@interface CBFormTextField : CBFormFieldView

@property (nonatomic,strong) HPCFormatter *formatter;
@property (nonatomic,strong) NSString *value;
@property (nonatomic,assign) NSInteger maximumCharsAllowed;
@property (nonatomic,strong) IBOutlet UITextField *textField;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *previousButton;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *nextButton;

- (IBAction)onPrevious:(id)sender;
- (IBAction)onNext:(id)sender;
- (IBAction)onDone:(id)sender;
-(void) changeDisplayValue:(NSString*)displayValue;

@end
