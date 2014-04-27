//
//  PPChooseGroupActionSheet.m
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-27.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import "PPChooseGroupActionSheet.h"

#import "PPGroup.h"

@interface PPChooseGroupActionSheet () <UIActionSheetDelegate>

@end

@implementation PPChooseGroupActionSheet

-(id)initWithGroups:(NSArray *)groups {
    
    self = [super initWithTitle:@"Which group would you like to place the pinpoint in?" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    if (self) {
        
        _groups = groups;
        
        for (PPGroup *group in groups) {
            
            [self addButtonWithTitle:[group name]];
            
        }
        [self addButtonWithTitle:@"Cancel"];
        [self setCancelButtonIndex:[[self groups] count]];
        
    }
    return self;
    
}

#pragma mark - UIActionSheetDelegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if (![buttonTitle isEqualToString:@"Cancel"]) {
        
        for (PPGroup *group in [self groups]) {
            
            if ([[group name] isEqualToString:buttonTitle]) {
                
                if ([self chosenBlock]) [self chosenBlock](group);
                break;
                
            }
            
        }
        
    }
    
}

@end
