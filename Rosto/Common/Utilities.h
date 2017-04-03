//
//  Utilities.h
//  OrderMyTableNow
//
//  Created by Engel Alipio on 11/7/15.
//  Copyright © 2015 OrderMyTableNow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilities : NSObject


+(UIView*)    getSpecialTitleView: (UIView*) existingTitleView andNewTitle: (NSString*) anyTitle;

+(UIView*)    getSpecialTitleViewImage: (UIView*) existingTitleView andNewImage: (UIImage *) anyImage;

+(UIImage *) imageResize :(UIImage*)img andResizeTo:(CGSize)newSize;

+(UIImage*)  getParseImage:(NSArray *) imageSourceArray anyIndex:(NSInteger) imageIndex;

+(void) setParseImageCell:(NSArray *) imageSourceArray anyIndex:(NSInteger) imageIndex tableCell:(UITableViewCell *) anyRow;
+(void) setParseImageCellWithText:(NSArray *) imageSourceArray anyIndex:(NSInteger) imageIndex tableCell:(UITableViewCell *) anyRow;

+(void) setParseImageView:(NSArray *) imageSourceArray anyIndex:(NSInteger) imageIndex tableCell:(UIImageView *) anyView;
@end
