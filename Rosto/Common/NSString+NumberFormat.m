//
//  NSString+NumberFormat.m
//  ChaseBook
//
//  Created by Mariano Donati on 5/20/13.
//  Copyright (c) 2013 Luciano Castro. All rights reserved.
//

#import "NSString+NumberFormat.h"
#import "Constants.h"

const NSUInteger	kStandardPhoneNumberDigits	= 10;
const NSUInteger    kShortPhoneNumberDigits     = 7;
NSString *const		kPhoneNumberMask			= @"%@ (%@)%@-%@ %@";
NSString *const		kShortPhoneNumberMask		= @"%@-%@";

@implementation NSString (NumberFormat)

+ (NSString *)currencyStringFromNumber:(NSNumber *)number
{
	NSString *s = [NSString stringWithFormat:@"%@", number];
    
	return [s maskedStringWithNumberPrefix:@"$" suffix:@"" multiplier:1 removesDecimalPoint:NO];
}

+ (NSString *)percentStringFromNumber:(NSNumber *)number
{
	NSString *s = [NSString stringWithFormat:@"%@", number];
    
	return [s maskedStringWithNumberPrefix:@"" suffix:@"%" multiplier:1 removesDecimalPoint:NO];
}

- (NSString *)currencyMaskedStringWithDecimalDigits:(NSInteger)decimalDigits
{
	return [self maskedStringWithNumberPrefix:@"$" suffix:@"" multiplier:1 / powf(10, decimalDigits) removesDecimalPoint:YES];
}

- (NSString *)percentMaskedStringWithDecimalDigits:(NSInteger)decimalDigits
{
	return [self maskedStringWithNumberPrefix:@"" suffix:@"%" multiplier:1 / powf(10, decimalDigits) removesDecimalPoint:YES];
}

- (NSString *)maskedStringWithNumberPrefix:(NSString *)prefix suffix:(NSString *)suffix multiplier:(CGFloat)multiplier removesDecimalPoint:(BOOL)removesDecimalPoint
{
	NSString				*allDigits		= kAllDigits;
	NSMutableCharacterSet	*charsToKeep	= [NSMutableCharacterSet characterSetWithCharactersInString:allDigits];
    
	if (removesDecimalPoint == NO) {
		[charsToKeep addCharactersInString:@"."];
	}
    
	NSString *stringWithoutSymbols = [[self componentsSeparatedByCharactersInSet:[charsToKeep invertedSet]] componentsJoinedByString:@""];
    
	double number = [stringWithoutSymbols doubleValue];
    
	number *= multiplier;
    
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	formatter.numberStyle			= NSNumberFormatterDecimalStyle;
	formatter.maximumFractionDigits = 2;
    
	return [NSString stringWithFormat:@"%@%@%@", prefix, [formatter stringFromNumber:[NSNumber numberWithDouble:number]], suffix];
}

- (NSString *)standarizedPhoneNumber
{
	NSArray		*components		= [self componentsSeparatedByString:@" "];
	NSString	*countryCode	= [NSString string];
	NSString	*phoneNumber	= [NSString string];
	NSString	*extNumber		= [NSString string];
    
	switch (components.count) {
		case 0:
			break;
            
		case 1:
			phoneNumber = [components lastObject];
            
			if ([phoneNumber hasSuffix:@"+"]) {
				phoneNumber = [phoneNumber substringWithRange:NSMakeRange(phoneNumber.length - kStandardPhoneNumberDigits, kStandardPhoneNumberDigits)];
			}
            
			break;
            
		case 2:
            
			if ([(NSString *)[components objectAtIndex:0] hasSuffix : @"+"]) {
				countryCode = [components objectAtIndex:0];
				phoneNumber = [components objectAtIndex:1];
			} else {
				phoneNumber = [components objectAtIndex:0];
                
				if ([phoneNumber hasSuffix:@"+"]) {
					phoneNumber = [phoneNumber substringWithRange:NSMakeRange(phoneNumber.length - kStandardPhoneNumberDigits, kStandardPhoneNumberDigits)];
				}
                
				extNumber = [components objectAtIndex:1];
			}
            
			break;
            
		case 3:
		default:
            
			if ([(NSString *)[components objectAtIndex:0] hasSuffix : @"+"]) {
				countryCode = [components objectAtIndex:0];
				phoneNumber = [components objectAtIndex:1];
				extNumber	= [components objectAtIndex:2];
			} else {
				if ([phoneNumber hasSuffix:@"+"]) {
					phoneNumber = [phoneNumber substringWithRange:NSMakeRange(phoneNumber.length - kStandardPhoneNumberDigits, kStandardPhoneNumberDigits)];
				}
                
				extNumber = [components objectAtIndex:1];
			}
	}
    
	if (phoneNumber.length == kStandardPhoneNumberDigits) {
		return [NSString stringWithFormat:kPhoneNumberMask,
                countryCode,
                [phoneNumber substringWithRange:NSMakeRange(0, 3)],
                [phoneNumber substringWithRange:NSMakeRange(3, 3)],
                [phoneNumber substringWithRange:NSMakeRange(5, 4)],
                extNumber.length
                ?[NSString stringWithFormat:@"Ext. %@", extNumber]
                                         :[NSString string]];
	}else if(phoneNumber.length == kShortPhoneNumberDigits){
		return [NSString stringWithFormat:kShortPhoneNumberMask,
                [phoneNumber substringWithRange:NSMakeRange(0, 3)],
                [phoneNumber substringWithRange:NSMakeRange(3, 4)]];
    }
    
	return [NSString stringWithString:self];
}

-(NSString *) sanitizedPhoneNumber{
  NSString *cleanedString = [[self componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"]
                                                                         invertedSet]] componentsJoinedByString:@""];
  return cleanedString;
}

@end
