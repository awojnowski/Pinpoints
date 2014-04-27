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

#import "PPChooseGroupActionSheet.h"

#import "PPCoreDataHandler.h"
#import "PPGroup.h"
#import "PPPinpoint.h"

@interface PPMapView () <MKMapViewDelegate>

@property (nonatomic, strong) NSMutableArray *groups;

@end

@implementation PPMapView

-(void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

-(id)init {
    
    self = [super init];
    if (self) {
        
        [self setDelegate:self];
        [self setGroups:[NSMutableArray array]];
        
        UILongPressGestureRecognizer *addPinGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapHoldPin:)];
        [self addGestureRecognizer:addPinGestureRecognizer];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(managedObjectsChanged:) name:NSManagedObjectContextObjectsDidChangeNotification object:[[PPCoreDataHandler sharedHandler] managedObjectContext]];
        
        [self refreshVisibleGroups];
        
    }
    return self;
    
}

#pragma mark - Actions

-(void)createPinpointInGroup:(PPGroup *)group atCoordinate:(CLLocationCoordinate2D)coordinate {
    
    PPPinpoint *pinpoint = [PPPinpoint createPinpointInGroup:group];
    [pinpoint setLatitudeValue:coordinate.latitude];
    [pinpoint setLongitudeValue:coordinate.longitude];
    [pinpoint fetchAddressFromCoordinate];
    
    PPPinpointAnnotation *annotation = [[PPPinpointAnnotation alloc] init];
    [annotation setPinpoint:pinpoint];
    [self addAnnotation:annotation];
    
    if ([[self mapDelegate] respondsToSelector:@selector(mapView:didPlacePinpoint:)])
        [[self mapDelegate] mapView:self didPlacePinpoint:pinpoint];
    
}

-(void)createPinpointInAnyGroupAtCoordinate:(CLLocationCoordinate2D)coordinate {
    
    [self createPinpointInGroups:[PPGroup allGroups] atCoordinate:coordinate];
    
}

-(void)createPinpointInGroups:(NSArray *)groups atCoordinate:(CLLocationCoordinate2D)coordinate {
    
    PPChooseGroupActionSheet *chooseGroupActionSheet = [[PPChooseGroupActionSheet alloc] initWithGroups:groups];
    [chooseGroupActionSheet setChosenBlock:^(PPGroup *group) {
        
        [group setHiddenValue:NO];
        [self refreshVisibleGroups];
        
        [self createPinpointInGroup:group atCoordinate:coordinate];
        
    }];
    [chooseGroupActionSheet showInView:[self superview]];
    
}

-(void)handleTapHoldPin:(UILongPressGestureRecognizer *)gestureRecognizer {
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        
        CGPoint point = [gestureRecognizer locationInView:self];
        CLLocationCoordinate2D coordinate = [self convertPoint:point toCoordinateFromView:self];
        
        if ([[self groups] count] == 0) {
            
            [self createPinpointInAnyGroupAtCoordinate:coordinate];
            
        } else if ([[self groups] count] == 1) {
            
            [self createPinpointInGroup:[[self groups] firstObject] atCoordinate:coordinate];
            
        } else {
            
            [self createPinpointInGroups:[self groups] atCoordinate:coordinate];
            
        }
        
    }
    
}

#pragma mark - Group Management

-(void)refreshVisibleGroups {
    
    NSArray *allGroups = [PPGroup allGroups];
    for (PPGroup *group in allGroups) {
        
        if ([[self groups] containsObject:group]) {
            
            if ([group hiddenValue]) {
                
                [[self groups] removeObject:group];
                [self removePinpointsFromGroup:group];
                
            }
            
        } else {
            
            if (![group hiddenValue]) {
                
                [[self groups] addObject:group];
                [self addPinpointsFromGroup:group];
                
            }
            
        }
        
    }
    
}

-(void)addPinpointsFromGroup:(PPGroup *)group {
    
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

-(void)removePinpointsFromGroup:(PPGroup *)group {
    
    NSMutableArray *annotations = [NSMutableArray array];
    for (PPPinpoint *pinpoint in [[group pinpoints] allObjects]) {
        
        for (id <MKAnnotation> annotation in [self annotations]) {
            
            if ([annotation isKindOfClass:[PPPinpointAnnotation class]]) {
                
                if ([(PPPinpointAnnotation *)annotation pinpoint] == pinpoint) {
                    
                    [annotations addObject:annotation];
                    
                }
                
            }
            
        }
        
    }
    
    if ([annotations count] > 0) {
        
        [self removeAnnotations:annotations];
        
    }
    
}

#pragma mark - Pinpoint Management

-(void)zoomToPinpoint:(PPPinpoint *)pinpoint {
    
    [[pinpoint group] setHiddenValue:NO];
    [self refreshVisibleGroups];
    
    MKCoordinateRegion region;
    region.center.latitude = [pinpoint coordinate].latitude;
    region.center.longitude = [pinpoint coordinate].longitude;
    region.span.latitudeDelta = 0.01;
    region.span.longitudeDelta = 0.01;
    [self setRegion:region animated:YES];
    
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
    
    BOOL refreshGroups = NO;
    
    NSSet *deletedObjects = [[notification userInfo] objectForKey:NSDeletedObjectsKey];
    for (NSManagedObject *object in deletedObjects) {
        
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
            
        } else if ([object isKindOfClass:[PPGroup class]]) {
            
            refreshGroups = YES;
            
        }
        
    }
    
    NSSet *insertedObjects = [[notification userInfo] objectForKey:NSInsertedObjectsKey];
    for (NSManagedObject *object in insertedObjects) {
        
        if ([object isKindOfClass:[PPGroup class]]) {
            
            refreshGroups = YES;
            
        }
        
    }
    
    if (refreshGroups) {
        
        [self refreshVisibleGroups];
        
    }
    
}

@end
