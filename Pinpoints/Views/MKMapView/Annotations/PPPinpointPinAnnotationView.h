//
//  PPPinpointAnnotationView.h
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-26.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import <MapKit/MapKit.h>

@class PPPinpoint;

@interface PPPinpointPinAnnotationView : MKPinAnnotationView

@property (nonatomic, strong) PPPinpoint *pinpoint;

-(void)loadStreetViewImage;

@end
