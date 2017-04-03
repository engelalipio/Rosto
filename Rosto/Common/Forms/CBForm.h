//
//  CBForm.h
//
//  Created by Engel Alipio on 5/7/13.
//  Copyright (c) 2013 Engel Alipio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBFormLineCell.h"
#import "CBFormFieldView.h"
#import "CBFormListField.h"
#import "CBFormTextField.h"
#import "CBFormDescriptionField.h"
#import "CBFormDateField.h"
#import "CBFormTextViewField.h"

@class CBForm;

@protocol CBFormDelegate <NSObject>

@optional
- (CGFloat)form:(CBForm *)form heightForSection:(NSInteger)section;
- (void)form:(CBForm *)form fieldDidChangeValue:(CBFormFieldView *)field;
- (CGFloat)form:(CBForm *)form heightForFooterInSection:(NSInteger)section;
- (UIView *)form:(CBForm *)form viewForHeaderInSection:(NSInteger)section;

@end

@interface CBForm : UITableView

@property (nonatomic, strong) NSMutableArray				*allLines;
@property (nonatomic, strong) UIPopoverController			*popover;
@property (nonatomic, strong) NSMutableArray				*validationErrorMessages;
@property (nonatomic, weak) IBOutlet id <CBFormDelegate>	formDelegate;
@property (nonatomic, strong) UIView						*footer;
@property (nonatomic, assign) BOOL							avoidContentSizeChange;
@property (nonatomic, readonly) CBFormFieldView				*editingField;

- (void)adjustSizeToFit;
- (void)hidePopover;
- (void)insertSectionWithTitle:(NSString *)title lines:(NSArray *)lines;
- (void)addSectionWithTitle:(NSString *)title lines:(NSArray *)lines;
- (void)insertSectionWithLines:(NSArray *)lines;
- (void)addSectionWithLines:(NSArray *)lines;
- (void)setFocusOnField:(CBFormFieldView *)field;
- (void)leaveFocusOnField:(CBFormFieldView *)field;
- (void)setFocusOnPreviousField;
- (void)setFocusOnNextField;
- (BOOL)hasChanges;
- (CBFormFieldView *)fieldWithTag:(NSInteger)tag;
- (CBFormFieldView *)fieldWithTag:(NSInteger)tag atLineIndex:(NSUInteger)lineIndex;
- (CBFormListField *)listFieldWithTag:(NSInteger)tag;
- (CBFormTextField *)textFieldWithTag:(NSInteger)tag;
//- (CBFormLookupField *)lookupFieldWithTag:(NSInteger)tag;
//- (CBFormSwitchField *)switchFieldWithTag:(NSInteger)tag;
- (CBFormDateField *)dateFieldWithTag:(NSInteger)tag;
- (CBFormTextViewField *)textViewFieldWithTag:(NSInteger)tag;
- (void)reloadFields;
- (void)getReadyToSubmitWithBlock:(void (^)())block;
- (BOOL)validate;
- (void)hideSectionAtIndex:(NSInteger)sectionIndex;
- (void)showSectionAtIndex:(NSInteger)sectionIndex;
- (void)reset;
- (void) setValidationErrorMarkWithTag:(NSInteger)tag;
- (void) clearValidationErrorMarkWithTag:(NSInteger)tag;
- (void) clearAllValidationErrorMarks;
- (NSString*) getValidationErrorMessage;

@end
