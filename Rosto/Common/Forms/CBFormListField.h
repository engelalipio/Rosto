//
//  CBFormListField.h
//  ChaseBook
//
//  Created by Engel Alipio on 5/7/13.
//  Copyright (c) 2013 Engel Alipio. All rights reserved.
//

#import "CBFormFieldView.h"

@interface CBFormListField : CBFormFieldView

@property (nonatomic,strong) NSArray *values;
@property (nonatomic,assign) NSInteger selectedValueIndex;
@property (nonatomic,copy) void (^asynchronousLoadingOperation)(CBFormListField *currentField);

- (void)endAsynchronousLoadingOperationWithValues:(NSArray *)values;

@end
