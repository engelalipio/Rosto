//
//  CBFormLookupField.h
//  ChaseBook
//
//  Created by Engel Alipio on 5/13/13.
//  Copyright (c) 2013 Engel Alipio. All rights reserved.
//

#import "CBFormFieldView.h"
#import "CBFormDateVC.h"

@interface CBFormDateField : CBFormFieldView <CBFormDateViewControllerDelegate>

@property (nonatomic,strong) CBFormDateVC* dateViewController;
@property (nonatomic,strong) NSDate *selectedDate;
@property (nonatomic,assign) CGSize lookupPopoverSiz;
@property (nonatomic,strong) NSDate * minDate;
@property (nonatomic,strong) NSDate * maxDate;


@end
