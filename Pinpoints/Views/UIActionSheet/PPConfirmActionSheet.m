//
//  PPConfirmActionSheet.m
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-26.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import "PPConfirmActionSheet.h"

@interface PPConfirmActionSheet () <UIActionSheetDelegate>

@property (nonatomic, copy) NSString *cancelButtonTitle;
@property (nonatomic, copy) NSString *destructiveButtonTitle;

@end

@implementation PPConfirmActionSheet

-(id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTile:(NSString *)destructiveButtonTitle {
    
    self = [super initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil];
    if (self) {
        
        [self setCancelButtonTitle:cancelButtonTitle];
        [self setDestructiveButtonTitle:destructiveButtonTitle];
        
    }
    
    return self;
    
}

#pragma mark - UIActionSheetDelegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:[self cancelButtonTitle]]) {
        
        if ([self cancelBlock]) [self cancelBlock]();
        
    } else if ([buttonTitle isEqualToString:[self destructiveButtonTitle]]) {
        
        if ([self confirmBlock]) [self confirmBlock]();
        
    }
    
}

@end
