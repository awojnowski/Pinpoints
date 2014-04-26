//
//  PPBackgroundTableViewCell.m
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-26.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import "PPBackgroundTableViewCell.h"

@implementation PPBackgroundTableViewCell

-(id)init {
    
    self = [super init];
    if (self) {
        
        [self sharedInit];
        
    }
    
    return self;
    
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self sharedInit];
        
    }
    
    return self;
    
}

-(void)sharedInit {
    
    [self setSelectedBackgroundView:[[UIImageView alloc] init]];
    
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    [self changeBackgroundColorToHighlighted:selected animated:animated];
    
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
    [super setHighlighted:highlighted animated:animated];
    
    if (![self isSelected]) [self changeBackgroundColorToHighlighted:highlighted animated:animated];
    
}

-(void)changeBackgroundColorToHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
    UIColor *color = highlighted ? [self selectedBackgroundColor] : [self defaultBackgroundColor];
    
    void (^changeBlock)(void) = ^{
        
        if ([[self backgroundDelegate] respondsToSelector:@selector(backgroundTableViewCell:willChangeToBackgroundColor:)])
            [[self backgroundDelegate] performSelector:@selector(backgroundTableViewCell:willChangeToBackgroundColor:) withObject:self withObject:color];
        else
            [self setBackgroundColor:color];
        
    };
    if (!animated) changeBlock();
    else {
        
        [UIView animateWithDuration:0.3 animations:changeBlock];
        
    }
    
}

-(void)setDefaultBackgroundColor:(UIColor *)defaultBackgroundColor {
    
    _defaultBackgroundColor = defaultBackgroundColor;
    
    if (![self isHighlighted] &&
        ![self isSelected]) [self changeBackgroundColorToHighlighted:NO animated:NO];
    
}

-(void)setSelectedBackgroundColor:(UIColor *)selectedBackgroundColor {
    
    _selectedBackgroundColor = selectedBackgroundColor;
    
    if ([self isHighlighted] ||
        [self isSelected]) [self changeBackgroundColorToHighlighted:YES animated:NO];
    
}


@end
