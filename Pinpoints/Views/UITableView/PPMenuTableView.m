//
//  PPMenuTableview.m
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-26.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import "PPMenuTableView.h"

#import "PPMenuGroupTableViewCell.h"
#import "PPMenuPinpointTableViewCell.h"

#import "PPGroup.h"
#import "PPPinpoint.h"

@interface PPMenuTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *groups;

@end

@implementation PPMenuTableView

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        [self setDelegate:self];
        [self setDataSource:self];
        
    }
    return self;
    
}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    [self setGroups:[PPGroup allGroups]];
    return [[self groups] count];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    PPGroup *group = [self groups][section];
    return 1 + [[group groups] count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PPGroup *group = [self groups][[indexPath section]];
    
    if ([indexPath row] == 0) {
        
        // section header
        
        return [PPMenuGroupTableViewCell heightForGroup:group];
        
    } else {
        
        // section contents
        
        PPPinpoint *pinpoint = [[[group pinpoints] allObjects] objectAtIndex:[indexPath row] - 1];
        return [PPMenuPinpointTableViewCell heightForPinpoint:pinpoint];
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PPGroup *group = [self groups][[indexPath section]];
    
    if ([indexPath row] == 0) {
        
        // section header
        
        PPMenuGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
        if (!cell) {
            
            cell = [[PPMenuGroupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MenuCell"];
            
        }
        [cell setGroup:group];
        
        return cell;
        
    } else {
        
        // section contents
        
        PPPinpoint *pinpoint = [[[group pinpoints] allObjects] objectAtIndex:[indexPath row] - 1];
        
        PPMenuPinpointTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PinpointCell"];
        if (!cell) {
            
            cell = [[PPMenuPinpointTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PinpointCell"];
            
        }
        [cell setPinpoint:pinpoint];
        
        return cell;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
