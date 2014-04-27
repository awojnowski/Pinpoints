//
//  PPMenuViewController.h
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-26.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import "PPNavigationController.h"

@class PPPinpoint;

@protocol PPMenuViewControllerDelegate;

@interface PPMenuViewController : PPNavigationController

@property (nonatomic, weak) id <PPMenuViewControllerDelegate> menuDelegate;

@end

@protocol PPMenuViewControllerDelegate <NSObject>

@optional
-(void)menuViewControllerDidClose:(PPMenuViewController *)menuViewController;
-(void)menuViewController:(PPMenuViewController *)menuViewController didViewPinpoint:(PPPinpoint *)pinpoint;
-(void)menuViewControllerDidUpdateVisibleGroups:(PPMenuViewController *)menuViewController;

@end
