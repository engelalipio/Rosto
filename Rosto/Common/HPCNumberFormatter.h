//
//  HPCNumberFormatter.h
//  Created by Engel Alipio
//  Copyright Agile Mobile Solutons L.L.C All rights reserved.
//

#import "HPCFormatter.h"

@interface HPCNumberFormatter : HPCFormatter

@property (nonatomic, assign) NSInteger decimalDigitsCount;
@property (nonatomic, assign) NSInteger multiplier;

+ (HPCNumberFormatter *)currencyFormatterWithDecimalDigitsCount:(NSInteger)digitsCount;
+ (HPCNumberFormatter *)percentFormatterWithDecimalDigitsCount:(NSInteger)digitsCount;

@end
