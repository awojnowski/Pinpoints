#import "PPCoreDataHandler.h"
#import "PPGroup.h"
#import "PPPinpoint.h"

#import <AddressBookUI/AddressBookUI.h>
#import <CoreLocation/CoreLocation.h>

@interface PPPinpoint ()

@property (nonatomic, strong) CLGeocoder *geocoder;

@end

@implementation PPPinpoint

@synthesize geocoder=_geocoder;

#pragma mark - Helper Methods

-(void)fetchAddressFromCoordinate {
    
    if (![self geocoder]) {
        
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [self setGeocoder:geocoder];
        
    } else {
        
        [[self geocoder] cancelGeocode];
        
    }
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[self latitudeValue] longitude:[self longitudeValue]];
    
    [[self geocoder] reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (!error) {
            
            CLPlacemark *placemark = [placemarks firstObject];
            
            NSString *address = ABCreateStringWithAddressDictionary([placemark addressDictionary], YES);
            [self setAddress:address];
            
            NSLog(@"Found new address: %@",address);
            
        } else {
            
            NSLog(@"Error while finding address: %@",error);
            
        }
        
    }];
    
}

#pragma mark - Getters & Setters

-(CLLocationCoordinate2D)coordinate {
    
    return CLLocationCoordinate2DMake([self latitudeValue], [self longitudeValue]);
    
}

-(BOOL)isVisited {
    
    return [self visitedValue];
    
}

-(NSURL *)streetViewURLWithSize:(CGSize)size {
    
    NSString *urlString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/streetview?size=%0.0fx%0.0f&location=%f,%f&fov=90&heading=235&pitch=10&sensor=false",size.width,size.height,[self latitudeValue],[self longitudeValue]];
    return [NSURL URLWithString:urlString];
    
}

#pragma mark - Class Methods

+(PPPinpoint *)createPinpointInGroup:(PPGroup *)group {
    
    PPPinpoint *pinpoint = (PPPinpoint *)[NSEntityDescription insertNewObjectForEntityForName:@"PPPinpoint" inManagedObjectContext:[[PPCoreDataHandler sharedHandler] managedObjectContext]];
    [pinpoint setName:@"Unnamed Pinpoint"];
    [group addPinpointsObject:pinpoint];
    [pinpoint setGroup:group];
        
    return pinpoint;
    
}

@end
