//
//  CBFormLineCell.h
//  ChaseBook
//
//  Created by Engel Alipio on 5/7/13.
//  Copyright (c) 2013 Engel Alipio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBFormFieldView.h"
#import "UIView+Additions.h"

enum CBFormLineStyle {
	CBFormLineStyleDefault,
	CBFormLineStyleNoSeparator,
	CBFormLineStyleNoDescription
};

typedef int CBFormLineStyle;

@class CBForm;

@interface CBFormLineCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;

@property (nonatomic, strong) NSArray			*fields;
@property (nonatomic, strong) NSString			*description;
@property (nonatomic, readonly) CBForm			*form;
@property (nonatomic, assign) CGFloat			lineHeight;
@property (nonatomic, assign) CBFormLineStyle	style;
@property (strong, nonatomic) IBOutlet UILabel *lblValidationAsterisk;

@property (nonatomic, assign) BOOL	avoidLayout;
@property (nonatomic, assign) BOOL	avoidHeightFix;

- (void)reset;

@end
