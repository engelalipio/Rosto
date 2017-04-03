//
//  CBFormTextViewField.h
//  ChaseBook
//
//  Created by Ricky on 6/13/13.
//  Copyright (c) 2013 Engel Alipio. All rights reserved.
//

#import "CBFormFieldView.h"

@interface CBFormTextViewField : CBFormFieldView <UITextFieldDelegate>

@property (nonatomic,strong) IBOutlet UITextView *textView;
@property (nonatomic,strong) IBOutlet UIView *keyboardToolbar;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *previousButton;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *nextButton;
@property (nonatomic,assign) NSInteger maxNumberOfCharacters;
@property (nonatomic) BOOL isEmpty;

- (IBAction)onPrevious:(id)sender;
- (IBAction)onNext:(id)sender;
- (IBAction)onDone:(id)sender;
- (void) setFieldDescription:(NSString*)description;

@end
