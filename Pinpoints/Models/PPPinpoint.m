#import "PPCoreDataHandler.h"
#import "PPGroup.h"
#import "PPPinpoint.h"

@interface PPPinpoint ()



@end

@implementation PPPinpoint

-(CLLocationCoordinate2D)coordinate {
    
    return CLLocationCoordinate2DMake([self latitudeValue], [self longitudeValue]);
    
}

-(BOOL)isVisited {
    
    return [self visitedValue];
    
}

#pragma mark - Class Methods

+(PPPinpoint *)createPinpointInGroup:(PPGroup *)group {
    
    PPPinpoint *pinpoint = (PPPinpoint *)[NSEntityDescription insertNewObjectForEntityForName:@"PPPinpoint" inManagedObjectContext:[[PPCoreDataHandler sharedHandler] managedObjectContext]];
    [pinpoint setName:@"Unnamed Pinpoint"];
    [group addPinpointsObject:pinpoint];
    return pinpoint;
    
}

@end
