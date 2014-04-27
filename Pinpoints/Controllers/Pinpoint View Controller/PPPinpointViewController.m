//
//  PPPinpointViewController.m
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-26.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import "PPPinpointViewController.h"

#import "PPPinpoint.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface PPPinpointViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign, getter = isEditingText) BOOL editingText;

@end

@implementation PPPinpointViewController

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setTitle:@"Pinpoint"];
    
    [[self view] setBackgroundColor:[UIColor whiteColor]];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [[self view] addSubview:tableView];
    [self setTableView:tableView];
    
    UIImageView *streetViewImageView = [[UIImageView alloc] init];
    [streetViewImageView setFrame:CGRectMake(0, 0, 320, 100)];
    [streetViewImageView setContentMode:UIViewContentModeScaleAspectFill];
    [streetViewImageView setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0]];
    [streetViewImageView setImageWithURL:[[self pinpoint] streetViewURLWithSize:CGSizeMake(640, 200)]];
    [tableView setTableHeaderView:streetViewImageView];
    
}

-(void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    [UIView performWithoutAnimation:^{
        
        [self setupForTextEditingState];
        
    }];
    
}

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

#pragma mark - UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [self setEditingText:YES];
    [self setupForTextEditingState];
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    [self setEditingText:NO];
    [self performSelector:@selector(setupForTextEditingState) withObject:nil afterDelay:0.05];
    
}

#pragma mark - UITextViewDelegate

-(void)textViewDidBeginEditing:(UITextView *)textView {
    
    [self setEditingText:YES];
    [self setupForTextEditingState];
    
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    
    [self setEditingText:NO];
    [self performSelector:@selector(setupForTextEditingState) withObject:nil afterDelay:0.05];
    
}

#pragma mark - Shared Text Handlers

-(void)setupForTextEditingState {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGFloat viewHeight = CGRectGetHeight([[self view] frame]);
        if ([self isEditingText]) {
            
            [[self tableView] setFrame:CGRectMake(0, 0, 320, viewHeight - 216)];
            
        } else {
            
            [[self tableView] setFrame:CGRectMake(0, 0, 320, viewHeight)];
            
        }
        
    }];
    
}

@end
