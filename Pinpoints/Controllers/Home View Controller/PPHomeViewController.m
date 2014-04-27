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

@interface PPHomeViewController () <PPMapViewDelegate, PPMenuViewControllerDelegate, PPPinpointViewControllerDelegate>

@property (nonatomic, strong) PPMapView *mapView;
@property (nonatomic, strong) UIView *statusBarView;

@property (nonatomic, strong) UIButton *menuButton;
@property (nonatomic, strong) UIButton *placeButton;

@property (nonatomic, assign, getter = isMenuShown) BOOL menuShown;
@property (nonatomic, strong) UIView *menuBackgroundView;
@property (nonatomic, strong) PPMenuViewController *menuViewController;

@property (nonatomic, assign, getter = isPlacingTutorialShown) BOOL placingTutorialShown;
@property (nonatomic, strong) UIView *placingTutorialView;
@property (nonatomic, strong) UIImageView *placingTutorialHandView;
@property (nonatomic, strong) UILabel *placingTutorialLabel;
@property (nonatomic, strong) NSTimer *placingTutorialTimer;

@end

@implementation PPHomeViewController

-(void)dealloc {
    
    [[self placingTutorialTimer] invalidate];
    [self setPlacingTutorialTimer:nil];
    
}

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[self view] setBackgroundColor:[PPColors backgroundColor]];
    
    PPMapView *mapView = [[PPMapView alloc] init];
    [mapView setMapDelegate:self];
    [mapView setMapType:MKMapTypeStandard];
    [mapView setShowsUserLocation:YES];
    [[self view] addSubview:mapView];
    [self setMapView:mapView];
    
    UIButton *menuButton = [[UIButton alloc] init];
    [menuButton addTarget:self action:@selector(viewMenu:) forControlEvents:UIControlEventTouchUpInside];
    [menuButton setImage:[UIImage imageNamed:@"menuButton"] forState:UIControlStateNormal];
    [menuButton setImage:[UIImage imageNamed:@"menuButtonPressed"] forState:UIControlStateHighlighted];
    [[self view] addSubview:menuButton];
    [self setMenuButton:menuButton];
    
    UIButton *placeButton = [[UIButton alloc] init];
    [placeButton addTarget:self action:@selector(viewPlacingTutorial:) forControlEvents:UIControlEventTouchUpInside];
    [placeButton setImage:[UIImage imageNamed:@"placeButton"] forState:UIControlStateNormal];
    [placeButton setImage:[UIImage imageNamed:@"placeButtonPressed"] forState:UIControlStateHighlighted];
    [[self view] addSubview:placeButton];
    [self setPlaceButton:placeButton];
    
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
    [[self placeButton] setFrame:CGRectMake(320 - 10 - 44, CGRectGetMinY([[self menuButton] frame]) - 5 - 44, 44, 44)];
    
}

-(BOOL)prefersNavigationBarHidden {
    
    return YES;
    
}

#pragma mark - Actions

-(void)addPlacemark:(id)sender {
    
    
    
}

-(void)hideMenu:(id)sender {
    
    if (![self isMenuShown]) return;
    
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
        
        [self setMenuShown:NO];
        
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

-(void)hidePlacingTutorial:(id)sender {
    
    if (![self isPlacingTutorialShown]) return;
    
    [[self placingTutorialTimer] invalidate];
    [self setPlacingTutorialTimer:nil];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [[self placingTutorialView] setAlpha:0.0];
        
    } completion:^(BOOL finished) {
        
        [[self placingTutorialView] removeFromSuperview];
        [self setPlacingTutorialView:nil];
        
        [self setPlacingTutorialLabel:nil];
        [self setPlacingTutorialHandView:nil];
        
        [self setPlacingTutorialShown:NO];
        
    }];
    
}

