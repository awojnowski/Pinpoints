//
//  PPPinpointAnnotationView.m
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-26.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import "PPPinpointPinAnnotationView.h"

#import "PPPinpoint.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface PPPinpointPinAnnotationView ()

@property (nonatomic, strong) UIImageView *streetViewImageView;

@end

@implementation PPPinpointPinAnnotationView

-(id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setAnimatesDrop:YES];
        [self setCanShowCallout:YES];
        [self setDraggable:YES];
        [self setRightCalloutAccessoryView:[UIButton buttonWithType:UIButtonTypeDetailDisclosure]];
        
        UIImageView *streetViewImageView = [[UIImageView alloc] init];
        [streetViewImageView setFrame:CGRectMake(0, 0, 50, 50)];
        [streetViewImageView setContentMode:UIViewContentModeScaleAspectFill];
        [streetViewImageView setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0]];
        [self setLeftCalloutAccessoryView:streetViewImageView];
        [self setStreetViewImageView:streetViewImageView];
        
    }
    return self;
    
}

-(void)prepareForReuse {
    
    [super prepareForReuse];
    
    [self cancelStreetViewLoading];
    
}

#pragma mark - Image Loading

-(void)cancelStreetViewLoading {
    
    [[self streetViewImageView] cancelCurrentImageLoad];
    [[self streetViewImageView] setImage:nil];
    
}

-(void)loadStreetViewImage {
    
    [self cancelStreetViewLoading];
    
    [[self streetViewImageView] setImageWithURL:[[self pinpoint] streetViewURLWithSize:CGSizeMake(100, 100)]];
    
}

#pragma mark - Getters & Setters

-(void)setPinpoint:(PPPinpoint *)pinpoint {
    
    _pinpoint = pinpoint;
        
    if ([pinpoint isVisited]) {
        
        [self setPinColor:MKPinAnnotationColorGreen];
        
    } else {
        
        [self setPinColor:MKPinAnnotationColorRed];
        
    }
    
}

@end
