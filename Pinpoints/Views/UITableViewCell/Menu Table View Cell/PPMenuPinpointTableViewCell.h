//
//  PPMenuPinpointTableViewCell.h
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-26.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import "PPBackgroundTableViewCell.h"

@class PPPinpoint;

@interface PPMenuPinpointTableViewCell : PPBackgroundTableViewCell

@property (nonatomic, strong) UILabel *nameLabel;

+(CGFloat)heightForPinpoint(PPPinpoint *)pinpint;

@end
