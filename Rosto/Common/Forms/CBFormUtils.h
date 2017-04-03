//
//  CBFormUtils.h
//  ChaseBook
//
//  Created by santiago.fontanarrosa on 6/26/13.
//  Copyright (c) 2013 Engel Alipio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBFormFieldView.h"

@interface CBFormUtils : NSObject

+ (BOOL)validateMandatoryField:(CBFormFieldView *)field;
+ (BOOL)validateEmailField:(CBFormFieldView *)field;
+ (BOOL)validateNumericField:(CBFormFieldView *)field;
+ (BOOL)validateAlphanumericField:(CBFormFieldView *)field;
+ (BOOL)validatePhoneField:(CBFormFieldView *)field;
+ (BOOL)validateCreditCardField:(CBFormFieldView *)field;
@end
