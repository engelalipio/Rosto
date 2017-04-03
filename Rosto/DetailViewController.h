//
//  DetailViewController.h
//  Rosto
//
//  Created by Engel Alipio on 5/26/16.
//  Copyright © 2017 Agile Mobile Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

