//
//  CBReusableMethods.m
//  ChaseBook
//
//  Created by Luciano Castro on 5/22/13.
//  Copyright (c) 2013 Luciano Castro. All rights reserved.
//

#import "CBReusableMethods.h"
//#import "HPCDataModels.h"
#import "Constants.h"
#import "AppDelegate.h"

#define kCoverImageTag 101201

@implementation CBReusableMethods

+ (NSArray *)getAesAsCBLookUpModel:(NSArray *)usersArray
{
    NSMutableArray * arr = [NSMutableArray new];
    
    // Ugly: Add a fake "ALL" entry for the seatch filter
  /*  [arr addObject:[HPCLookupModel lookupModelWithParamId:@"ALL" paramDisplayValue:@"All"]];
    
       
    if(!arr.count)
    {
        [arr addObject:[HPCLookupModel lookupModelWithParamId:@"ALL" paramDisplayValue:@"All"]];
    }*/
    
    return arr;
}

+ (NSArray *)getCustmAsCBLookUpModel:(NSArray *) custArray
{
    return [self getCustmAsCBLookUpModel:custArray insertAllValue:YES];
}

+ (NSArray *)getCustmAsCBLookUpModel:(NSArray *)custArray insertAllValue:(BOOL)insertAllValue
{
    NSMutableArray * arr = [NSMutableArray new];
    
         return arr;
}

+ (NSArray *)getPaginatedCustmAsCBLookUpModel:(NSArray *)custArray insertAllValue:(BOOL)insertAllValue
{
    NSMutableArray * arr = [NSMutableArray new];
    
    // Ugly: Add a fake "ALL" entry for the seatch filter
  /*  if (insertAllValue)
        [arr addObject:[HPCLookupModel lookupModelWithParamId:@"ALL" paramDisplayValue:@"All"]];
    
    */
    return arr;
}

+ (NSArray *)getProspectAsCBLookUpModel:(NSArray *)prospectsArray
{
    NSMutableArray *arr = [NSMutableArray new];
    
         return arr;
}

+ (NSArray *)getMsaAsCBLookUpModel:(NSArray *)msaArray
{
    NSMutableArray *arr = [NSMutableArray new];
    
//    [arr addObject:[CBLookupModel lookupModelWithParamId:@"All" paramDisplayValue:@"All"]];

    
    return arr;
}

+ (NSString *)getValidationErrorMessageFromArray:(NSArray *)arr
{
    NSMutableString * concatstr = [NSMutableString new];
    for (NSString* str in arr)
    {
        [concatstr appendFormat:@"%@\n", str];
    }
    
    return concatstr;
}

+ (void) showCommentAddedAlertView
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message"
                                                      message:@"Your comment has been added"
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [alert show];
}

+ (void) showErrorAlertViewWithMessage:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                      message:message
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [alert show];
}

+ (void)showGenericAlertWithMessage:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message: message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

+(void)addCoverImage
{
    
    AppDelegate *delegate = [AppDelegate currentDelegate];
    UIImageView *coverImage = [[UIImageView alloc] initWithFrame:delegate.window.frame];
    coverImage.image = [UIImage imageNamed:@"Default.png"];
    coverImage.tag = kCoverImageTag;
    [[[[[UIApplication sharedApplication] keyWindow] subviews] lastObject] addSubview:coverImage];
    
}

+(void)removeCoverImage
{
    UIView *coverImage = [[[UIApplication sharedApplication] keyWindow] viewWithTag:kCoverImageTag];
    if (coverImage) {
        [coverImage removeFromSuperview];        
    }
}

+ (BOOL) isErrorInInsertResponse:(id) response
{
    NSDecimalNumber *dec = (NSDecimalNumber*)response;
    
    if ([dec isEqualToNumber:[NSNumber numberWithInt:-1]])
        return YES;
    
    return NO;

}

@end
