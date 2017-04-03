//
//  CBFormDateField.m
//  ChaseBook
//
//  Created by Luciano Donati on 5/13/13.
//  Copyright (c) 2013 Engel Alipio. All rights reserved.
//

#import "CBFormDateField.h"
#import "CBForm.h"
#import "NSDate+Format.h"

@interface CBFormDateField ()

@property (nonatomic,readonly) CBFormDateVC *lookupViewController;
@property (nonatomic,strong) NSDate* dateValueBeforeEditing;

@end

@implementation CBFormDateField

- (void)awakeFromNib
{
    [super awakeFromNib];
        
    //Create the picker controller
    _dateViewController = [[CBFormDateVC alloc] initWithNibName:@"CBFormDateVC" bundle:nil];
    _dateViewController.delegate = self;
    _dateViewController.minDate = self.minDate;
    _dateViewController.maxDate = self.maxDate;
    [_dateViewController reloadInputViews];
    self.viewControllerForPopover = _dateViewController;
    self.lookupPopoverSiz = CGSizeMake(315, 259);
    self.lookupViewController.contentSizeForViewInPopover =  CGSizeMake(315, 259);
}

- (CBFormDateVC *)lookupViewController
{
    CBFormDateVC *viewController = (CBFormDateVC*)self.viewControllerForPopover;
    viewController.minDate = self.minDate;
    viewController.maxDate = self.maxDate;
    [viewController reloadInputViews];
    return (CBFormDateVC *)viewController;
}

- (void)beginEditing
{
    self.lookupViewController.title = self.description;
    self.dateValueBeforeEditing = _dateViewController.datePickr.date;
}

- (BOOL)hasChanges
{
    UIDatePicker* datePicker = _dateViewController.datePickr;
    return (datePicker.date != nil  && self.dateValueBeforeEditing != datePicker.date);
}

#pragma mark - Lookup delegate

- (void)lookupDateViewController:(CBFormDateVC *)viewController didFinishPickingDate:(NSDate *)date;
{
    [self setDisplayValue:[date stringWithFormatMonthDayYear]];
    [self.line.form leaveFocusOnField:self];
}

- (void) dismissPopover
{
    [self.line.form hidePopover];
}

@end
