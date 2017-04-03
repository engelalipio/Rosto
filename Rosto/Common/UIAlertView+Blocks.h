//
//  UIAlertView+Blocks.h
//
//
//  Created by Mariano Donati on 7/30/12.
//  Copyright (c) 2012 Globant. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *   UIAlertView with blocks and ARC support. Core code gotten from http://www.wannabegeek.com/?p=96
 */
@interface UIAlertView (Blocks)

+ (id)alertWithTitle:(NSString *)title message:(NSString *)message acceptButtonTitle:(NSString *)acceptButtonTitle;

+ (id)alertWithTitle:(NSString *)title message:(NSString *)message acceptButtonTitle:(NSString *)acceptButtonTitle completionBlock:(void(^) (NSUInteger buttonIndex))block;

+ (id)alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle acceptButtonTitle:(NSString *)acceptButtonTitle completionBlock:(void(^) (NSUInteger buttonIndex))block;

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle acceptButtonTitle:(NSString *)acceptButtonTitle completionBlock:(void(^) (NSUInteger buttonIndex))block;

@end
