//
//  CBFormDescriptionField.m
//  ChaseBook
//
//  Created by Engel Alipio on 5/16/13.
//  Copyright (c) 2013 Engel Alipio. All rights reserved.
//

#import "CBFormDescriptionField.h"
#import "CBFormFieldView_Protected.h"

@implementation CBFormDescriptionField

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.userInteractionEnabled = NO;
}

- (void)setDisplayValue:(NSString *)displayValue
{
    self.valueLabel.text = displayValue;
    self.hasValue = YES;
}

@end
