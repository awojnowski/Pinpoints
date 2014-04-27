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

#import "PPCoreDataHandler.h"
#import "PPGroup.h"
#import "PPPinpoint.h"

@interface PPMenuTableView () <PPMenuGroupTableViewCellDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *groups;

@end

@implementation PPMenuTableView

-(void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        [self setDelegate:self];
        [self setDataSource:self];
        
        [self setSeparatorInset:UIEdgeInsetsZero];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(managedObjectsChanged:) name:NSManagedObjectContextObjectsDidChangeNotification object:[[PPCoreDataHandler sharedHandler] managedObjectContext]];
        
        UIView *tableFooterView = [[UIView alloc] init];
        [tableFooterView setFrame:CGRectMake(0, 0, 320, 44 + 30)];
        [self setTableFooterView:tableFooterView];
        
        UIButton *createGroupButton = [[UIButton alloc] init];
        [createGroupButton addTarget:self action:@selector(createGroup:) forControlEvents:UIControlEventTouchUpInside];
        [createGroupButton setFrame:CGRectMake(0, 0, 320, 44)];
        [createGroupButton setTitleColor:[PPColors tintColor] forState:UIControlStateNormal];
        [createGroupButton setTitleColor:[[PPColors tintColor] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
        [createGroupButton setTitle:@"Create New Group" forState:UIControlStateNormal];
        [tableFooterView addSubview:createGroupButton];
        
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
    
    NSInteger rows = 1;
    if ([group isExpanded]) {
        
        rows += [[group pinpoints] count];
        
    }
    return rows;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PPGroup *group = [self groups][[indexPath section]];
    
    if ([indexPath row] == 0) {
        
        // section header
        
        return [PPMenuGroupTableViewCell heightForGroup:group];
        
    } else {
        
        // section contents
        
        NSInteger pinpointIndex = [indexPath row] - 1;
        PPPinpoint *pinpoint = [[group pinpointsArray] objectAtIndex:pinpointIndex];
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
            [cell setDelegate:self];
            
        }
        [cell setGroup:group];
        
        return cell;
        
    } else {
        
        // section contents
        
        NSInteger pinpointIndex = [indexPath row] - 1;
        PPPinpoint *pinpoint = [[group pinpointsArray] objectAtIndex:pinpointIndex];
        
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
    
    PPGroup *group = [self groups][[indexPath section]];
    
    if ([indexPath row] == 0) {
        
        [group setExpanded:![group isExpanded]];
        [self reloadSections:[NSIndexSet indexSetWithIndex:[indexPath section]] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    } else {
        
        NSInteger pinpointIndex = [indexPath row] - 1;
        PPPinpoint *pinpoint = [[group pinpointsArray] objectAtIndex:pinpointIndex];
        
        if ([[self menuDelegate] respondsToSelector:@selector(menuTableView:didViewPinpoint:)])
            [[self menuDelegate] menuTableView:self didViewPinpoint:pinpoint];
        
    }
    
}

#pragma mark - Actions

-(void)createGroup:(id)sender {
    
    [PPGroup createGroupWithName:@"New Group"];
    
    [self reloadData];
    
}

#pragma mark - PPMenuGroupTableViewCellDelegate

-(void)menuGroupTableViewCellDidHide:(PPMenuGroupTableViewCell *)menuGroupTableViewCell {
    
    if ([[self menuDelegate] respondsToSelector:@selector(menuTableViewDidUpdateVisibleGroups:)])
        [[self menuDelegate] menuTableViewDidUpdateVisibleGroups:self];
    
    
}

-(void)menuGroupTableViewCellDidShow:(PPMenuGroupTableViewCell *)menuGroupTableViewCell {
        
    if ([[self menuDelegate] respondsToSelector:@selector(menuTableViewDidUpdateVisibleGroups:)])
        [[self menuDelegate] menuTableViewDidUpdateVisibleGroups:self];
    
}

#pragma mark - NSNotificationCenter

-(void)managedObjectsChanged:(NSNotification *)notification {
    
    BOOL reloadData = NO;
    
    NSSet *deletedObjects = [[notification userInfo] objectForKey:NSDeletedObjectsKey];
    for (NSManagedObject *object in deletedObjects) {
        
        if ([object isKindOfClass:[PPPinpoint class]]) {
                                                
            reloadData = YES;
            
        }
        
    }
    
    if (reloadData) {
        
        [self reloadData];
        
    }
    
}

@end
