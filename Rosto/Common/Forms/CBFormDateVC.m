//
//  CBFormDateVCViewController.m
//  ChaseBook
//
//  Created by Engel Alipio on 5/20/13.
//  Copyright (c) 2013 Engel Alipio. All rights reserved.
//

#import "CBFormDateVC.h"
#import "NSDate+Format.h"

@interface CBFormDateVC ()

@end

@implementation CBFormDateVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	self.titleItem.title		= self.title;
	self.datePickr.minimumDate	= self.minDate;
	self.datePickr.maximumDate	= self.maxDate;
}

- (IBAction)onDone:(id)sender
{
	self.selectedDate = [self.datePickr date];
	[self.delegate lookupDateViewController:self didFinishPickingDate:self.selectedDate];
}

- (IBAction)onClear:(id)sender
{
	self.datePickr.date = self.minDate;
}

- (IBAction)onCancel:(id)sender
{
	[self.delegate dismissPopover];
}

- (IBAction) datePickerChanged:(id)sender {
    // When `setDate:` is called, if the passed date argument exactly matches the Picker's date property's value, the Picker will do nothing. So, offset the passed date argument by one second, ensuring the Picker scrolls every time.
    NSString * minDate = [self.datePickr.minimumDate stringWithFormatMonthDayYear];
    NSString * date = [self.datePickr.date stringWithFormatMonthDayYear];
    NSString * maxDate = [self.datePickr.maximumDate stringWithFormatMonthDayYear];
    
    if ([date isEqualToString:minDate])
    {
        self.datePickr.date = self.datePickr.minimumDate;
    }
    else if ([date isEqualToString:maxDate])
    {
        self.datePickr.date = self.datePickr.maximumDate;
    }
}

- (void)viewDidUnload
{
	[self setDatePickr:nil];
	[super viewDidUnload];
}

@end
