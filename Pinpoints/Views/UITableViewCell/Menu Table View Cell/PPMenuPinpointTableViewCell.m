//
//  PPMenuPinpointTableViewCell.m
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-26.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import "PPMenuPinpointTableViewCell.h"

#import "PPPinpoint.h"

@interface PPMenuPinpointTableViewCell ()

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation PPMenuPinpointTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *nameLabel = [[UILabel alloc] init];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [nameLabel setTextColor:[UIColor grayColor]];
        [nameLabel setNumberOfLines:0];
        [[self contentView] addSubview:nameLabel];
        [self setNameLabel:nameLabel];
        
    }
    return self;
    
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    [[self nameLabel] setFrame:CGRectMake(10, 10, 300, 0)];
    
}

#pragma mark - Getters & Setters

-(void)setPinpoint:(PPPinpoint *)pinpoint {
    
    _pinpoint = pinpoint;
    
    [[self nameLabel] setText:[pinpoint name]];
    
    [self layoutSubviews];
    
}

#pragma mark - Class Methods

+(CGFloat)heightForPinpoint:(PPPinpoint *)pinpoint {
    
    static UILabel *_label;
    if (!_label) {
        
        _label = [[UILabel alloc] init];
        [_label setNumberOfLines:0];
        
    }
    
    CGFloat height = 10.0;
    
    [_label setText:[pinpoint name]];
    [_label setFrame:CGRectMake(0, 0, 300, 0)];
    [_label sizeToFit];
    height += CGRectGetHeight([_label frame]);
    
    height += 10.0;
    
    return height;
    
}

@end
