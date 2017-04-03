//
//  CBFormLineCell.m
//  ChaseBook
//
//  Created by Engel Alipio on 5/7/13.
//  Copyright (c) 2013 Engel Alipio. All rights reserved.
//

#import "CBFormLineCell.h"

#define kLineHeigtht		44
#define kLineHeigthtPadding 10
#define kWidhtProportion	100

@interface CBFormLineCell ()

@property (nonatomic, strong) IBOutlet UIView	*separator;
@property (nonatomic, strong) NSArray			*allFields;

@end

@implementation CBFormLineCell

- (void)awakeFromNib
{
	self.lineHeight = kLineHeigtht;
}

- (CBForm *)form
{
	return (CBForm *)self.superview;
}

- (void)setFields:(NSArray *)fields
{
	if (_fields != nil) {
		for (CBFormFieldView *field in _fields) {
			field.line = nil;
			[field removeFromSuperview];
		}
	}
    
	self.allFields = fields;
    
	// A line may include some fields only for displaying a description, so avoid adding them in the fields array
	NSMutableArray *actualFields = [NSMutableArray arrayWithCapacity:fields.count];
    
	for (CBFormFieldView *field in fields) {
		if (field.userInteractionEnabled == NO) {
			continue;
		}
        
		[actualFields addObject:field];
	}
    
	_fields = actualFields;
    
	for (CBFormFieldView *field in fields) {
		field.line = self;
		[self.contentView addSubview:field];
	}
    
	[self layoutSubviews];
}

- (void)layoutSubviews
{
	[super layoutSubviews];
    
	if (!self.avoidLayout) {
		if (self.allFields == nil) {
			return;
		}
        
		NSUInteger x = self.separator.right;// To take into account the separator
        
		if (self.separator.hidden && self.descriptionLabel.hidden) {
			x = 0;
		}
        
		NSUInteger startX = x;
        
		for (CBFormFieldView *field in self.allFields) {
			field.left		= x;
			field.width		= (field.widthProportionInLine * (self.contentView.width - startX)) / kWidhtProportion;
			field.height	= self.lineHeight;
            
			if ([self.allFields indexOfObject:field] < self.allFields.count - 1) {
				field.separatorView.hidden	= NO;
				field.separatorView.left	= field.width - field.separatorView.width;
				field.separatorView.height	= self.lineHeight;
			}
            
			x += field.width;
		}
	}
}

- (NSString *)description
{
	return self.descriptionLabel.text;
}

- (void)setDescription:(NSString *)description
{
	self.descriptionLabel.text = description;
	[self adjustSizeToFit];
}

- (void)reset
{
	for (CBFormFieldView *field in self.fields) {
		[field reset];
	}
}

- (void)adjustSizeToFit
{
	if (self.avoidHeightFix) {
		self.descriptionLabel.size = [self.descriptionLabel.text sizeWithFont:self.descriptionLabel.font constrainedToSize:CGSizeMake(self.contentView.width, self.descriptionLabel.height)];
	} else {
		CGPoint descriptionOrigin	= self.descriptionLabel.frame.origin;
		CGSize	descriptionSize		= [self.descriptionLabel.text sizeWithFont:self.descriptionLabel.font constrainedToSize:CGSizeMake(self.descriptionLabel.width, INT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        
		/*self.descriptionLabel.frame.origin.y	= descriptionOrigin.y;
		self.descriptionLabel.frame.size	= CGSizeMake(self.descriptionLabel.width, descriptionSize.height);
        
		self.lineHeight = self.descriptionLabel.bottom + kLineHeigthtPadding;
		self.height		= self.lineHeight;*/
	}
}

- (void)setStyle:(CBFormLineStyle)style
{
	if (style == _style) {
		return;
	}
    
	_style = style;
    
	if (style == CBFormLineStyleDefault) {
		self.descriptionLabel.textColor = [UIColor grayColor];
		self.separator.hidden			= NO;
	} else if (style == CBFormLineStyleNoDescription) {
		self.descriptionLabel.hidden	= YES;
		self.separator.hidden			= YES;
	} else if (style == CBFormLineStyleNoSeparator) {
		self.descriptionLabel.hidden	= NO;
		self.separator.hidden			= YES;
		self.descriptionLabel.textColor = [UIColor blackColor];
	}
    
	[self layoutSubviews];
}

@end
