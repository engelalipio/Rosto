//
//  HeaderImageCell.m
//  iLush
//
//  Created by Engel Alipio on 10/17/14.
//  Copyright (c) 2014 Lush. All rights reserved.
//

#import "HeaderImageCell.h"




@implementation HeaderImageCell

@synthesize parentFrame = _parentFrame;

+ (id)instanceFromNib
{
    NSString *className = @"HeaderImageCell";
    
    AppDelegate *appDelegate = [AppDelegate currentDelegate];
    
    if(!appDelegate.isIPhone){
        className =@"HeaderImageCell_iPad";
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
        [self initControls:self.contentView.frame];
 
    }
    return self;
}


/*
-(void) layoutSubviews{
    CGRect contentViewFrame = self.contentView.frame,
                    parentViewFrame = self.parentFrame;
    
    if (contentViewFrame.size.width < parentViewFrame.size.width){
        contentViewFrame.size.width = parentViewFrame.size.width;
        self.contentView.frame = parentViewFrame;
        NSLog(@"Adjusting HeaderImageCell Frame");
    }
    

}*/

-(void) initControls:(CGRect) frame{
    
    CGSize size = frame.size;
    
    AppDelegate *appDelegate = [AppDelegate currentDelegate];
    
    CGFloat imgH = 200.0f,
                  imgW = size.width,
                  lblH   = 20.0f,
                  lblFSize = 16.0f,
                  lblDSize = 14.0f,
                  lblDY = 180.0f;
    
    
    if(!appDelegate.isIPhone){
        imgH = 300.0f;
        lblH   = 30.0f;
        lblFSize = 26.0f;
        lblDSize = 24.0f;
        lblDY = 268.0f;
        imgW = size.width / 2;
    }
    
    if (self.contentView.frame.size.width < self.parentFrame.size.width){
        self.contentView.frame = self.parentFrame;
        NSLog(@"Adjusting HeaderImageCell Frame");
    }
    
    //Begin Blurry Background
    self.imageEstablishment = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 0, size.width, imgH)];
    [self.imageEstablishment setHidden:NO];
    [self.contentView addSubview:self.imageEstablishment];
    [self.contentView setBackgroundColor:[UIColor blackColor]];
    //End Blurry Background
    
    //Begin Circle Image
   // self.imageCircle = [[UIImageView alloc] initWithFrame:CGRectMake(size.width /2 - 50, 35.0, 120, 120)];
    self.imageCircle = [[UIImageView alloc] initWithFrame:self.imageEstablishment.frame];
    [self.imageCircle setImage:self.imageEstablishment.image];
    [self.imageCircle setHidden:NO];
    [self.contentView addSubview:self.imageCircle];
    //End Circle Image
    
    self.labelName = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, size.width, lblH)];
    [self.labelName setFont:[UIFont fontWithName:@"Avenir-Heavy" size:lblFSize]];
    [self.labelName setTextAlignment:NSTextAlignmentCenter];
    [self.labelName setNumberOfLines:1];
    [self.labelName setTextColor:[UIColor whiteColor]];
    [self.contentView addSubview:self.labelName];
    
    
    self.labeDetail = [[UILabel alloc] initWithFrame:CGRectMake(0.0, lblDY, size.width, lblH)];
    [self.labeDetail setFont:[UIFont fontWithName:@"Avenir-Heavy" size:lblDSize]];
    [self.labeDetail setTextAlignment:NSTextAlignmentCenter];
    [self.labeDetail setNumberOfLines:1];
    [self.labeDetail setTextColor:[UIColor whiteColor]];
    [self.contentView addSubview:self.labeDetail];
    
    [self.contentView setHidden:NO];
    [self.contentView.superview setBackgroundColor:[UIColor colorWithPatternImage:self.imageEstablishment.image]];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
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

@end
