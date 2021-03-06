//
//  ItemViewController.m
//  DropDownDigitalMenus
//
//  Created by Engel Alipio on 11/9/14.
//  Copyright (c) 2014 Digital World International. All rights reserved.
//
#import "Constants.h"
#import "ItemViewController.h"
#import "NumberFormatter.h"
#import "AppDelegate.h"
#import "itemModel.h"

@interface ItemViewController ()
{
    float originalPrice;
    NSString *originalDesc,
             *originalPriceDesc;
    AppDelegate *appDelegate;
    
    UIInterfaceOrientation currentOrientation;
    
    BOOL isFirstLaunch;
}
-(void) configureView;

@end

@implementation ItemViewController

@synthesize foodType = _foodType;
@synthesize entreeType = _entreeType;

-(void) configureView{
    
    CGRect imageRect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    [self.imageView setFrame:imageRect];

}

-(void) setDrinkOptionsVisible:(BOOL) display{
    
    NSString *title = self.labelTitle.text;
    NSRange  range;
    BOOL hide = YES;
    
    [self.iceSeg setHidden:hide];
    [self.sweetSeg setHidden:hide];
    [self.lemonSeg setHidden:hide];
    [self.softDrinks setHidden:hide];
    
    hide = (display ? NO : YES);
    
    [self.iceSeg setHidden:hide];

    
    if (! hide){
        range = [title.uppercaseString rangeOfString:@"TEA"];
        if (range.location != NSNotFound){
         [self.sweetSeg setHidden:hide];
         [self.lemonSeg setHidden:hide];
        }
        range = [title.uppercaseString rangeOfString:@"DRINKS"];
        if (range.location != NSNotFound){
           [self.softDrinks setHidden:hide];
        }
        range = [title.uppercaseString rangeOfString:@"LIMONADA"];
        if (range.location != NSNotFound){
            [self.sweetSeg setHidden:hide];
            [self.lemonSeg setHidden:hide];
        }
        range = [title.uppercaseString rangeOfString:@"LEMONADE"];
        if (range.location != NSNotFound){
            [self.sweetSeg setHidden:hide];
            [self.lemonSeg setHidden:hide];
        }
    }

}

-(void)addCalories{
    NSString *cal  =  @"%d calories";
    
    NSInteger calories =  arc4random_uniform(450);
    
    cal = [NSString stringWithFormat:cal,calories];
    [self.labelCalories setTextColor:[UIColor whiteColor]];
    [self.labelCalories setText:cal];
   /* [self.labelDescription setText:cal ];
    [self.labelCalories setHidden:YES];*/
    
}

-(void)setAppsVisible:(BOOL) display{
    [self.gluttenFreeLabel setHidden:!display];
    [self.gluttenFreeSwitch setHidden:! display];
}

-(void)setSoupsVisible:(BOOL) display{
    [self.gluttenFreeLabel setHidden:!display];
    [self.gluttenFreeSwitch setHidden:! display];
    [self.cheeseTypeSeg setHidden:! display];
}

-(void)setSaladsVisible:(BOOL) display{
    [self.dressingTypeSeg setHidden:! display];
    [self.cheeseTypeSeg setHidden:! display];
    [self.gluttenFreeLabel setHidden:!display];
    [self.gluttenFreeSwitch setHidden:! display];
}

-(void) setMeatsVisible:(BOOL) display{
    [self.steakSeg setHidden:! display];
    [self.cheeseTypeSeg setHidden:! display];
    [self.sidesSeg setHidden:! display];
}

-(void)setChickensVisible:(BOOL) display{
    [self.sauceTypeSeg setHidden:! display];
    [self.sidesSeg setHidden:! display];
}

-(void)setSeaFoodsVisible:(BOOL) display{
    [self.sauceTypeSeg setHidden:! display];
    [self.sidesSeg setHidden:! display];
}

-(void) setPastasVisible:(BOOL) display{
    [self.pastaSeg setHidden:! display];
    [self.gluttenFreeLabel setHidden:!display];
    [self.gluttenFreeSwitch setHidden:! display];
    [self.sauceTypeSeg setHidden:! display];
    [self.sidesSeg setHidden:! display];
    [self.cheeseTypeSeg setHidden:! display];
}

-(void) setDesserts:(BOOL) display{
    [self.gluttenFreeLabel setHidden:!display];
    [self.gluttenFreeSwitch setHidden:! display];
}

