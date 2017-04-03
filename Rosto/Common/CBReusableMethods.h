//
//  CBReusableMethods.h
//  ChaseBook
//
//  Created by Luciano Castro on 5/22/13.
//  Copyright (c) 2013 Luciano Castro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBReusableMethods : NSObject

+ (NSArray *)getCustmAsCBLookUpModel:(NSArray*) custArray;
+ (NSArray *)getCustmAsCBLookUpModel:(NSArray*) custArray insertAllValue:(BOOL)insertAllValue;
+ (NSArray *)getPaginatedCustmAsCBLookUpModel:(NSArray*) custArray insertAllValue:(BOOL)insertAllValue;
+ (NSArray *)getAesAsCBLookUpModel: (NSArray*)usersArray;
+ (NSArray *)getProspectAsCBLookUpModel:(NSArray *)prospectsArray;
+ (NSArray *)getMsaAsCBLookUpModel:(NSArray *)msaArray;
+ (NSString*)getValidationErrorMessageFromArray:(NSArray *)arr;
+ (void)showGenericAlertWithMessage:(NSString*)message;
+ (void) showCommentAddedAlertView;
+ (void) showErrorAlertViewWithMessage:(NSString*)message;
+ (BOOL) isErrorInInsertResponse:(id) response;

@end