//
//  PPHomeViewController.m
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-25.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import "PPHomeViewController.h"
#import "PPMenuViewController.h"
#import "PPPinpointViewController.h"

#import "PPMapView.h"

#import "PPGroup.h"
#import "PPPinpoint.h"

#import "UIImage+ImageEffects.h"

CGFloat const kPPHomeViewControllerMenuAnimationLength = 0.3;

@interface PPHomeViewController () <PPMapViewDelegate, PPMenuViewControllerDelegate>

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) UIView *statusBarView;

@property (nonatomic, strong) UIButton *menuButton;

@property (nonatomic, assign, getter = isMenuShown) BOOL menuShown;
@property (nonatomic, strong) UIView *menuBackgroundView;
@property (nonatomic, strong) PPMenuViewController *menuViewController;

@end

@implementation PPHomeViewController

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[self view] setBackgroundColor:[PPColors backgroundColor]];
    
    PPGroup *defaultGroup = nil;
    NSArray *groups = [PPGroup allGroups];
    
    if ([groups count] > 0) {
        
        defaultGroup = [groups firstObject];
        
    }
    
    PPMapView *mapView = [[PPMapView alloc] init];
    [mapView setMapDelegate:self];
    [mapView setMapType:MKMapTypeStandard];
    [mapView setShowsUserLocation:YES];
    [mapView setGroup:defaultGroup];
    [[self view] addSubview:mapView];
    [self setMapView:mapView];
    
    UIButton *menuButton = [[UIButton alloc] init];
    [menuButton addTarget:self action:@selector(viewMenu:) forControlEvents:UIControlEventTouchUpInside];
    [menuButton setImage:[UIImage imageNamed:@"menuButton"] forState:UIControlStateNormal];
    [menuButton setImage:[UIImage imageNamed:@"menuButtonPressed"] forState:UIControlStateHighlighted];
    [[self view] addSubview:menuButton];
    [self setMenuButton:menuButton];
    
    UIView *statusBarView = [[UIView alloc] init];
    [statusBarView setFrame:CGRectMake(0, 0, 320, 20)];
    [statusBarView setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.75]];
    [[statusBarView layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[statusBarView layer] setShadowOffset:CGSizeMake(0, 0)];
    [[statusBarView layer] setShadowOpacity:0.25];
    [[statusBarView layer] setShadowRadius:2.0];
    [[statusBarView layer] setShadowPath:[[UIBezierPath bezierPathWithRect:[statusBarView bounds]] CGPath]];
    [[statusBarView layer] setShouldRasterize:YES];
    [[self view] addSubview:statusBarView];
    [self setStatusBarView:statusBarView];
    
}

-(void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    [[self mapView] setFrame:[[self view] frame]];
    
    [[self menuButton] setFrame:CGRectMake(320 - 10 - 44, CGRectGetHeight([[self view] bounds]) - 10 - 44, 44, 44)];
    
}

-(BOOL)prefersNavigationBarHidden {
    
    return YES;
    
}

#pragma mark - Actions

-(void)addPlacemark:(id)sender {
    
    
    
}

-(void)hideMenu:(id)sender {
    
    if (![self isMenuShown]) return;
    [self setMenuShown:NO];
    
    [UIView animateWithDuration:kPPHomeViewControllerMenuAnimationLength delay:0.0 options:0 animations:^{
        
        [[self menuBackgroundView] setAlpha:0.0];
        
    } completion:^(BOOL finished) {
        
        [[self menuBackgroundView] removeFromSuperview];
        [self setMenuBackgroundView:nil];
        
    }];

    [UIView animateWithDuration:kPPHomeViewControllerMenuAnimationLength delay:0.0 usingSpringWithDamping:0.9 initialSpringVelocity:0.0 options:0 animations:^{
        
        [[[self menuViewController] view] setTransform:CGAffineTransformMakeTranslation(0, CGRectGetHeight([[[self menuViewController] view] frame]) + 5)];
        
    } completion:^(BOOL finished) {
        
        [[[self menuViewController] view] removeFromSuperview];
        [[self menuViewController] removeFromParentViewController];
        [self setMenuViewController:nil];
        
    }];
    
}

