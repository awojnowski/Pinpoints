//
//  PPPinpointViewController.h
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-26.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import "PPViewController.h"

@class PPPinpoint;

@protocol PPPinpointViewControllerDelegate;

@interface PPPinpointViewController : PPViewController

@property (nonatomic, strong) id <PPPinpointViewControllerDelegate> delegate;

@property (nonatomic, strong) PPPinpoint *pinpoint;

@property (nonatomic, assign) BOOL focusNameFieldOnView;

@end

@protocol PPPinpointViewControllerDelegate <NSObject>

@optional
-(void)pinpointViewControllerDidViewPinpointOnMap:(PPPinpointViewController *)pinpointViewController;

@end
