//
//  CBForm.m
//  ChaseBook
//
//  Created by Engel Alipio on 5/7/13.
//  Copyright (c) 2013 Engel Alipio. All rights reserved.
//

#import "CBForm.h"
#import <QuartzCore/QuartzCore.h>
#import "CBFormUtils.h"
#import "CBReusableMethods.h"

@interface CBForm () <UITableViewDelegate, UITableViewDataSource, UIPopoverControllerDelegate>

@property (nonatomic, strong) UIToolbar			*toolbar;
@property (nonatomic, strong) NSMutableArray	*sections;
@property (nonatomic, strong) NSMutableArray	*sectionsHiddenIncluded;
@property (nonatomic, strong) NSMutableArray	*sectionsTitle;
@property (nonatomic, strong) NSMutableArray	*sectionsTitleHiddenIncluded;
@property (nonatomic, strong) NSMutableArray	*allLinesHiddenIncluded;

@end

@implementation CBForm

- (void)awakeFromNib
{
	[self reset];
    [self setBackgroundView:[[UIView alloc] init] ];
}

- (void)reloadFields
{
	self.allLines = [NSMutableArray array];
	self.allLinesHiddenIncluded = [NSMutableArray array];
    
	for (NSArray *lines in self.sections) {
		[self.allLines addObjectsFromArray:lines];
		[self.allLinesHiddenIncluded addObjectsFromArray:lines];
	}
    
	[self adjustSizeToFit];
	[self setLinesEventListeners];
	[self reloadData];
}

