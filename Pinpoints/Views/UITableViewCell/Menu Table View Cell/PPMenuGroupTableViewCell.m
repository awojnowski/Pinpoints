//
//  PPMenuGroupTableViewCell.m
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-26.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import "PPMenuGroupTableViewCell.h"

#import "PPGroup.h"

#import "UIImage+SolidColor.h"

@interface PPMenuGroupTableViewCell ()

@property (nonatomic, strong) UIButton *eyeButton;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *countLabel;

@property (nonatomic, strong) UIImageView *pinpointIconImageView;

@end

@implementation PPMenuGroupTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setDefaultBackgroundColor:[UIColor whiteColor]];
        [self setSelectedBackgroundColor:[UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.0]];
        
        UIButton *eyeButton = [[UIButton alloc] init];
        [eyeButton setImage:[[UIImage imageNamed:@"menuEyeButton"] convertedImageToColor:[PPColors tintColor]] forState:UIControlStateNormal];
        [[self contentView] addSubview:eyeButton];
        [self setEyeButton:eyeButton];
        
        UILabel *nameLabel = [[UILabel alloc] init];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [nameLabel setTextColor:[UIColor darkGrayColor]];
        [nameLabel setNumberOfLines:0];
        [nameLabel setFont:[UIFont systemFontOfSize:20.0]];
        [[self contentView] addSubview:nameLabel];
        [self setNameLabel:nameLabel];
        
        UIColor *countColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
        
        UIImageView *pinpointIconImageView = [[UIImageView alloc] init];
        [pinpointIconImageView setImage:[[UIImage imageNamed:@"pinpointIconImage"] convertedImageToColor:countColor]];
        [[self contentView] addSubview:pinpointIconImageView];
        [self setPinpointIconImageView:pinpointIconImageView];
        
        UILabel *countLabel = [[UILabel alloc] init];
        [countLabel setBackgroundColor:[UIColor clearColor]];
        [countLabel setTextColor:countColor];
        [countLabel setFont:[UIFont systemFontOfSize:12.0]];
        [[self contentView] addSubview:countLabel];
        [self setCountLabel:countLabel];
        
    }
    return self;
    
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    [[self eyeButton] setFrame:CGRectMake(10, 0, 44, CGRectGetHeight([[self contentView] frame]))];
    
    CGFloat textLabelWidth = CGRectGetWidth([[self contentView] frame]) - 10 - CGRectGetMaxX([[self eyeButton] frame]) - 10;
    CGFloat textX = CGRectGetMaxX([[self eyeButton] frame]) + 10;
    
    [[self nameLabel] setFrame:CGRectMake(0, 0, textLabelWidth, 0)];
    [[self nameLabel] sizeToFit];
    [[self nameLabel] setFrame:CGRectMake(textX, 10, CGRectGetWidth([[self nameLabel] frame]), CGRectGetHeight([[self nameLabel] frame]))];
    
    [[self pinpointIconImageView] setFrame:CGRectMake(textX, CGRectGetMaxY([[self nameLabel] frame]) + 4, 10, 15)];
    
    [[self countLabel] setFrame:CGRectMake(0, 0, textLabelWidth - 15, 0)];
    [[self countLabel] sizeToFit];
    [[self countLabel] setFrame:CGRectMake(textX + 15, CGRectGetMaxY([[self nameLabel] frame]) + 5, textLabelWidth - 15, CGRectGetHeight([[self countLabel] frame]))];
    
}

#pragma mark - Hiding and Showing

-(void)show:(id)sender {
    
    [[self group] setHiddenValue:NO];
    [self refreshEyeButton];
    
    if ([[self delegate] respondsToSelector:@selector(menuGroupTableViewCellDidShow:)])
        [[self delegate] menuGroupTableViewCellDidShow:self];
    
}

-(void)hide:(id)sender {
    
    [[self group] setHiddenValue:YES];
    [self refreshEyeButton];
    
    if ([[self delegate] respondsToSelector:@selector(menuGroupTableViewCellDidHide:)])
        [[self delegate] menuGroupTableViewCellDidHide:self];
    
}

-(void)refreshEyeButton {
    
    [[self eyeButton] removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    
    if ([[self group] hiddenValue]) {
        
        [[self eyeButton] setAlpha:0.25];
        [[self eyeButton] addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
        
    } else {
        
        [[self eyeButton] setAlpha:1.0];
        [[self eyeButton] addTarget:self action:@selector(hide:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    
}

#pragma mark - Getters & Setters

-(void)setGroup:(PPGroup *)group {
    
    _group = group;
    
    [self refreshEyeButton];
    
    [[self nameLabel] setText:[group name]];
    [[self countLabel] setText:[NSString stringWithFormat:@"%ld Pinpoint%@",[[group pinpoints] count],([[group pinpoints] count] == 1) ? @"" : @"s"]];
    
    [self layoutSubviews];
    
}

#pragma mark - Class Methods

+(CGFloat)heightForGroup:(PPGroup *)group {
    
    static UILabel *_label;
    if (!_label) {
        
        _label = [[UILabel alloc] init];
        [_label setNumberOfLines:0];
        
    }
    
    CGFloat height = 10.0;
    
    [_label setFont:[UIFont systemFontOfSize:20.0]];
    [_label setText:[group name]];
    [_label setFrame:CGRectMake(0, 0, 300, 0)];
    [_label sizeToFit];
    height += CGRectGetHeight([_label frame]);
    
    height += 5;
    
    [_label setFont:[UIFont systemFontOfSize:12.0]];
    [_label setText:@" "];
    [_label setFrame:CGRectMake(0, 0, 300, 0)];
    [_label sizeToFit];
    height += CGRectGetHeight([_label frame]);
    
    height += 10.0;
    
    return height;
    
}

@end
