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
    
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([indexPath row] == 0) {
        
        // section header
        
        return 60.0;
        
    }
    
    return 44.0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PPMenuGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
    if (!cell) {
        
        cell = [[PPMenuGroupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MenuCell"];
        
    }
    
    PPGroup *group = [self groups][[indexPath section]];
    [[cell textLabel] setText:[group name]];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
