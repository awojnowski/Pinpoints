//
//  PPNavigationController.m
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-25.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import "PPNavigationController.h"
#import "PPViewController.h"

@interface PPNavigationController () <UINavigationControllerDelegate>

@end

@implementation PPNavigationController

-(id)initWithRootViewController:(UIViewController *)rootViewController {
    
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        
        [self setDelegate:self];
        
    }
    return self;
    
}

#pragma mark - UINavigationControllerDelegate

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([viewController isKindOfClass:[PPViewController class]]) {
        
        BOOL hideNavigationBar = [(PPViewController *)viewController prefersNavigationBarHidden];
        [self setNavigationBarHidden:hideNavigationBar animated:YES];
        
    }
    
}

#pragma mark - Class Methods

+(void)setupNavigationControllerStyles {
    
    Class class = [self class];
    [[UINavigationBar appearanceWhenContainedIn:class, nil] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }];
    [[UINavigationBar appearanceWhenContainedIn:class, nil] setBarTintColor:[UIColor whiteColor]];
    
}

@end
