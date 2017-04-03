//
//  RestauranceCellTableViewCell.m
//  OrderMyTableNow
//
//  Created by Engel Alipio on 5/25/15.
//  Copyright (c) 2015 OrderMyTableNow. All rights reserved.
//

#import "RestaurantCell.h"
#import "AppDelegate.h"
@implementation RestaurantCell

- (void)awakeFromNib {
    // Initialization code
}


+ (id)instanceFromNib
{
    NSString *className = @"RestaurantCell";
    
    AppDelegate *appDelegate = [AppDelegate currentDelegate];
    
    if(!appDelegate.isIPhone){
        className =@"RestaurantCell_iPad";
    }
    
    return [self instanceFromNibWithName:className];
}

+ (id)instanceFromNibWithName:(NSString *)nibName
{
    return [[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] objectAtIndex:0];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        CGSize size = self.contentView.frame.size;
        
        AppDelegate *appDelegate = [AppDelegate currentDelegate];
        
        BOOL isIPhone = YES;
        
        isIPhone = appDelegate.isIPhone;

        NSInteger imgH = 100,
                         imgW = 100,
                         lblRestFontSize = 11,
                         lblRestNameX  = 108,
                         lblRestNameW = 260,
                         lblRestNameH  = 42,
                         lblRestNameY = 5;
        
        
        if (! isIPhone){
            imgH = 180;
            imgH = 180;
            
            lblRestFontSize = lblRestFontSize + 3;
            
        }
        
        //Begin Restaurant Image
        self.imgRestaurant = [[UIImageView alloc] initWithFrame:CGRectMake(5.0, 5.0, imgW, imgH)];
      //  [self.imgRestaurant setImage:[UIImage imageNamed:@"Icon-Small-50.png"]];
        [self.imgRestaurant setHidden:NO];
        [self.contentView addSubview:self.imgRestaurant];
        //End Restaurant Image
        
        //Begin Restaurant Name
        self.lblRestaurantName = [[UILabel alloc] initWithFrame:CGRectMake(lblRestNameX, lblRestNameY, lblRestNameW, lblRestNameH)];
        [self.lblRestaurantName setFont:[UIFont fontWithName:@"Avenir Heavy Oblique" size:lblRestFontSize]];
        [self.lblRestaurantName setTextAlignment:NSTextAlignmentNatural];
        [self.lblRestaurantName setNumberOfLines:0];
        [self.lblRestaurantName setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:self.lblRestaurantName];
        //End Restaurant Name
        
        //Begin Restaurant Area
        self.lblRestaurantArea = [[UILabel alloc] initWithFrame:CGRectMake(108.0, 40.0, 260.0, 21.0)];
        [self.lblRestaurantArea setFont:[UIFont fontWithName:@"Avenir Book" size:13.0]];
        [self.lblRestaurantArea setTextAlignment:NSTextAlignmentNatural];
        [self.lblRestaurantArea setNumberOfLines:1];
        [self.lblRestaurantArea setTextColor:[UIColor colorWithHexString:@"336699"]];
        [self.contentView addSubview:self.lblRestaurantArea];
        //End Restaurant Area


        //Begin Restaurant Distance
        self.lblRestaurantDistance = [[UILabel alloc] initWithFrame:CGRectMake(108.0, 70.0, 120.0, 21.0)];
        [self.lblRestaurantDistance setFont:[UIFont fontWithName:@"Avenir Book" size:13.0]];
        [self.lblRestaurantDistance setTextAlignment:NSTextAlignmentNatural];
        [self.lblRestaurantDistance setNumberOfLines:1];
        [self.lblRestaurantDistance setTextColor:[UIColor colorWithHexString:@"336699"]];
        [self.contentView addSubview:self.lblRestaurantDistance];
        //End Restaurant Distance
        
        //Begin Restaurant Price
        self.lblRestaurantPrice = [[UILabel alloc] initWithFrame:CGRectMake(230.0, 70.0, 60.0, 21.0)];
        [self.lblRestaurantPrice setFont:[UIFont fontWithName:@"Avenir Heavy" size:12.0]];
        [self.lblRestaurantPrice setTextAlignment:NSTextAlignmentNatural];
        [self.lblRestaurantPrice setNumberOfLines:1];
        [self.lblRestaurantPrice setTextColor:[UIColor colorWithHexString:@"336699"]];
        [self.contentView addSubview:self.lblRestaurantPrice];
        //End Restaurant Price
        
        [self.contentView setHidden:NO];
        
        
    }
    return self;
}



- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    
    frame.size	= size;
    self.frame	= CGRectIntegral(frame);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
