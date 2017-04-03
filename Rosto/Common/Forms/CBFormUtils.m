//
//  CBFormUtils.m
//  ChaseBook
//
//  Created by santiago.fontanarrosa on 6/26/13.
//  Copyright (c) 2013 Engel Alipio. All rights reserved.
//

#import "CBFormUtils.h"

@implementation CBFormUtils

+ (BOOL)validateMandatoryField:(CBFormFieldView *)field
{
	if (field.displayValue == nil) {
		return NO;
	}
    
	NSString *trimmedString = [field.displayValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
	return trimmedString.length > 0;
}

+ (BOOL)validateEmailField:(CBFormFieldView *)field
{
	BOOL		stricterFilter			= YES;	// Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
	NSString	*stricterFilterString	= @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSString	*laxString				= @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
	NSString	*emailRegex				= stricterFilter ? stricterFilterString : laxString;
	NSPredicate *emailTest				= [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
	return [emailTest evaluateWithObject:field.displayValue];
}

+ (BOOL)validateNumericField:(CBFormFieldView *)field
{
	NSString *value = [field.displayValue stringByReplacingOccurrencesOfString:@"$" withString:@""];
    
	value	= [value stringByReplacingOccurrencesOfString:@"%" withString:@""];
	value	= [value stringByReplacingOccurrencesOfString:@"." withString:@""];
	value	= [value stringByReplacingOccurrencesOfString:@"," withString:@""];
    
	NSCharacterSet	*digitsCharset		= [NSCharacterSet decimalDigitCharacterSet];
	NSString		*valueWithoutNums	= [[value componentsSeparatedByCharactersInSet:digitsCharset] componentsJoinedByString:@""];
    
	return valueWithoutNums.length == 0;
}

+ (BOOL)validateAlphanumericField:(CBFormFieldView *)field
{
	NSString		*value				= field.displayValue;
	NSCharacterSet	*digitsCharset		= [NSCharacterSet alphanumericCharacterSet];
	NSString		*valueWithoutChars	= [[value componentsSeparatedByCharactersInSet:digitsCharset] componentsJoinedByString:@""];
    
	return valueWithoutChars.length == 0;
}

+ (BOOL)validatePhoneField:(CBFormFieldView *)field
{
	NSString	*phoneNumber	= field.displayValue;
	NSString	*phoneRegex		= @"[0-9]{3}[-]{1}[0-9]{3}[-]{1}[0-9]{4}";
	NSPredicate *test			= [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
	return [test evaluateWithObject:phoneNumber];
}
+ (BOOL)validateCreditCardField:(CBFormFieldView *)field{
    NSString	*creditCardNumber	= field.displayValue;
    NSString	*creditCardRegex	= @"[0-9]{4}[-]{1}[0-9]{4}[-]{1}[0-9]{4}[-]{1}[0-9]{4}";
    NSPredicate *test			    = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", creditCardRegex];
    
    return [test evaluateWithObject:creditCardNumber];
}

@end
