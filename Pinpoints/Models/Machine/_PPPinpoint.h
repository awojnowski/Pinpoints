// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PPPinpoint.h instead.

#import <CoreData/CoreData.h>


extern const struct PPPinpointAttributes {
	__unsafe_unretained NSString *address;
	__unsafe_unretained NSString *caption;
	__unsafe_unretained NSString *latitude;
	__unsafe_unretained NSString *longitude;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *visited;
} PPPinpointAttributes;

extern const struct PPPinpointRelationships {
	__unsafe_unretained NSString *group;
} PPPinpointRelationships;

extern const struct PPPinpointFetchedProperties {
} PPPinpointFetchedProperties;

@class PPGroup;








@interface PPPinpointID : NSManagedObjectID {}
@end

@interface _PPPinpoint : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PPPinpointID*)objectID;





@property (nonatomic, strong) NSString* address;



//- (BOOL)validateAddress:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* caption;



//- (BOOL)validateCaption:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* latitude;



@property float latitudeValue;
- (float)latitudeValue;
- (void)setLatitudeValue:(float)value_;

//- (BOOL)validateLatitude:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* longitude;



@property float longitudeValue;
- (float)longitudeValue;
- (void)setLongitudeValue:(float)value_;

//- (BOOL)validateLongitude:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* visited;



@property BOOL visitedValue;
- (BOOL)visitedValue;
- (void)setVisitedValue:(BOOL)value_;

//- (BOOL)validateVisited:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) PPGroup *group;

//- (BOOL)validateGroup:(id*)value_ error:(NSError**)error_;





@end

@interface _PPPinpoint (CoreDataGeneratedAccessors)

@end

@interface _PPPinpoint (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveAddress;
- (void)setPrimitiveAddress:(NSString*)value;




- (NSString*)primitiveCaption;
- (void)setPrimitiveCaption:(NSString*)value;




- (NSNumber*)primitiveLatitude;
- (void)setPrimitiveLatitude:(NSNumber*)value;

- (float)primitiveLatitudeValue;
- (void)setPrimitiveLatitudeValue:(float)value_;




- (NSNumber*)primitiveLongitude;
- (void)setPrimitiveLongitude:(NSNumber*)value;

- (float)primitiveLongitudeValue;
- (void)setPrimitiveLongitudeValue:(float)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveVisited;
- (void)setPrimitiveVisited:(NSNumber*)value;

- (BOOL)primitiveVisitedValue;
- (void)setPrimitiveVisitedValue:(BOOL)value_;





- (PPGroup*)primitiveGroup;
- (void)setPrimitiveGroup:(PPGroup*)value;


@end
