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

NSInteger const kPPPinpointViewControllerNameTextFieldTag = 2;
NSInteger const kPPPinpointViewControllerCaptionTextFieldTag = 3;

@interface PPPinpointViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

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
    
    return 3;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([indexPath row] == 0) return 70.0;
    else if ([indexPath row] == 1) return 70.0;
    else if ([indexPath row] == 2) {
        
        static UILabel *_label;
        if (!_label) {
            
            _label = [[UILabel alloc] init];
            [_label setNumberOfLines:0];
            
        }
        
        CGFloat height = 35.0;
        
        if ([[[self pinpoint] address] length] == 0) {
            
            [_label setText:@"No suitable address found."];
            
        } else {
            
            [_label setText:[[self pinpoint] address]];
            
        }
        [_label setFrame:CGRectMake(0, 0, 300, 0)];
        [_label sizeToFit];
        height += CGRectGetHeight([_label frame]);
        
        height += 10.0;
        
        return height;
        
    }
    
    return 0.0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = [indexPath row];
    NSString *reuseIdentifier = nil;
    
    if (row == 0) reuseIdentifier = @"NameCell";
    else if (row == 1) reuseIdentifier = @"CaptionCell";
    else if (row == 2) reuseIdentifier = @"AddressCell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(10, 10, 300, 15)];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:12.0]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextColor:[UIColor blackColor]];
    [[cell contentView] addSubview:titleLabel];
    
    if (row == 0 ||
        row == 1) {
        
        UITextField *textField = [[UITextField alloc] init];
        [textField setFrame:CGRectMake(10, 35, 300, 25)];
        [textField setDelegate:self];
        [textField setBackgroundColor:[UIColor clearColor]];
        [textField setTextColor:[UIColor darkGrayColor]];
        [textField setReturnKeyType:UIReturnKeyDone];
        [[cell contentView] addSubview:textField];
        
        if (row == 0) {
            
            [titleLabel setText:@"Name (required)"];
            
            [textField setTag:kPPPinpointViewControllerNameTextFieldTag];
            [textField setPlaceholder:@"What's this pinpoint named?"];
            [textField setText:[[self pinpoint] name]];
            
        } else if (row == 1) {
            
            [titleLabel setText:@"Caption"];
            
            [textField setTag:kPPPinpointViewControllerCaptionTextFieldTag];
            [textField setPlaceholder:@"Write something about this pinpoint!"];
            [textField setText:[[self pinpoint] caption]];
            
        }
        
    } else if (row == 2) {
        
        [titleLabel setText:@"Address"];
        
        UILabel *addressLabel = [[UILabel alloc] init];
        [addressLabel setTextColor:[UIColor lightGrayColor]];
        [addressLabel setBackgroundColor:[UIColor clearColor]];
        [addressLabel setNumberOfLines:0];
        [[cell contentView] addSubview:addressLabel];
        
        if ([[[self pinpoint] address] length] == 0) {
            
            [addressLabel setText:@"No suitable address found."];
            
        } else {
            
            [addressLabel setText:[[self pinpoint] address]];
            
        }
        
        [addressLabel setFrame:CGRectMake(0, 0, 300, 0)];
        [addressLabel sizeToFit];
        [addressLabel setFrame:CGRectMake(10, 35, 300, CGRectGetHeight([addressLabel frame]))];
        
    }
    
    return cell;
    
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
    [self performSelector:@selector(setupForTextEditingState) withObject:nil afterDelay:0.01];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return NO;
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    [self performSelector:@selector(updateTextFieldText:) withObject:textField afterDelay:0.1];
    
    return YES;
    
}

#pragma mark - Shared Text Handlers

-(void)setupForTextEditingState {
        
    CGFloat viewHeight = CGRectGetHeight([[self view] frame]);
    if ([self isEditingText]) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            [[self tableView] setFrame:CGRectMake(0, 0, 320, viewHeight - 216)];
            
        }];
            
    } else {
            
        [[self tableView] setFrame:CGRectMake(0, 0, 320, viewHeight)];
            
    }
    
}

-(void)updateTextFieldText:(UITextField *)textField {
    
    NSString *text = [textField text];
    if ([textField tag] == kPPPinpointViewControllerNameTextFieldTag) {
        
        if ([text length] == 0) return;
        
        [[self pinpoint] setName:text];
        
    } else if ([textField tag] == kPPPinpointViewControllerCaptionTextFieldTag) {
        
        [[self pinpoint] setCaption:text];
        
    }
    
}

@end
