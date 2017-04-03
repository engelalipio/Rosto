//
//  DetailViewController.m
//  Rosto
//
//  Created by Engel Alipio on 5/26/16.
//  Copyright © 2017 Agile Mobile Solutions. All rights reserved.
//

#import "DetailViewController.h"
#import "MPODetectionViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    
    NSString *faceOption = @"";
    
    @try {
        
        if (self.detailItem) {
            faceOption = [self.detailItem description];
            
            if ([faceOption isEqualToString:@"Detection"]){
                [self performSegueWithIdentifier:@"segDetectDetail" sender:self];
            }
            
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        faceOption = @"";
    }
    

}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    MPODetectionViewController *detectionVC = nil;
    @try {
        
        if (segue.destinationViewController != nil){
        
            if ([segue.destinationViewController isKindOfClass:[MPODetectionViewController class]]){
                detectionVC = (MPODetectionViewController*) segue.destinationViewController;
                if (detectionVC){
                
                }
            }
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
