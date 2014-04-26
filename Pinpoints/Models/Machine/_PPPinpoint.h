// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PPPinpoint.h instead.

#import <CoreData/CoreData.h>


extern const struct PPPinpointAttributes {
	__unsafe_unretained NSString *address;
	__unsafe_unretained NSString *caption;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *visited;
} PPPinpointAttributes;

extern const struct PPPinpointRelationships {
	__unsafe_unretained NSString *category;
} PPPinpointRelationships;

extern const struct PPPinpointFetchedProperties {
} PPPinpointFetchedProperties;

@class PPCategory;






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





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* visited;



@property BOOL visitedValue;
- (BOOL)visitedValue;
- (void)setVisitedValue:(BOOL)value_;

//- (BOOL)validateVisited:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) PPCategory *category;

//- (BOOL)validateCategory:(id*)value_ error:(NSError**)error_;





@end

@interface _PPPinpoint (CoreDataGeneratedAccessors)

@end

@interface _PPPinpoint (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveAddress;
- (void)setPrimitiveAddress:(NSString*)value;




- (NSString*)primitiveCaption;
- (void)setPrimitiveCaption:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveVisited;
- (void)setPrimitiveVisited:(NSNumber*)value;

- (BOOL)primitiveVisitedValue;
- (void)setPrimitiveVisitedValue:(BOOL)value_;





- (PPCategory*)primitiveCategory;
- (void)setPrimitiveCategory:(PPCategory*)value;


@end
