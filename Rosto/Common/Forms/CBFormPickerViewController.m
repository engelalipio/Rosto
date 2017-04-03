//
//  CBFormPickerViewController.m
//  ChaseBook
//
//  Created by Engel Alipio on 5/7/13.
//  Copyright (c) 2013 Engel Alipio. All rights reserved.
//

#import "CBFormPickerViewController.h"
//#import "DejalActivityView.h"
#import "Constants.h"

@interface CBFormPickerViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic,strong) IBOutlet UIPickerView *pickerView;

@end

@implementation CBFormPickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.state = CBFormPickerStateReady;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setState:self.state]; //Update UI state with whatever the current value is
    self.contentSizeForViewInPopover = self.pickerView.frame.size;
    [self reloadAllComponents];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _pickerViewTap = NO;
}

- (void)reloadAllComponents
{
    [self.pickerView reloadAllComponents];
}

- (void)setState:(CBFormPickerState)state
{
    _state = state;
    
    if (self.view == nil)
        return;
    
    if (state == CBFormPickerStateReady)
    {
    //    [DejalBezelActivityView removeViewAnimated:NO];
        self.pickerView.hidden = NO;
    }
    else
    {
        self.pickerView.hidden = YES;
     //   [DejalBezelActivityView activityViewForView:self.view withLabel:kLoading];
    }
}

#pragma mark - Handling values array

- (NSString *)displayTextAtRow:(NSInteger)row
{
    id value = [self.values objectAtIndex:row];
    
    if ([value isKindOfClass:[NSDictionary class]])
    {
        return [value objectForKey:@"displayText"];
    }
    else
    {
        return value;
    }
}

- (id)valueAtRow:(NSInteger)row
{
    id value = [self.values objectAtIndex:row];
    
    if ([value isKindOfClass:[NSDictionary class]])
    {
        return [value objectForKey:@"value"];
    }
    else
    {
        return value;
    }
}

- (void)selectRow:(NSInteger)row animated:(BOOL)animated
{
    [self.pickerView selectRow:row inComponent:0 animated:animated];
}

#pragma mark - UIPickerViewDelegate and gesture handlers

- (IBAction)onPickerViewTap:(UITapGestureRecognizer *)tap
{
    _pickerViewTap = YES;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.values.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self displayTextAtRow:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self.pickerView selectRow:row inComponent:0 animated:YES];
    [self.pickerViewDelegate pickerView:pickerView didSelectRow:row inComponent:component];
    _pickerViewTap = NO;
}

@end
