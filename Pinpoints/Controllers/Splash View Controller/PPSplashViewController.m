//
//  PPSplashViewController.m
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-25.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import "PPSplashViewController.h"

#import "PPHomeViewController.h"

@interface PPSplashViewController ()

@property (nonatomic, strong) PPHomeViewController *homeViewController;

@end

@implementation PPSplashViewController

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[self view] setBackgroundColor:[UIColor whiteColor]];
    
    PPHomeViewController *homeViewController = [[PPHomeViewController alloc] init];
    [[self view] addSubview:[homeViewController view]];
    [self setHomeViewController:homeViewController];
    [self addChildViewController:homeViewController];
    
}

-(void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    [[[self homeViewController] view] setFrame:[[self view] bounds]];
    
}

@end
