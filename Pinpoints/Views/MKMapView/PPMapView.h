//
//  PPMapView.h
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-26.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import <MapKit/MapKit.h>

@class PPGroup;

@interface PPMapView : MKMapView

@property (nonatomic, strong) PPGroup *group;

@end
