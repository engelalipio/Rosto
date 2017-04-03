//
//  UIAlertView+Blocks.m
//
//
//  Created by Mariano Donati on 7/30/12.
//  Copyright (c) 2012 Globant. All rights reserved.
//

#import "UIAlertView+Blocks.h"
#import <objc/runtime.h>

@implementation UIAlertView (Blocks)

+ (id)alertWithTitle:(NSString *)title message:(NSString *)message acceptButtonTitle:(NSString *)acceptButtonTitle
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:acceptButtonTitle otherButtonTitles:nil];
    
	[alert show];
	return alert;
}

+ (id)alertWithTitle:(NSString *)title message:(NSString *)message acceptButtonTitle:(NSString *)acceptButtonTitle completionBlock:(void (^)(NSUInteger buttonIndex))block
{
	return [self alertWithTitle:title message:message cancelButtonTitle:acceptButtonTitle acceptButtonTitle:nil completionBlock:block];
}

+ (id)alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle acceptButtonTitle:(NSString *)acceptButtonTitle completionBlock:(void (^)(NSUInteger buttonIndex))block
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message cancelButtonTitle:cancelButtonTitle acceptButtonTitle:acceptButtonTitle completionBlock:block];
    
	[alert show];
	return alert;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle acceptButtonTitle:(NSString *)acceptButtonTitle completionBlock:(void (^)(NSUInteger buttonIndex))block
{
	objc_setAssociatedObject(self, "blockCallback", [block copy], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
	if (self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil]) {
		if (cancelButtonTitle) {
			[self addButtonWithTitle:cancelButtonTitle];
			self.cancelButtonIndex = [self numberOfButtons] - 1;
		}
        
		if (acceptButtonTitle) {
			[self addButtonWithTitle:acceptButtonTitle];
		}
	}
    
	return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	void (^block)(NSUInteger buttonIndex) = objc_getAssociatedObject(self, "blockCallback");
    
	if (block == nil) {
		return;
	}
    
	block(buttonIndex);
}

@end