-(void) configureSegs{
    
    [self setDrinkOptionsVisible:NO];
    [self setAppsVisible:NO];
    [self setSoupsVisible:NO];
    [self setSaladsVisible:NO];
    [self setMeatsVisible:NO];
    [self setChickensVisible:NO];
    [self setSeaFoodsVisible:NO];
    [self setDesserts:NO];

    switch (self.foodType) {
        case Beverage:
            [self setDrinkOptionsVisible:YES];
            break;
        case Appetizer:
            [self setAppsVisible:YES];
            break;
        case Soups:
            [self setSoupsVisible:YES];
            break;
        case Salads:
            [self setSaladsVisible:YES];
            break;
        case Entrees:
            
            switch (self.entreeType) {
                case Beef:
                    [self setMeatsVisible:YES];
                    break;
                case Chicken:
                    [self setChickensVisible:YES];
                    break;
                case Seafood:
                    [self setSeaFoodsVisible:YES];
                    break;
                case Pasta:
                    [self setPastasVisible:YES];
                    break;
            }
            
            break;
        case Desserts:
            [self setDesserts:YES];
            break;
    }
    
    if (! appDelegate.currentOrderItems && ! appDelegate.reservations ){
        [self.lblDescription setHidden:YES];
        [self.labelQuantity setHidden:YES];
        [self.itemStepper setHidden:YES];
        [self.addToOrderButton setHidden:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    originalPrice = 0.0f;
    [self.itemStepper setValue:1];
    
    [self.addToOrderButton.layer setCornerRadius:4.0f];
    [self.labelPrice.layer setCornerRadius:4.0f];
    [self.itemStepper.layer setCornerRadius:4.0f];
    [self.labelQuantity.layer setCornerRadius:4.0f];
    [self.backButton.layer setCornerRadius:4.0f];
    [self.labelCalories.layer setCornerRadius:4.0f];
    [self.labelCalories .layer setBorderWidth:1.0f];
    [self.labelCalories.layer setBorderColor:self.labelCalories.backgroundColor.CGColor];
    if (! appDelegate){
        appDelegate = [AppDelegate currentDelegate];
    }
    
    // Do any additional setup after loading the view from its nib.
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self configureSegs];
    [self extractOriginalPrice];
    [self addCalories];
}

-(void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [self setDrinkOptionsVisible:NO];
    [self setAppsVisible:NO];
    [self setSoupsVisible:NO];
    [self setSaladsVisible:NO];
    [self setMeatsVisible:NO];
    [self setChickensVisible:NO];
    [self setSeaFoodsVisible:NO];
    [self setDesserts:NO];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   
}


- (IBAction)cancelOrder:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)addToOrderAction:(UIButton *)sender {
    
    NSString *message   = @"";
    
    NSInteger orderItems = 0,
              quantity   = 0;
    
    NSMutableDictionary *items = nil,
                                        *eItems = nil;
    
    NSMutableArray *itemOptions = nil;
    
    itemModel *currentItem = nil;
    
    @try {
        
        orderItems = [appDelegate currentOrderItems];
        
       // quantity   =  [self.labelQuantity.text integerValue];
        quantity = 1;
        if (! orderItems){
            orderItems =  quantity;
        }else{
            orderItems = orderItems + quantity ;
        }
        message = [NSString stringWithFormat:@"%ld order item(s)", (long)orderItems];
    
        currentItem = [[itemModel alloc] init];
        
        [currentItem setTitle:self.labelTitle.text];
        [currentItem setDescription:self.labelDescription.text];
        [currentItem setPrice:self.labelPrice.text];
        [currentItem setQuantity:self.labelQuantity.text];
        [currentItem setImage:self.imageView.image];
        [currentItem setCalories:self.labelCalories.text];
        
        items = [[NSMutableDictionary alloc] init];
        itemOptions = [[NSMutableArray alloc] init];
        
        NSString *uuid = [[NSUUID UUID] UUIDString];
        
        switch (self.foodType) {
            case Beverage:
                [currentItem setCategory:@"Beverages"];
                
                if ([appDelegate drinkItems]){
                    eItems = [appDelegate drinkItems];
                    NSMutableArray *existingItems = [eItems objectForKey:currentItem.Category];
                    if (existingItems){
                        [existingItems addObject:currentItem];
                        [items setValue:existingItems forKey:currentItem.Category];
                    }
                }else{
                    NSMutableArray *existingItems =  [[NSMutableArray alloc ] initWithObjects:currentItem, nil];
                    [items setValue:existingItems forKey:currentItem.Category];
                }
            
                if (! self.softDrinks.isHidden){
                    [itemOptions addObject:[self.softDrinks titleForSegmentAtIndex:self.softDrinks.selectedSegmentIndex]];
                }
                
                if (! self.lemonSeg.isHidden){
                    [itemOptions addObject:[self.lemonSeg titleForSegmentAtIndex:self.lemonSeg.selectedSegmentIndex]];
                }
                
                if (! self.sweetSeg.isHidden){
                    [itemOptions addObject:[self.sweetSeg titleForSegmentAtIndex:self.sweetSeg.selectedSegmentIndex]];
                }
                
                if (! self.iceSeg.isHidden){
                    [itemOptions addObject:[self.iceSeg titleForSegmentAtIndex:self.iceSeg.selectedSegmentIndex]];
                }
                
                [currentItem setOptions:[[NSArray alloc] initWithArray:itemOptions]];
                
                [appDelegate setDrinkItems:items];
                
                
                break;
            case Appetizer:
                [currentItem setCategory:@"Appetizers"];
                
                if ([appDelegate appItems]){
                    eItems = [appDelegate appItems];
                    NSMutableArray *existingItems = [eItems objectForKey:currentItem.Category];
                    if (existingItems){
                        [existingItems addObject:currentItem];
                        [items setValue:existingItems forKey:currentItem.Category];
                    }
                }else{
                    NSMutableArray *existingItems =  [[NSMutableArray alloc ] initWithObjects:currentItem, nil];
                    [items setValue:existingItems forKey:currentItem.Category];
                }
                
                if (! self.gluttenFreeSwitch.isHidden && ! self.gluttenFreeLabel.isHidden){
                    if (self.gluttenFreeSwitch.isOn){
                        [itemOptions addObject:self.gluttenFreeLabel.text];
                    }
                }
                [currentItem setOptions:[[NSArray alloc] initWithArray:itemOptions]];
                [appDelegate setAppItems:items];
                break;
            case Soups:
                [currentItem setCategory:@"Soups"];

                if ([appDelegate soupItems]){
                    eItems = [appDelegate soupItems];
                    NSMutableArray *existingItems = [eItems objectForKey:currentItem.Category];
                    if (existingItems){
                        [existingItems addObject:currentItem];
                        [items setValue:existingItems forKey:currentItem.Category];
                    }
                }else{
                    NSMutableArray *existingItems =  [[NSMutableArray alloc ] initWithObjects:currentItem, nil];
                    [items setValue:existingItems forKey:currentItem.Category];
                }
                
                if (! self.gluttenFreeSwitch.isHidden && ! self.gluttenFreeLabel.isHidden){
                    if (self.gluttenFreeSwitch.isOn){
                        [itemOptions addObject:self.gluttenFreeLabel.text];
                    }
                }
                
                if (!self.cheeseTypeSeg.isHidden){
                    [itemOptions addObject:[self.cheeseTypeSeg titleForSegmentAtIndex:self.cheeseTypeSeg.selectedSegmentIndex]];
                }
                
                [currentItem setOptions:[[NSArray alloc] initWithArray:itemOptions]];
                

                [appDelegate setSoupItems:items];
                break;
            case Salads:
                [currentItem setCategory:@"Salads"];

                if ([appDelegate saladItems]){
                    eItems = [appDelegate saladItems];
                    NSMutableArray *existingItems = [eItems objectForKey:currentItem.Category];
                    if (existingItems){
                        [existingItems addObject:currentItem];
                        [items setValue:existingItems forKey:currentItem.Category];
                    }
                }else{
                    NSMutableArray *existingItems =  [[NSMutableArray alloc ] initWithObjects:currentItem, nil];
                    [items setValue:existingItems forKey:currentItem.Category];
                }
                
                if (! self.gluttenFreeSwitch.isHidden && ! self.gluttenFreeLabel.isHidden){
                    if (self.gluttenFreeSwitch.isOn){
                        [itemOptions addObject:self.gluttenFreeLabel.text];
                    }
                }
                
                if (!self.dressingTypeSeg.isHidden){
                    [itemOptions addObject:[self.dressingTypeSeg titleForSegmentAtIndex:self.dressingTypeSeg.selectedSegmentIndex]];
                }
                
                if (!self.cheeseTypeSeg.isHidden){
                    [itemOptions addObject:[self.cheeseTypeSeg titleForSegmentAtIndex:self.cheeseTypeSeg.selectedSegmentIndex]];
                }
                
                [currentItem setOptions:[[NSArray alloc] initWithArray:itemOptions]];
                
    
                [appDelegate setSaladItems:items];
                break;
            case Entrees:
                [currentItem setCategory:@"Entrees"];

                if ([appDelegate entreeItems]){
                    eItems = [appDelegate entreeItems];
                    NSMutableArray *existingItems = [eItems objectForKey:currentItem.Category];
                    if (existingItems){
                        [existingItems addObject:currentItem];
                        [items setValue:existingItems forKey:currentItem.Category];
                    }
                }else{
                    NSMutableArray *existingItems =  [[NSMutableArray alloc ] initWithObjects:currentItem, nil];
                    [items setValue:existingItems forKey:currentItem.Category];
                }
                
                switch (self.entreeType) {
                    case Beef:
                        
                        
                        if (!self.steakSeg.isHidden){
                            [itemOptions addObject:[self.steakSeg titleForSegmentAtIndex:self.steakSeg.selectedSegmentIndex]];
                        }
                        
                        if (!self.cheeseTypeSeg.isHidden){
                            [itemOptions addObject:[self.cheeseTypeSeg titleForSegmentAtIndex:self.cheeseTypeSeg.selectedSegmentIndex]];
                        }
                        
                        if (!self.sidesSeg.isHidden){
                            [itemOptions addObject:[self.sidesSeg titleForSegmentAtIndex:self.sidesSeg.selectedSegmentIndex]];
                        }
                        
                        [currentItem setOptions:[[NSArray alloc] initWithArray:itemOptions]];
                        
                        
                        break;
                    case Chicken:
                    case Seafood:
                        
                        if (!self.sauceTypeSeg.isHidden){
                            [itemOptions addObject:[self.sauceTypeSeg titleForSegmentAtIndex:self.sauceTypeSeg.selectedSegmentIndex]];
                        }
                        
                        if (!self.sidesSeg.isHidden){
                            [itemOptions addObject:[self.sidesSeg titleForSegmentAtIndex:self.sidesSeg.selectedSegmentIndex]];
                        }
                        
                        [currentItem setOptions:[[NSArray alloc] initWithArray:itemOptions]];
                        
                        break;
                    case Pasta:
                        
                        if (! self.gluttenFreeSwitch.isHidden && ! self.gluttenFreeLabel.isHidden){
                            if (self.gluttenFreeSwitch.isOn){
                                [itemOptions addObject:self.gluttenFreeLabel.text];
                            }
                        }
                        
                        if (!self.pastaSeg.isHidden){
                            [itemOptions addObject:[self.pastaSeg titleForSegmentAtIndex:self.pastaSeg.selectedSegmentIndex]];
                        }
                        
                        if (!self.sauceTypeSeg.isHidden){
                            [itemOptions addObject:[self.sauceTypeSeg titleForSegmentAtIndex:self.sauceTypeSeg.selectedSegmentIndex]];
                        }
                        
                        if (!self.cheeseTypeSeg.isHidden){
                            [itemOptions addObject:[self.cheeseTypeSeg titleForSegmentAtIndex:self.cheeseTypeSeg.selectedSegmentIndex]];
                        }

                        if (!self.sidesSeg.isHidden){
                            [itemOptions addObject:[self.sidesSeg titleForSegmentAtIndex:self.sidesSeg.selectedSegmentIndex]];
                        }
                        
                       [currentItem setOptions:[[NSArray alloc] initWithArray:itemOptions]];

                        break;
                }
                


                [appDelegate setEntreeItems:items];
                break;
            case Desserts:
                [currentItem setCategory:@"Desserts"];

                if ([appDelegate dessertItems]){
                    eItems = [appDelegate dessertItems];
                    NSMutableArray *existingItems = [eItems objectForKey:currentItem.Category];
                    if (existingItems){
                        [existingItems addObject:currentItem];
                        [items setValue:existingItems forKey:currentItem.Category];
                    }
                }else{
                    NSMutableArray *existingItems =  [[NSMutableArray alloc ] initWithObjects:currentItem, nil];
                    [items setValue:existingItems forKey:currentItem.Category];
                }
                
                if (! self.gluttenFreeSwitch.isHidden && ! self.gluttenFreeLabel.isHidden){
                    if (self.gluttenFreeSwitch.isOn){
                        [itemOptions addObject:self.gluttenFreeLabel.text];
                    }
                }
                
                [appDelegate setDessertItems:items];
                break;
        }
        
        [appDelegate setCurrentOrderItems:orderItems];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    
    }
    @catch (NSException *exception) {
        message = [exception description];
    }
    @finally {
        
        orderItems = 0;
        if ([message length] > 0){
            NSLog(@"%@",message);
        }
        message = @"";
    }
    
}

