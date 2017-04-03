//
//  NSDate+Format.h
//  HicksPrepClub
//
//  Created by Engel Alipio
//  Copyright (c) Agile Mobile Solutions All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Format)

- (NSString *)stringWithFormat:(NSString *)format;
- (NSString *)stringWithDefaultFormat;
- (NSString *)stringFromDateToServer;
- (NSString *)stringWithFormatYearMonthDay;
- (NSString *)stringWithFormatMonthDayYear;
- (NSString *)stringWithFormatMonthDayYearHourMinute;
- (NSString *)stringWithFormatMonthDayYearHourMinuteNoZeros;
- (NSString *)stringWithFormatMonthDayYearHourMinuteSecond;
+ (NSDate *)dateFromStringWithFormatMonthDayYearHourMinuteSecond:(NSString *)stringDate;
+ (NSDate *)dateFromStringWithFormatMonthDayYear:(NSString *)stringDate;
- (NSString *)stringWithFormatFullWithSingleDigitDay;

@end
