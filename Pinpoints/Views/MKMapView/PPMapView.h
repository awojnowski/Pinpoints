//
//  PPMapView.h
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-26.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import <MapKit/MapKit.h>

@class PPGroup, PPPinpoint;

@protocol PPMapViewDelegate;

@interface PPMapView : MKMapView

@property (nonatomic, weak) id <PPMapViewDelegate> mapDelegate;

-(void)refreshVisibleGroups;
-(void)zoomToPinpoint:(PPPinpoint *)pinpoint;

@end

@protocol PPMapViewDelegate <NSObject>

@optional
-(void)mapView:(PPMapView *)mapView didPlacePinpoint:(PPPinpoint *)pinpoint;
-(void)mapView:(PPMapView *)mapView didViewPinpoint:(PPPinpoint *)pinpoint;

@end
