//
//  PPMenuViewController.m
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-26.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import "PPMenuViewController.h"
#import "PPMenuInternalViewController.h"

@interface PPMenuViewController ()

@end

@implementation PPMenuViewController

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    PPMenuInternalViewController *menuInternalViewController = [[PPMenuInternalViewController alloc] init];
    [menuInternalViewController setDelegate:[self menuDelegate]];
    [menuInternalViewController setMenuViewController:self];
    [self setViewControllers:@[menuInternalViewController]];
    
}

-(void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    
    
}

@end
