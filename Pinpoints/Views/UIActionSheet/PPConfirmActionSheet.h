//
//  PPConfirmActionSheet.h
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-26.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPConfirmActionSheet : UIActionSheet

-(id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTile:(NSString *)destructiveButtonTitle;

// called when the destructive button is tapped
@property (nonatomic, copy) void (^confirmBlock)(void);

// called when the cancel button is tapped
@property (nonatomic, copy) void (^cancelBlock)(void);

@end
