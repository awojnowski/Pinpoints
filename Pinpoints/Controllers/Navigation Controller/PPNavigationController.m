//
//  PPNavigationController.m
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-25.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import "PPNavigationController.h"

@interface PPNavigationController ()

@end

@implementation PPNavigationController



#pragma mark - Class Methods

+(void)setupNavigationControllerStyles {
    
    Class class = [self class];
    [[UINavigationBar appearanceWhenContainedIn:class, nil] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }];
    [[UINavigationBar appearanceWhenContainedIn:class, nil] setBarTintColor:[UIColor whiteColor]];
    
}

@end
