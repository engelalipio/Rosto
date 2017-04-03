//
//  AppDelegate.h
//  Rosto
//
//  Created by Engel Alipio on 5/26/16.
//  Copyright © 2017 Agile Mobile Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (assign,nonatomic) NSInteger screenHeight;
+(AppDelegate *) currentDelegate;
@end

