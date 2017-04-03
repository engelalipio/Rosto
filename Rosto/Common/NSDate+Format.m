//
//  NSDate+Format.m
//  HicksPrepClub
//
//  Created by Engel Alipio
//  Copyright (c) Agile Mobile Solutions All rights reserved.
//

#import "NSDate+Format.h"

#define kDateFormatYearMonthDay						@"yyyyMMdd"
#define kDateFormatMonthDayYear						@"M/d/yyyy"
#define kDateFormatFullWithSingleDigitDay			@"M/d/yyyy hh:mm a"
#define kDateFormatMonthDayYearHourMinute			@"MM/dd/yyyy hh:mm a"
#define kDateFormatMonthDayYearHourMinuteNoZeros	@"M/dd/yyyy h:mm a"
#define kDateFormatMonthDayYearHourMinuteNoZerosH	@"MM/dd/yyyy h:mm a"
#define kDateFormatMonthDayYearHourMinuteSecond		@"MM/dd/yyyy hh:mm:ss a"

@implementation NSDate (Format)

- (NSString *)stringWithDefaultFormat
{
	return [self stringWithFormat:@"yyMMdd HHmm a"];
}

- (NSString *)stringWithFormat:(NSString *)format
{
	NSString		*dateFormat = [NSDateFormatter dateFormatFromTemplate:format options:0 locale:[NSLocale currentLocale]];
	NSDateFormatter *formatter	= [[NSDateFormatter alloc] init];
    
	[formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:[[NSTimeZone localTimeZone] secondsFromGMT]]];
	[formatter setDateFormat:dateFormat];
	return [formatter stringFromDate:self];
}

- (NSString *)stringFromDateToServer
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
	[dateFormatter setDateFormat:kDateFormatMonthDayYearHourMinuteNoZerosH];
    
	return [dateFormatter stringFromDate:self];
}

- (NSString *)stringWithFormatYearMonthDay
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:[[NSTimeZone localTimeZone] secondsFromGMT]]];
	[dateFormatter setDateFormat:kDateFormatYearMonthDay];
	return [dateFormatter stringFromDate:self];
}

- (NSString *)stringWithFormatMonthDayYear
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:[[NSTimeZone localTimeZone] secondsFromGMT]]];
	[dateFormatter setDateFormat:kDateFormatMonthDayYear];
	return [dateFormatter stringFromDate:self];
}

- (NSString *)stringWithFormatMonthDayYearHourMinute
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:[[NSTimeZone localTimeZone] secondsFromGMT]]];
	[dateFormatter setDateFormat:kDateFormatMonthDayYearHourMinute];
	return [dateFormatter stringFromDate:self];
}

- (NSString *)stringWithFormatFullWithSingleDigitDay
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:[[NSTimeZone localTimeZone] secondsFromGMT]]];
	[dateFormatter setDateFormat:kDateFormatFullWithSingleDigitDay];
	return [dateFormatter stringFromDate:self];
}

- (NSString *)stringWithFormatMonthDayYearHourMinuteNoZeros
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:[[NSTimeZone localTimeZone] secondsFromGMT]]];
	[dateFormatter setDateFormat:kDateFormatMonthDayYearHourMinuteNoZeros];
	return [dateFormatter stringFromDate:self];
}

- (NSString *)stringWithFormatMonthDayYearHourMinuteSecond
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
	[dateFormatter setDateFormat:kDateFormatMonthDayYearHourMinuteSecond];
	return [dateFormatter stringFromDate:self];
}

+ (NSDate *)dateFromStringWithFormatMonthDayYearHourMinuteSecond:(NSString *)stringDate
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:[[NSTimeZone localTimeZone] secondsFromGMT]]];
	[dateFormatter setDateFormat:kDateFormatMonthDayYearHourMinuteSecond];
	return [dateFormatter dateFromString:stringDate];
}

+ (NSDate *)dateFromStringWithFormatMonthDayYear:(NSString *)stringDate
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:[[NSTimeZone localTimeZone] secondsFromGMT]]];
	[dateFormatter setDateFormat:kDateFormatMonthDayYear];
	return [dateFormatter dateFromString:stringDate];
}

@end
