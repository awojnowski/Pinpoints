//
//  PPMapView.m
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-26.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import "PPMapView.h"

#import "PPPinpointAnnotation.h"
#import "PPPinpointPinAnnotationView.h"

#import "PPCoreDataHandler.h"
#import "PPGroup.h"
#import "PPPinpoint.h"

@interface PPMapView () <MKMapViewDelegate>

@end

@implementation PPMapView

-(void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

-(id)init {
    
    self = [super init];
    if (self) {
        
        [self setDelegate:self];
        
        UILongPressGestureRecognizer *addPinGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapHoldPin:)];
        [self addGestureRecognizer:addPinGestureRecognizer];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(managedObjectsChanged:) name:NSManagedObjectContextObjectsDidChangeNotification object:[[PPCoreDataHandler sharedHandler] managedObjectContext]];
        
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
        [pinpoint fetchAddressFromCoordinate];
        
        PPPinpointAnnotation *annotation = [[PPPinpointAnnotation alloc] init];
        [annotation setPinpoint:pinpoint];
        [self addAnnotation:annotation];
        
        if ([[self mapDelegate] respondsToSelector:@selector(mapView:didPlacePinpoint:)])
            [[self mapDelegate] mapView:self didPlacePinpoint:pinpoint];
        
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
        
        PPPinpointPinAnnotationView *annotationView = (PPPinpointPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"PinpointAnnotation"];
        if (!annotationView) {
            
            annotationView = [[PPPinpointPinAnnotationView alloc] initWithAnnotation:pinpointAnnotation reuseIdentifier:@"PinpointAnnotation"];
            
        }
        [annotationView setPinpoint:pinpoint];
        
        return annotationView;
        
    }
    
    return nil;
    
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    if ([view isKindOfClass:[PPPinpointPinAnnotationView class]]) {
        
        PPPinpoint *pinpoint = [(PPPinpointPinAnnotationView *)view pinpoint];
        
        if ([[self mapDelegate] respondsToSelector:@selector(mapView:didViewPinpoint:)])
            [[self mapDelegate] mapView:self didViewPinpoint:pinpoint];
        
    }
    
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState {
    
    if (newState == MKAnnotationViewDragStateEnding) {
        
        CLLocationCoordinate2D coordinate = [[view annotation] coordinate];
        NSLog(@"Pin dropped at {%f, %f}", coordinate.latitude, coordinate.longitude);
        
    }
    
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    if ([view isKindOfClass:[PPPinpointPinAnnotationView class]]) {
        
        [(PPPinpointPinAnnotationView *)view loadStreetViewImage];
        
    }
    
}

#pragma mark - NSNotifications

-(void)managedObjectsChanged:(NSNotification *)notification {
    
    NSSet *updatedObjects = [[notification userInfo] objectForKey:NSDeletedObjectsKey];
    
    // iterate through managed objects
    for (NSManagedObject *object in updatedObjects) {
        
        if ([object isKindOfClass:[PPPinpoint class]]) {
            
            // check if the shown annotations contain the pinpoint
            for (id <MKAnnotation> annotation in [self annotations]) {
                
                if ([annotation isKindOfClass:[PPPinpointAnnotation class]]) {
                    
                    // is that pinpoint the deleted one?  if so delete it
                    if ([(PPPinpointAnnotation *)annotation pinpoint] == object) {
                        
                        [self removeAnnotation:annotation];
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
}

@end
