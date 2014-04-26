//
//  PPMenuGroupTableViewCell.h
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-26.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import "PPBackgroundTableViewCell.h"

@class PPGroup;

@interface PPMenuGroupTableViewCell : PPBackgroundTableViewCell

@property (nonatomic, strong) PPGroup *group;

+(CGFloat)heightForGroup:(PPGroup *)group;

@end