//
//  PPChooseGroupActionSheet.h
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-27.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PPGroup;

@interface PPChooseGroupActionSheet : UIActionSheet

-(id)initWithGroups:(NSArray *)groups;

@property (nonatomic, readonly, strong) NSArray *groups;
@property (nonatomic, strong) void (^chosenBlock)(PPGroup *group);

@end
