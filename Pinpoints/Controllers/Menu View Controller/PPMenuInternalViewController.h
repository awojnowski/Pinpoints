//
//  PPMenuInternalViewController.h
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-26.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import "PPMenuViewController.h"
#import "PPViewController.h"

@interface PPMenuInternalViewController : PPViewController

@property (nonatomic, weak) id <PPMenuViewControllerDelegate> delegate;
@property (nonatomic, weak) PPMenuViewController *menuViewController;

@end
