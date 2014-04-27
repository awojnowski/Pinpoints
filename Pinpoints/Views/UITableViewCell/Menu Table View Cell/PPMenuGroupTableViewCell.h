//
//  PPMenuGroupTableViewCell.h
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-26.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import "PPBackgroundTableViewCell.h"

@class PPGroup;

@protocol PPMenuGroupTableViewCellDelegate;

@interface PPMenuGroupTableViewCell : PPBackgroundTableViewCell

@property (nonatomic, weak) id <PPMenuGroupTableViewCellDelegate> delegate;

@property (nonatomic, strong) PPGroup *group;

+(CGFloat)heightForGroup:(PPGroup *)group;

@end

@protocol PPMenuGroupTableViewCellDelegate <NSObject>

@optional
-(void)menuGroupTableViewCellDidShow:(PPMenuGroupTableViewCell *)menuGroupTableViewCell;
-(void)menuGroupTableViewCellDidHide:(PPMenuGroupTableViewCell *)menuGroupTableViewCell;

@end