-(void) extractOriginalPrice{
    
    NSString *message  = @"";
    
    float    price     = 0.0f;
    
    NSRange range ;
    @try {
        

        range = [self.labelPrice.text rangeOfString:@"$"];
        
        if ( range.location != NSNotFound){
            price = [[self.labelPrice.text substringFromIndex:1] floatValue];
            originalPriceDesc = self.labelPrice.text;
        }
        
        originalPrice = price;
        originalDesc  = self.labelDescription.text;
        
    }
    @catch (NSException *exception) {
        message = [exception description];
    }
    @finally {
        message = @"";
        price   = 0.0f;
    }
    
}

- (IBAction)stepperAction:(UIStepper *)sender {
    
    NSString *message    = @"";
    
    int   quantity       = 1;
    
    float price          = 0;
    
    NSRange range ;
    
    NumberFormatter *formatter = nil;
    
    NSNumber *numberPrice = nil;
    
    @try {
        
        if (originalPrice == 0.0f){
            [self extractOriginalPrice];
        }
    
        
        quantity = self.itemStepper.value;
        
    
        range = [self.labelPrice.text rangeOfString:@"$"];
        
        if ( range.location != NSNotFound){
            price = [[self.labelPrice.text substringFromIndex:1] floatValue];
            
        }
        
        if (quantity <= 0){
            quantity = 1;
        }
        
        price = originalPrice * quantity;
        
        [self.labelQuantity setText:[NSString stringWithFormat:@"%d",quantity]];
        
        formatter = [NumberFormatter currencyFormatterWithDecimalDigitsCount:2];
        
        numberPrice =  [[NSNumber alloc] initWithFloat:price];
        
        [self.labelPrice setText:[formatter stringFromValue:numberPrice]];
        
        
    }
    @catch (NSException *exception) {
        message = [exception description];
    }
    @finally {
        
    }
    
}