- (void)hideSectionAtIndex:(NSInteger)sectionIndex
{
	NSArray *section = [self.sectionsHiddenIncluded objectAtIndex:sectionIndex];
    
	[self.sections removeObjectAtIndex:sectionIndex];
	[self.sectionsTitle removeObjectAtIndex:sectionIndex];
    
	for (CBFormLineCell *line in section) {
		[self.allLines removeObject:line];
	}
    
	[self adjustSizeToFit];
    
	[self deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)showSectionAtIndex:(NSInteger)sectionIndex
{
	NSArray		*section	= [self.sectionsHiddenIncluded objectAtIndex:sectionIndex];
	NSString	*title		= [self.sectionsTitleHiddenIncluded objectAtIndex:sectionIndex];
    
	[self.sections insertObject:section atIndex:sectionIndex];
	[self.sectionsTitle insertObject:title atIndex:sectionIndex];
    
	NSInteger lineInsertIndex = 0;
    
	for (int i = 0; i < sectionIndex; i++) {
		lineInsertIndex += [[self linesForSection:i] count];
	}
    
	for (CBFormLineCell *line in section) {
		[self.allLines insertObject:line atIndex:lineInsertIndex];
		lineInsertIndex += 1;
	}
    
	[self adjustSizeToFit];
    
	[self insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
}

- (BOOL)hasChanges
{
	for (CBFormLineCell *line in self.allLines) {
		for (CBFormFieldView *field in line.fields) {
			if (field.hasChanges) {
				return YES;
			}
		}
	}
    
	return NO;
}

- (void)insertSectionWithTitle:(NSString *)title lines:(NSArray *)lines
{
	[self.sections insertObject:lines atIndex:0];
	[self.sectionsHiddenIncluded insertObject:lines atIndex:0];
    
	[self.sectionsTitle insertObject:title atIndex:0];
	[self.sectionsTitleHiddenIncluded insertObject:title atIndex:0];
}

- (void)addSectionWithTitle:(NSString *)title lines:(NSArray *)lines
{
	[self.sections addObject:lines];
	[self.sectionsHiddenIncluded addObject:lines];
    
	[self.sectionsTitle addObject:title];
	[self.sectionsTitleHiddenIncluded addObject:title];
}

- (void)insertSectionWithLines:(NSArray *)lines
{
	[self insertSectionWithTitle:@"" lines:lines];
}

- (void)addSectionWithLines:(NSArray *)lines
{
	[self addSectionWithTitle:@"" lines:lines];
}

- (void)setDefaultStyle
{
	self.separatorColor = [UIColor lightGrayColor];
	self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)adjustSizeToFit
{
	if (!_avoidContentSizeChange) {
		CGFloat height = 0;
        
		for (NSArray *lines in self.sections) {
			for (CBFormLineCell *line in lines) {
				height += line.lineHeight;
			}
            
			height += [self tableView:self heightForHeaderInSection:[self.sections indexOfObject:lines]];
		}
        
		self.height			= height + 100;
		self.contentSize	= CGSizeMake(self.width, height);
	}
}

- (void)reset
{
	self.sections = [NSMutableArray array];
	self.sectionsHiddenIncluded			= [NSMutableArray array];
	self.sectionsTitle					= [NSMutableArray array];
	self.sectionsTitleHiddenIncluded	= [NSMutableArray array];
	_editingField		= nil;
	self.delegate		= self;
	self.dataSource		= self;
	self.scrollEnabled	= NO;
	[self setDefaultStyle];
}

#pragma mark - UITableViewDelegate

- (NSArray *)linesForSection:(NSInteger)section
{
	return [self.sections objectAtIndex:section];
}

- (CBFormLineCell *)lineAtIndexPath:(NSIndexPath *)indexPath
{
	return [[self linesForSection:indexPath.section] objectAtIndex:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	if (self.formDelegate && [self.formDelegate respondsToSelector:@selector(form:heightForSection:)]) {
		return [self.formDelegate form:self heightForSection:section];
	} else {
		return 25;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	if (self.formDelegate && [self.formDelegate respondsToSelector:@selector(form:heightForFooterInSection:)] && ([_sections objectAtIndex:section] == [_sections lastObject])) {
		return [self.formDelegate form:self heightForFooterInSection:section];
	} else {
		return 0;
	}
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	if (self.formDelegate && [self.formDelegate respondsToSelector:@selector(form:viewForHeaderInSection:)]) {
		return [self.formDelegate form:self viewForHeaderInSection:section];
	} else {
		return nil;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CBFormLineCell *line = [self lineAtIndexPath:indexPath];
    
	return line.lineHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [[self linesForSection:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [self lineAtIndexPath:indexPath];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return [self.sectionsTitle objectAtIndex:section];
}

#pragma mark - Listening to line events

- (void)setLinesEventListeners
{
	for (CBFormLineCell *line in self.allLines) {
		for (CBFormFieldView *field in line.fields) {
			UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onFieldTap:)];
			tap.cancelsTouchesInView = NO;
			[field addGestureRecognizer:tap];
		}
	}
}

- (void)onFieldTap:(UITapGestureRecognizer *)tap
{
	[self setFocusOnField:(CBFormFieldView *)tap.view];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	return _footer;
}

#pragma mark - Form interaction

- (void)setFocusOnPreviousField
{
	if (self.editingField == nil) {
		return;
	}
    
	CBFormLineCell	*editingLine		= self.editingField.line;
	NSUInteger		indexOfEditingField = [editingLine.fields indexOfObject:self.editingField];
    
	if (indexOfEditingField == 0) {	// First field of current line
		NSUInteger indexOfEditingLine = [self.allLines indexOfObject:editingLine];
        
		if (indexOfEditingLine == 0) {	// First line
			[self leaveFocusOnField:self.editingField];
		} else {
			CBFormLineCell	*previousLine				= [self.allLines objectAtIndex:indexOfEditingLine - 1];
			CBFormFieldView *lastFieldOfPreviousLine	= [previousLine.fields lastObject];
			[self setFocusOnField:lastFieldOfPreviousLine];
		}
	} else {
		[self setFocusOnField:[editingLine.fields objectAtIndex:indexOfEditingField - 1]];
	}
}

- (void)setFocusOnNextField
{
	if (self.editingField == nil) {
		[self setFocusOnLine:[self.allLines objectAtIndex:0]];
	} else {
		CBFormLineCell	*editingLine		= self.editingField.line;
		NSUInteger		indexOfEditingField = [editingLine.fields indexOfObject:self.editingField];
        
		if (indexOfEditingField == editingLine.fields.count - 1) {	// Last field of current line
			NSUInteger indexOfEditingLine = [self.allLines indexOfObject:editingLine];
            
			if (indexOfEditingLine == self.allLines.count - 1) {// Last line
				[self leaveFocusOnField:self.editingField];
			} else {
				[self setFocusOnLine:[self.allLines objectAtIndex:indexOfEditingLine + 1]];
			}
		} else {
			[self setFocusOnField:[editingLine.fields objectAtIndex:indexOfEditingField + 1]];
		}
	}
}

- (void)setFocusOnLine:(CBFormLineCell *)line
{
	[self setFocusOnField:[line.fields objectAtIndex:0]];
}

- (void)setFocusOnField:(CBFormFieldView *)field
{
	if (self.editingField != nil) {
		[self leaveFocusOnField:self.editingField];
	}
    
	_editingField = field;
    
	[field beginEditing];
    
	if (field.viewControllerForPopover != nil) {
		[self showPopoverForField:field];
	}
}

- (void)leaveFocusOnField:(CBFormFieldView *)field
{
	if (self.popover != nil) {
		[self hidePopover];
	}
    
	[field endEditing];
    
	_editingField = nil;
}

- (void)finishEdition
{
    if (self.editingField != nil)
    {
        [self leaveFocusOnField:self.editingField];
    }
}

#pragma mark - Popover

- (void)showPopoverForField:(CBFormFieldView *)field
{
	if (self.popover != nil) {
		[self hidePopover];
	}
    
	self.popover			= [[UIPopoverController alloc] initWithContentViewController:field.viewControllerForPopover];
	self.popover.delegate	= self;
	[self.popover presentPopoverFromRect:field.bounds inView:field permittedArrowDirections:field.popoverArrowDirection animated:YES];
}

- (void)hidePopover
{
	[self.popover dismissPopoverAnimated:NO];
	[self.editingField popoverControllerDidDismissPopover:self.popover];
	self.popover = nil;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
	[self.editingField popoverControllerDidDismissPopover:self.popover];
	[self leaveFocusOnField:self.editingField];
}

#pragma mark - Fields validation

- (BOOL)validate
{
    [self finishEdition];
    BOOL lineValid;
    self.validationErrorMessages = [NSMutableArray new];
	for (CBFormLineCell *line in self.allLines) {
        lineValid = YES;
		for (CBFormFieldView *field in line.fields) {
			if (field.validationType == CBFieldValidationNone) {
				continue;
			}
            
			BOOL		isFieldValid	= YES;
			NSString	*formatString	= @"";
            
			if ((field.validationType & CBFieldValidationMandatory) == CBFieldValidationMandatory) {
				isFieldValid = [CBFormUtils validateMandatoryField:field];
                
				if (isFieldValid == NO) {
					formatString = @"%@ is required";
				}
			}
            
			NSString *displayValue = [field.displayValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
			// Since this field is not mandatory (or if it was mandatory it has a value set), we assume this field is valid if has no value set
			if (isFieldValid && (displayValue.length > 0)) {
                
				if ((field.validationType & CBFieldValidationAlphanumeric) == CBFieldValidationAlphanumeric) {
					isFieldValid = [CBFormUtils validateAlphanumericField:field];
                    
					if (isFieldValid == NO) {
						formatString = @"%@ only allows alpha numeric characters";
					}
				} else if ((field.validationType & CBFieldValidationNumeric) == CBFieldValidationNumeric) {
					isFieldValid = [CBFormUtils validateNumericField:field];
                    
					if (isFieldValid == NO) {
						formatString = @"%@ only allows numbers";
					}
				} else if ((field.validationType & CBFieldValidationEmail) == CBFieldValidationEmail) {
					isFieldValid = [CBFormUtils validateEmailField:field];
                    
					if (isFieldValid == NO) {
						formatString = @"Invalid e-mail for %@";
					}
				} else if ((field.validationType & CBFieldValidationPhone) == CBFieldValidationPhone) {
					isFieldValid = [CBFormUtils validatePhoneField:field];
                    
					if (isFieldValid == NO) {
						formatString = @"%@ format must be XXX-XXX-XXXX";
					}
				}
			}
            
			if (isFieldValid == NO) {
				[self.validationErrorMessages addObject:[NSString stringWithFormat:formatString, field.description]];
                line.lblValidationAsterisk.hidden = NO;
                if(field.validationMark != nil)
                    field.validationMark.hidden = NO;
                lineValid = NO;
			}
            else
            {
                if(lineValid == YES)
                    line.lblValidationAsterisk.hidden = YES;
                if(field.validationMark != nil)
                    field.validationMark.hidden = YES;
            }
		}
	}
    
    if (self.validationErrorMessages.count > 0)
    {
        return NO;
    }
    
	return YES;
}

- (NSString*) getValidationErrorMessage
{
    return [CBReusableMethods getValidationErrorMessageFromArray:self.validationErrorMessages];
}

#pragma mark - Preparing the form for submission

- (void)getReadyToSubmitWithBlock:(void (^)())block
{
    [self finishEdition];
    
	[[self findFirstResponder] resignFirstResponder];
    
	NSMutableDictionary *missingLookupFields = [NSMutableDictionary dictionary];
    
	// Look for any lookup field with missing param ids
	NSArray *allLines = self.allLines;
   /*
	for (CBFormLineCell *line in allLines) {
		for (id field in line.fields) {
			 
		}
	}
    
	// Call immediately the block if there aren't any missing param ids
	if (missingLookupFields.count == 0) {
		if (block) {
			block();
		}
        
		return;
	}
    
	[[CBLookupsManager shared] loadLookupsWithIds:[missingLookupFields allKeys] onLookupCompletion:^(NSString *lookupId, NSArray *values, NSError *error) {
		// Fill in the selected values for each lookup field so later the field can build the param ids comma separated string correctly
		NSMutableArray *lookupFields = [missingLookupFields objectForKey:lookupId];
        
		for (CBFormLookupField * lookupField in lookupFields) {
			lookupField.values = values;
			NSLog(@"Setting selected values from display value for field %@", lookupField.displayValue);
			[lookupField setSelectedValuesWithDisplayValue];
		}
	} onCompletion:^{
		if (block) {
			block();
		}
	}];*/
}

#pragma mark - Getting fields with tag

- (CBFormFieldView *)fieldWithTag:(NSInteger)tag
{
	for (CBFormLineCell *line in self.allLines) {
		for (CBFormFieldView *field in line.fields) {
			if (field.tag == tag) {
				return field;
			}
		}
	}
    
	return nil;
}

- (CBFormFieldView *)fieldWithTag:(NSInteger)tag atLineIndex:(NSUInteger)lineIndex
{
	for (CBFormLineCell *line in self.allLines) {
		if ([self.allLines indexOfObject:line] == lineIndex) {
			for (CBFormFieldView *field in line.fields) {
				if (field.tag == tag) {
					return field;
				}
			}
		}
	}
    
	return nil;
}

- (CBFormListField *)listFieldWithTag:(NSInteger)tag
{
	return (CBFormListField *)[self fieldWithTag:tag];
}

- (CBFormTextField *)textFieldWithTag:(NSInteger)tag
{
	return (CBFormTextField *)[self fieldWithTag:tag];
}

- (CBFormTextViewField *)textViewFieldWithTag:(NSInteger)tag
{
	return (CBFormTextViewField *)[self fieldWithTag:tag];
}

- (CBFormDateField *)dateFieldWithTag:(NSInteger)tag
{
	return (CBFormDateField *)[self fieldWithTag:tag];
}

- (void) setValidationErrorMarkWithTag:(NSInteger)tag
{
    for (CBFormLineCell *line in self.allLines) {
		for (CBFormFieldView *field in line.fields) {
			if (field.tag == tag)
            {
                line.lblValidationAsterisk.hidden = NO;
				return;
			}
		}
	}
}

- (void) clearValidationErrorMarkWithTag:(NSInteger)tag
{
    for (CBFormLineCell *line in self.allLines) {
		for (CBFormFieldView *field in line.fields) {
			if (field.tag == tag)
            {
                line.lblValidationAsterisk.hidden = YES;
				return;
			}
		}
	}
}

- (void) clearAllValidationErrorMarks
{
    for (CBFormLineCell *line in self.allLines) {
        line.lblValidationAsterisk.hidden = YES;
	}
}

@end
