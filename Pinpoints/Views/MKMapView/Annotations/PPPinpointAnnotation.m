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

-(void)dealloc {
    
    [self removeObservers];
    
}

#pragma mark - Getters & Setters

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

-(void)setPinpoint:(PPPinpoint *)pinpoint {
    
    [self removeObservers];
    
    _pinpoint = pinpoint;
    
    [self addObservers];
    
}

#pragma mark - KVO

-(void)addObservers {
    
    [[self pinpoint] addObserver:self forKeyPath:@"caption" options:0 context:NULL];
    [[self pinpoint] addObserver:self forKeyPath:@"name" options:0 context:NULL];
    
}

-(void)removeObservers {
    
    [[self pinpoint] removeObserver:self forKeyPath:@"caption"];
    [[self pinpoint] removeObserver:self forKeyPath:@"name"];
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (object == [self pinpoint]) {
        
        if ([keyPath isEqualToString:@"caption"]) {
            
            [self willChangeValueForKey:@"subtitle"];
            [self didChangeValueForKey:@"subtitle"];
            
        } else if ([keyPath isEqualToString:@"name"]) {
            
            [self willChangeValueForKey:@"title"];
            [self didChangeValueForKey:@"title"];
            
        }
        
    }
    
}

@end
