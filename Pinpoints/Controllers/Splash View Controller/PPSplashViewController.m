//
//  PPSplashViewController.m
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-25.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import "PPSplashViewController.h"

#import "PPHomeViewController.h"
#import "PPNavigationController.h"

#import "PPGroup.h"

@interface PPSplashViewController ()

@property (nonatomic, strong) UIViewController *currentViewController;

@end

@implementation PPSplashViewController

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[self view] setBackgroundColor:[UIColor whiteColor]];
    
    [self performInitialSetup];
    
    PPHomeViewController *homeViewController = [[PPHomeViewController alloc] init];
    
    PPNavigationController *navigationController = [[PPNavigationController alloc] initWithRootViewController:homeViewController];
    [[self view] addSubview:[navigationController view]];
    [self addChildViewController:navigationController];
    [self setCurrentViewController:navigationController];
    
}

-(void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    [[[self currentViewController] view] setFrame:[[self view] frame]];
    
}

-(BOOL)shouldAutorotate {
    
    return NO;
    
}

#pragma mark - Setup

-(void)performInitialSetup {
    
    if ([[PPGroup allGroups] count] == 0) {
        
        NSLog(@"No groups have been created.  We are creating a default group now.");
        
        [PPGroup createGroupWithName:@"New Group"];
        NSLog(@"Here are all the groups after creation: %@",[PPGroup allGroups]);
        
    } else {
        
        NSLog(@"There is already a created group.  Not creating any default ones.");
        
    }
    
}

@end
