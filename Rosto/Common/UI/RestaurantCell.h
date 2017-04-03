//
//  RestauranceCellTableViewCell.h
//  OrderMyTableNow
//
//  Created by Engel Alipio on 5/25/15.
//  Copyright (c) 2015 OrderMyTableNow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgRestaurant;
@property (strong, nonatomic) IBOutlet UILabel *lblRestaurantName;
@property (strong, nonatomic) IBOutlet UILabel *lblRestaurantArea;
@property (strong, nonatomic) IBOutlet UILabel *lblRestaurantPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblRestaurantDistance;

+ (id)instanceFromNib;
@end
