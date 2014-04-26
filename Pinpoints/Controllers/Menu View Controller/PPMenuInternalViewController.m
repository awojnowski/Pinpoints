//
//  PPMenuInternalViewController.m
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-26.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import "PPMenuInternalViewController.h"

#import "PPMenuTableView.h"

@interface PPMenuInternalViewController ()

@property (nonatomic, strong) PPMenuTableView *tableView;

@end

@implementation PPMenuInternalViewController

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[self view] setBackgroundColor:[UIColor whiteColor]];
    
    [self setTitle:@"Pinpoints"];
    
    UIBarButtonItem *closeBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(close:)];
    [[self navigationItem] setLeftBarButtonItem:closeBarButtonItem];
    
    UIBarButtonItem *editBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(edit:)];
    [[self navigationItem] setRightBarButtonItem:editBarButtonItem];
    
    PPMenuTableView *tableView = [[PPMenuTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [[self view] addSubview:tableView];
    [self setTableView:tableView];
    
}

-(void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    [[self tableView] setFrame:[[self view] bounds]];
    
}

#pragma mark - Actions

-(void)close:(id)sender {
    
    if ([[self delegate] respondsToSelector:@selector(menuViewControllerDidClose:)])
        [[self delegate] menuViewControllerDidClose:[self menuViewController]];
    
}

-(void)edit:(id)sender {
    
    
    
}

@end
