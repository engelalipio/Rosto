//
//  NSNumber+Format.h
//  ChaseBook
//
//  Created by Mariano Donati on 5/20/13.
//  Copyright (c) 2013 Luciano Castro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Format)

- (NSString *)currencyString;
+ (NSNumberFormatter *)currencyFormatter;
+ (NSNumberFormatter *)percentFormatter;

@end
