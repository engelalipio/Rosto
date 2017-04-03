//
//  NSString+NumberFormat.h
//  ChaseBook
//
//  Created by Mariano Donati on 5/20/13.
//  Copyright (c) 2013 Luciano Castro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NumberFormat)

+ (NSString *)currencyStringFromNumber:(NSNumber *)number;
+ (NSString *)percentStringFromNumber:(NSNumber *)number;
- (NSString *)currencyMaskedStringWithDecimalDigits:(NSInteger)decimalDigits;
- (NSString *)percentMaskedStringWithDecimalDigits:(NSInteger)decimalDigits;
- (NSString *)standarizedPhoneNumber;
- (NSString *)sanitizedPhoneNumber;
@end
