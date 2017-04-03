//
//  CBPostView.h
//  ChaseBook
//
//  Created by Engel Alipio on 5/3/13.
//  Copyright (c) 2013 Engel Alipio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBPostView : UIView

@property (nonatomic,assign) BOOL readonly;
@property (nonatomic,strong) NSString *cancelButtonTitle;
@property (nonatomic,strong) NSString *acceptButtonTitle;
@property (nonatomic,strong) NSString *text;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *placeholderText;
@property (nonatomic,assign) NSUInteger numberOfCharsAllowed;
@property (nonatomic,assign) BOOL showsAlertOnUnsavedWork;
@property (nonatomic,assign) BOOL avoidEmptyText;
@property (nonatomic,strong) NSString *emptyTextMessage;
@property (nonatomic,assign) BOOL isNewComment;

- (void)showInView:(UIView *)view onDone:(void(^)(NSString *newText, BOOL canceled))onDone;

@end

