//
//  PPMenuTableview.h
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-26.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PPPinpoint;

@protocol PPMenuTableViewDelegate;

@interface PPMenuTableView : UITableView

@property (nonatomic, weak) id <PPMenuTableViewDelegate> menuDelegate;

@end

@protocol PPMenuTableViewDelegate <NSObject>

@optional
-(void)menuTableView:(PPMenuTableView *)menuTableView didViewPinpoint:(PPPinpoint *)pinpoint;
-(void)menuTableViewDidUpdateVisibleGroups:(PPMenuTableView *)menuTableView;

@end
