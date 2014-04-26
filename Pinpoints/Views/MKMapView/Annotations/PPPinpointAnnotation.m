//
//  PPPinpointAnnotation.m
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-26.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import "PPPinpointAnnotation.h"

#import "PPPinpoint.h"

@implementation PPPinpointAnnotation

-(NSString *)title {
    
    return [[self pinpoint] name];
    
}

-(NSString *)subtitle {
    
    return [[self pinpoint] caption];
    
}

-(CLLocationCoordinate2D)coordinate {
    
    return [[self pinpoint] coordinate];
    
}

-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    
    [[self pinpoint] setLongitudeValue:newCoordinate.longitude];
    [[self pinpoint] setLatitudeValue:newCoordinate.latitude];
    
}

@end