-(void)viewPlacingTutorial:(id)sender {
    
    if ([self isPlacingTutorialShown]) return;
    [self setPlacingTutorialShown:YES];
    
    UIView *placingTutorialView = [[UIView alloc] init];
    [placingTutorialView setFrame:[[self view] bounds]];
    [placingTutorialView setAlpha:0.0];
    [placingTutorialView setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0]];
    [placingTutorialView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePlacingTutorial:)]];
    [[self view] insertSubview:placingTutorialView belowSubview:[self statusBarView]];
    [self setPlacingTutorialView:placingTutorialView];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [placingTutorialView setAlpha:1.0];
        
    } completion:^(BOOL finished) {
        
        UILabel *placingTutorialLabel = [[UILabel alloc] init];
        [placingTutorialLabel setFrame:CGRectMake((CGRectGetWidth([[self view] frame]) - 320) / 2.0, 50, 320, 150)];
        [placingTutorialLabel setFont:[UIFont boldSystemFontOfSize:26.0]];
        [placingTutorialLabel setShadowColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4]];
        [placingTutorialLabel setShadowOffset:CGSizeMake(0, 1)];
        [placingTutorialLabel setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5]];
        [placingTutorialLabel setTextColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
        [placingTutorialLabel setTextAlignment:NSTextAlignmentCenter];
        [placingTutorialLabel setNumberOfLines:0];
        [placingTutorialLabel setText:@"Tap and hold on the\nmap to place a pin."];
        [placingTutorialView addSubview:placingTutorialLabel];
        [self setPlacingTutorialLabel:placingTutorialLabel];
        
        UIImageView *placingTutorialHandView = [[UIImageView alloc] init];
        [placingTutorialHandView setFrame:CGRectMake(CGRectGetWidth([[self view] frame]) - 280, CGRectGetHeight([[self view] frame]) - 280, 300, 300)];
        [placingTutorialHandView setImage:[UIImage imageNamed:@"placingTutorialHand"]];
        [placingTutorialView addSubview:placingTutorialHandView];
        [self setPlacingTutorialHandView:placingTutorialHandView];
        
        [placingTutorialLabel setTransform:CGAffineTransformMakeTranslation(0, -250)];
        [placingTutorialHandView setTransform:CGAffineTransformMakeTranslation(CGRectGetWidth([placingTutorialHandView frame]), CGRectGetHeight([placingTutorialHandView frame]))];
        
        [UIView animateWithDuration:0.8 delay:0.0 usingSpringWithDamping:0.9 initialSpringVelocity:0.0 options:0 animations:^{
            
            [placingTutorialLabel setTransform:CGAffineTransformIdentity];
            [placingTutorialHandView setTransform:CGAffineTransformIdentity];
            
        } completion:^(BOOL finished) {
            
            [self animatePlacingTutorial];
            
        }];
        
    }];
    
}

#pragma mark - Placing Tutorial

-(void)animatePlacingTutorial {
    
    if (![self isPlacingTutorialShown]) return;
    
    [[self placingTutorialTimer] invalidate];
    [self setPlacingTutorialTimer:nil];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [[self placingTutorialHandView] setTransform:CGAffineTransformMakeScale(0.9, 0.9)];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.25 delay:1.0 options:0 animations:^{
            
            [[self placingTutorialHandView] setTransform:CGAffineTransformIdentity];
            
        } completion:^(BOOL finished) {
            
            [self setPlacingTutorialTimer:[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(animatePlacingTutorial) userInfo:nil repeats:NO]];
            
        }];
        
        // after a few ms animate the pin
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            UIView *placingTutorialPinView = [[UIView alloc] init];
            [placingTutorialPinView setFrame:CGRectMake(CGRectGetMinX([[self placingTutorialHandView] frame]) + 120, CGRectGetMinY([[self placingTutorialHandView] frame]) + 30, 8, 8)];
            [placingTutorialPinView setBackgroundColor:[PPColors tintColor]];
            [[placingTutorialPinView layer] setCornerRadius:4];
            [[self placingTutorialView] insertSubview:placingTutorialPinView belowSubview:[self placingTutorialHandView]];
            
            [placingTutorialPinView setAlpha:0.5];
            [UIView animateWithDuration:1.0 animations:^{
                
                [placingTutorialPinView setTransform:CGAffineTransformMakeScale(15.0, 15.0)];
                [placingTutorialPinView setAlpha:0.0];
                
            } completion:^(BOOL finished) {
                
                [placingTutorialPinView removeFromSuperview];
                
            }];
            
        });
        
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
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        PPPinpointViewController *pinpointViewController = [[PPPinpointViewController alloc] init];
        [pinpointViewController setDelegate:self];
        [pinpointViewController setPinpoint:pinpoint];
        [pinpointViewController setFocusNameFieldOnView:YES];
        [[self navigationController] pushViewController:pinpointViewController animated:YES];
        
    });
    
}

-(void)mapView:(PPMapView *)mapView didViewPinpoint:(PPPinpoint *)pinpoint {
    
    PPPinpointViewController *pinpointViewController = [[PPPinpointViewController alloc] init];
    [pinpointViewController setDelegate:self];
    [pinpointViewController setPinpoint:pinpoint];
    [[self navigationController] pushViewController:pinpointViewController animated:YES];
    
}

#pragma mark - PPMenuViewControllerDelegate

-(void)menuViewControllerDidClose:(PPMenuViewController *)menuViewController {
    
    [self hideMenu:nil];
    
}

-(void)menuViewController:(PPMenuViewController *)menuViewController didViewPinpoint:(PPPinpoint *)pinpoint {
    
    PPPinpointViewController *pinpointViewController = [[PPPinpointViewController alloc] init];
    [pinpointViewController setDelegate:self];
    [pinpointViewController setPinpoint:pinpoint];
    [[self navigationController] pushViewController:pinpointViewController animated:YES];
    
}

-(void)menuViewControllerDidUpdateVisibleGroups:(PPMenuViewController *)menuViewController {
    
    [[self mapView] refreshVisibleGroups];
    
}

#pragma mark - PPPinpointViewControllerDelegate

-(void)pinpointViewControllerDidViewPinpointOnMap:(PPPinpointViewController *)pinpointViewController {
    
    [self hideMenu:nil];
    
    [[self mapView] zoomToPinpoint:[pinpointViewController pinpoint]];
    
}

@end
