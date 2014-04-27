// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PPGroup.h instead.

#import <CoreData/CoreData.h>


extern const struct PPGroupAttributes {
	__unsafe_unretained NSString *hidden;
	__unsafe_unretained NSString *name;
} PPGroupAttributes;

extern const struct PPGroupRelationships {
	__unsafe_unretained NSString *pinpoints;
} PPGroupRelationships;

extern const struct PPGroupFetchedProperties {
} PPGroupFetchedProperties;

@class PPPinpoint;




@interface PPGroupID : NSManagedObjectID {}
@end

@interface _PPGroup : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PPGroupID*)objectID;





@property (nonatomic, strong) NSNumber* hidden;



@property BOOL hiddenValue;
- (BOOL)hiddenValue;
- (void)setHiddenValue:(BOOL)value_;

//- (BOOL)validateHidden:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *pinpoints;

- (NSMutableSet*)pinpointsSet;





@end

@interface _PPGroup (CoreDataGeneratedAccessors)

- (void)addPinpoints:(NSSet*)value_;
- (void)removePinpoints:(NSSet*)value_;
- (void)addPinpointsObject:(PPPinpoint*)value_;
- (void)removePinpointsObject:(PPPinpoint*)value_;

@end

@interface _PPGroup (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveHidden;
- (void)setPrimitiveHidden:(NSNumber*)value;

- (BOOL)primitiveHiddenValue;
- (void)setPrimitiveHiddenValue:(BOOL)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitivePinpoints;
- (void)setPrimitivePinpoints:(NSMutableSet*)value;


@end
