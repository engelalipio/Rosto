//
//  HeaderImageCell.h
//  iLush
//
//  Created by Engel Alipio on 10/17/14.
//  Copyright (c) 2014 Lush. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "UIImage+ImageEffects.h"

@interface HeaderImageCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageEstablishment;
@property (strong, nonatomic) IBOutlet UIImageView *imageCircle;

@property (strong, nonatomic) IBOutlet UILabel *labelName;
@property (strong, nonatomic) IBOutlet UILabel *labeDetail;
@property (assign, nonatomic)  CGRect parentFrame;
+ (id)instanceFromNibWithName:(NSString *)nibName;
-(void) initControls:(CGRect) frame;
+ (id)instanceFromNib;
- (void)setSize:(CGSize)size;
@end
