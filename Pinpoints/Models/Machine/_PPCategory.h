// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PPCategory.h instead.

#import <CoreData/CoreData.h>


extern const struct PPCategoryAttributes {
	__unsafe_unretained NSString *name;
} PPCategoryAttributes;

extern const struct PPCategoryRelationships {
	__unsafe_unretained NSString *pinpoints;
} PPCategoryRelationships;

extern const struct PPCategoryFetchedProperties {
} PPCategoryFetchedProperties;

@class PPPinpoint;



@interface PPCategoryID : NSManagedObjectID {}
@end

@interface _PPCategory : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PPCategoryID*)objectID;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *pinpoints;

- (NSMutableSet*)pinpointsSet;





@end

@interface _PPCategory (CoreDataGeneratedAccessors)

- (void)addPinpoints:(NSSet*)value_;
- (void)removePinpoints:(NSSet*)value_;
- (void)addPinpointsObject:(PPPinpoint*)value_;
- (void)removePinpointsObject:(PPPinpoint*)value_;

@end

@interface _PPCategory (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitivePinpoints;
- (void)setPrimitivePinpoints:(NSMutableSet*)value;


@end
