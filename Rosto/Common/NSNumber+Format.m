//
//  NSNumber+Format.m
//  ChaseBook
//
//  Created by Mariano Donati on 5/20/13.
//  Copyright (c) 2013 Luciano Castro. All rights reserved.
//

#import "NSNumber+Format.h"

@implementation NSNumber (Format)

- (NSString *)currencyString
{
	return [[NSNumber currencyFormatter] stringFromNumber:self];
}

- (NSString *)percentString
{
	return [[NSNumber percentFormatter] stringFromNumber:self];
}

+ (NSNumberFormatter *)currencyFormatter
{
	NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
	formatter.numberStyle = NSNumberFormatterCurrencyStyle;
	[formatter setLocale:usLocale];
    
	return formatter;
}

+ (NSNumberFormatter *)percentFormatter
{
	NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
	formatter.numberStyle = NSNumberFormatterPercentStyle;
	[formatter setLocale:usLocale];
    
	return formatter;
}

@end
