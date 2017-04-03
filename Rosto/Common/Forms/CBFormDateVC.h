//
//  CBFormDateVCViewController.h
//  ChaseBook
//
//  Created by Engel Alipio on 5/20/13.
//  Copyright (c) 2013 Engel Alipio. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CBFormDateViewControllerDelegate;

@interface CBFormDateVC : UIViewController

@property (nonatomic, strong) NSDate								*selectedDate;
@property (strong, nonatomic) IBOutlet UIDatePicker					*datePickr;
@property (nonatomic, weak) id <CBFormDateViewControllerDelegate>	delegate;
@property (nonatomic, strong) IBOutlet UIBarButtonItem				*titleItem;
@property (nonatomic, strong) NSDate								*minDate;
@property (nonatomic, strong) NSDate								*maxDate;

- (IBAction)onDone:(id)sender;

@end

@protocol CBFormDateViewControllerDelegate

- (void)lookupDateViewController:(CBFormDateVC *)viewController didFinishPickingDate:(NSDate *)date;

- (void)dismissPopover;

@end
