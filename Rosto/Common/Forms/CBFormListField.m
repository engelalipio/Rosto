//
//  CBFormListField.m
//  ChaseBook
//
//  Created by Engel Alipio on 5/7/13.
//  Copyright (c) 2013 Engel Alipio. All rights reserved.
//

#import "CBFormListField.h"
#import "CBFormPickerViewController.h"
#import "CBFormFieldView_Protected.h"
#import "CBFormLineCell.h"
#import "CBForm.h"

@interface CBFormListField () <UIPickerViewDelegate>

@property (nonatomic,readonly) CBFormPickerViewController *pickerViewController;

@end

@implementation CBFormListField

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    //Set no values by default
    self.values = @[];
    self.selectedValueIndex = 0;
    
    //Create the picker controller
    CBFormPickerViewController *pickerViewController = [[CBFormPickerViewController alloc] initWithNibName:@"CBFormPickerViewController" bundle:nil];
    pickerViewController.pickerViewDelegate = self;
    self.viewControllerForPopover = pickerViewController;
}

- (CBFormPickerViewController *)pickerViewController
{
    return (CBFormPickerViewController *)self.viewControllerForPopover;
}

- (void)beginEditing
{
    [super beginEditing];
    
    if ((self.values.count == 0 || self.values == nil) && self.asynchronousLoadingOperation != nil)
    {
        self.pickerViewController.state = CBFormPickerStateLoading;
        self.asynchronousLoadingOperation(self);
    }
    else
    {
        [self loadValuesIntoPicker];
    }
}

- (void)loadValuesIntoPicker
{
    self.pickerViewController.values = self.values;
    [self.pickerViewController reloadAllComponents];
    [self.pickerViewController selectRow:self.selectedValueIndex animated:NO];
}

- (void)endAsynchronousLoadingOperationWithValues:(NSArray *)values
{
    self.values = values;
    self.pickerViewController.state = CBFormPickerStateReady;
    [self loadValuesIntoPicker];
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedValueIndex = row;
    [self setDisplayValue:[self.pickerViewController displayTextAtRow:row]];
    
    if (self.pickerViewController.pickerViewTap)
    {
        [self.line.form leaveFocusOnField:self];
    }
}

@end