-(void) viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    UIInterfaceOrientation anyOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (! isFirstLaunch ){
        [self setupViewForOrientation:anyOrientation];
        isFirstLaunch = YES;
    }else{
        if (anyOrientation != currentOrientation){
            [self setupViewForOrientation:anyOrientation];
        }
    }
    
}

/*
-(void) configureImageAndBorderView{
    
    if  (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)){
        CGRect imageRect = CGRectMake(0, 53,1024, 312),
        borderRect = CGRectMake(0, 53,1024, 317);
        [self.imageView setFrame:imageRect];
        [self.imageBorderLabel setFrame:borderRect];
        
    }
}*/

-(void) setupViewForOrientation:(UIInterfaceOrientation) anyOrientation{
    
    NSString *message = @"";
    
    @try {
        
        switch (anyOrientation) {
            case UIInterfaceOrientationLandscapeLeft:
            case UIInterfaceOrientationLandscapeRight:
                message = kItemViewLandscape;
                
                break;
            default:
                //Portrait
                message = kItemViewPortrait;
                
                if (appDelegate.screenHeight == 736){
                    message =  kItemViewiPhone6PlusPortrait;
                }
                
                if (! appDelegate.isIPhone){
                    message = kItemViewPortrait_iPad;
                }
                
                break;
        }
        
        
        self.view = [[NSBundle mainBundle] loadNibNamed:message owner:self options:nil][0];
        
        currentOrientation = anyOrientation;
        
        
        
    }
    @catch (NSException *exception) {
        message = exception.description;
    }
    @finally {
        if (message.length > 0){
            NSLog(@"%@",message);
        }
        message = @"";
    }
}

- (BOOL) shouldAutorotate{
    //return no to prevent mid rotation change at this modal
    return NO;
}

@end
