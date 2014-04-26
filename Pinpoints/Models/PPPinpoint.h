#import "_PPPinpoint.h"

#import <MapKit/MapKit.h>

@interface PPPinpoint : _PPPinpoint {}

-(CLLocationCoordinate2D)coordinate;
-(BOOL)isVisited;

+(PPPinpoint *)createPinpointInGroup:(PPGroup *)group;

@end
