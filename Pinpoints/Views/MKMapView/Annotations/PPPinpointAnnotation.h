//
//  PPPinpointAnnotation.h
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-26.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class PPPinpoint;

@interface PPPinpointAnnotation : NSObject <MKAnnotation>

@property (nonatomic, strong) PPPinpoint *pinpoint;

@end
