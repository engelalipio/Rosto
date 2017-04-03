//
//  CBFormPickerViewController.h
//  ChaseBook
//
//  Created by Engel Alipio on 5/7/13.
//  Copyright (c) 2013 Engel Alipio. All rights reserved.
//

#import <UIKit/UIKit.h>

enum CBFormPickerState
{
    CBFormPickerStateLoading,
    CBFormPickerStateReady
} ;

typedef int CBFormPickerState;

@interface CBFormPickerViewController : UIViewController

@property (nonatomic,weak) id<UIPickerViewDelegate> pickerViewDelegate;
@property (nonatomic,strong) NSArray *values;
@property (nonatomic,readonly) BOOL pickerViewTap;
@property (nonatomic,assign) CBFormPickerState state;

- (void)reloadAllComponents;
- (void)selectRow:(NSInteger)row animated:(BOOL)animated;
- (NSString *)displayTextAtRow:(NSInteger)row;
- (id)valueAtRow:(NSInteger)row;
- (IBAction)onPickerViewTap:(UITapGestureRecognizer *)tap;

@end
