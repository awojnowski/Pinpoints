//
//  PPBackgroundTableViewCell.h
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-26.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PPBackgroundTableViewCellDelegate;

@interface PPBackgroundTableViewCell : UITableViewCell

@property (nonatomic, weak) id <PPBackgroundTableViewCellDelegate> backgroundDelegate;

@property (nonatomic, strong) UIColor *defaultBackgroundColor;
@property (nonatomic, strong) UIColor *selectedBackgroundColor;

@end

@protocol PPBackgroundTableViewCellDelegate <NSObject>

@required
-(void)backgroundTableViewCell:(PPBackgroundTableViewCell *)tableViewCell willChangeToBackgroundColor:(UIColor *)color;

@end
