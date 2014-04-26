//
//  PPMapView.m
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-26.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import "PPMapView.h"

#import "PPPinpointAnnotation.h"

#import "PPGroup.h"
#import "PPPinpoint.h"

@interface PPMapView () <MKMapViewDelegate>



@end

@implementation PPMapView

-(id)init {
    
    self = [super init];
    if (self) {
        
        [self setDelegate:self];
        
        UILongPressGestureRecognizer *addPinGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapHoldPin:)];
        [self addGestureRecognizer:addPinGestureRecognizer];
        
    }
    return self;
    
}

#pragma mark - Actions

-(void)handleTapHoldPin:(UILongPressGestureRecognizer *)gestureRecognizer {
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        
        CGPoint point = [gestureRecognizer locationInView:self];
        CLLocationCoordinate2D coordinate = [self convertPoint:point toCoordinateFromView:self];
        
        PPPinpoint *pinpoint = [PPPinpoint createPinpointInGroup:[self group]];
        [pinpoint setLatitudeValue:coordinate.latitude];
        [pinpoint setLongitudeValue:coordinate.longitude];
        
        PPPinpointAnnotation *annotation = [[PPPinpointAnnotation alloc] init];
        [annotation setPinpoint:pinpoint];
        [self addAnnotation:annotation];
        
    }
    
}

#pragma mark - Getters & Setters

-(void)setGroup:(PPGroup *)group {
    
    _group = group;
    
    NSArray *currentAnnotations = [self annotations];
    for (id <MKAnnotation> annotation in currentAnnotations) {
        
        if ([annotation isKindOfClass:[PPPinpointAnnotation class]]) {
            
            [self removeAnnotation:annotation];
            
        }
        
    }
    
    NSMutableArray *annotations = [NSMutableArray array];
    for (PPPinpoint *pinpoint in [[group pinpoints] allObjects]) {
        
        PPPinpointAnnotation *annotation = [[PPPinpointAnnotation alloc] init];
        [annotation setPinpoint:pinpoint];
        [annotations addObject:annotation];
        
    }
    
    if ([annotations count] > 0) {
        
        [self addAnnotations:annotations];
        
    }
    
}

#pragma mark - MKMapViewDelegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[PPPinpointAnnotation class]]) {
        
        PPPinpointAnnotation *pinpointAnnotation = (PPPinpointAnnotation *)annotation;
        PPPinpoint *pinpoint = [pinpointAnnotation pinpoint];
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"PinpointAnnotation"];
        if (!annotationView) {
            
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:pinpointAnnotation reuseIdentifier:@"PinpointAnnotation"];
            [annotationView setAnimatesDrop:YES];
            [annotationView setCanShowCallout:YES];
            [annotationView setDraggable:YES];
            
        }
        
        if ([pinpoint isVisited]) {
            
            [annotationView setPinColor:MKPinAnnotationColorGreen];
            
        } else {
            
            [annotationView setPinColor:MKPinAnnotationColorRed];
            
        }
        
        return annotationView;
        
    }
    
    return nil;
    
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState {
    
    if (newState == MKAnnotationViewDragStateEnding) {
        
        CLLocationCoordinate2D coordinate = [[view annotation] coordinate];
        NSLog(@"Pin dropped at {%f, %f}", coordinate.latitude, coordinate.longitude);
        
    }
    
}

@end