-(void)viewMenu:(id)sender {
    
    if ([self isMenuShown]) return;
    [self setMenuShown:YES];
    
    UIView *menuBackgroundView = [[UIView alloc] init];
    [menuBackgroundView setFrame:[[[self navigationController] view] bounds]];
    [menuBackgroundView setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.1]];
    [[self view] insertSubview:menuBackgroundView belowSubview:[self statusBarView]];
    [self setMenuBackgroundView:menuBackgroundView];
    
    // disabled blur for now
    /*UIImageView *snapshotImageView = [[UIImageView alloc] init];
    [snapshotImageView setFrame:[[self view] bounds]];
    [snapshotImageView setAlpha:0.0];
    [menuBackgroundView addSubview:snapshotImageView];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        
        UIImage *blurredMapScreenshot = [self blurredMapSnapshot];
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            
            [snapshotImageView setImage:blurredMapScreenshot];
            
            [UIView animateWithDuration:kPPHomeViewControllerMenuAnimationLength animations:^{
                
                [snapshotImageView setAlpha:1.0];
                
            }];
            
        });
        
    });*/
    
    UIButton *hideButton = [[UIButton alloc] init];
    [hideButton setFrame:[menuBackgroundView bounds]];
    [hideButton addTarget:self action:@selector(hideMenu:) forControlEvents:UIControlEventTouchUpInside];
    [menuBackgroundView addSubview:hideButton];
    
    [menuBackgroundView setAlpha:0.0];
    [UIView animateWithDuration:kPPHomeViewControllerMenuAnimationLength delay:0.0 options:0 animations:^{
        
        [menuBackgroundView setAlpha:1.0];
        
    } completion:^(BOOL finished) {
        
        
        
    }];
    
    CGFloat menuHeight = CGRectGetHeight([[self view] frame]) - 100;
    
    PPMenuViewController *menuViewController = [[PPMenuViewController alloc] init];
    [menuViewController setMenuDelegate:self];
    [[menuViewController view] setFrame:CGRectMake(0, CGRectGetHeight([[self view] frame]) - menuHeight, 320, menuHeight)];
    [[self view] addSubview:[menuViewController view]];
    [self addChildViewController:menuViewController];
    [self setMenuViewController:menuViewController];
    
    UIView *lineView = [[UIView alloc] init];
    [lineView setFrame:CGRectMake(0, -0.5, 320, 0.5)];
    [lineView setBackgroundColor:[UIColor lightGrayColor]];
    [[menuViewController view] addSubview:lineView];
    
    [[menuViewController view] setTransform:CGAffineTransformMakeTranslation(0, CGRectGetHeight([[menuViewController view] frame]) + 5)];
    [UIView animateWithDuration:kPPHomeViewControllerMenuAnimationLength delay:0.0 usingSpringWithDamping:0.9 initialSpringVelocity:0.0 options:0 animations:^{
        
        [[menuViewController view] setTransform:CGAffineTransformIdentity];
        
    } completion:^(BOOL finished) {
        
        
        
    }];
    
}

#pragma mark - Helper Methods

-(UIImage *)blurredMapSnapshot {
    
    UIGraphicsBeginImageContextWithOptions([[self mapView] bounds].size, NO, [[UIScreen mainScreen] scale]);
    
    [[self mapView] drawViewHierarchyInRect:[[self mapView] bounds] afterScreenUpdates:NO];
    
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIImage *blurredSnapshotImage = [snapshotImage applyBlurWithRadius:3.0 tintColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.1] saturationDeltaFactor:1.5 maskImage:nil];
    
    UIGraphicsEndImageContext();
    
    return blurredSnapshotImage;
    
}

#pragma mark - PPMapViewDelegate

-(void)mapView:(PPMapView *)mapView didPlacePinpoint:(PPPinpoint *)pinpoint {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
        PPPinpointViewController *pinpointViewController = [[PPPinpointViewController alloc] init];
        [pinpointViewController setPinpoint:pinpoint];
        [pinpointViewController setFocusNameFieldOnView:YES];
        [[self navigationController] pushViewController:pinpointViewController animated:YES];
        
    });
    
}

-(void)mapView:(PPMapView *)mapView didViewPinpoint:(PPPinpoint *)pinpoint {
    
    PPPinpointViewController *pinpointViewController = [[PPPinpointViewController alloc] init];
    [pinpointViewController setPinpoint:pinpoint];
    [[self navigationController] pushViewController:pinpointViewController animated:YES];
    
}

#pragma mark - PPMenuViewControllerDelegate

-(void)menuViewControllerDidClose:(PPMenuViewController *)menuViewController {
    
    [self hideMenu:nil];
    
}

@end
