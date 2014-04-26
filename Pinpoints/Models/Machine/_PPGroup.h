// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PPGroup.h instead.

#import <CoreData/CoreData.h>


extern const struct PPGroupAttributes {
	__unsafe_unretained NSString *name;
} PPGroupAttributes;

extern const struct PPGroupRelationships {
	__unsafe_unretained NSString *group;
	__unsafe_unretained NSString *groups;
	__unsafe_unretained NSString *pinpoints;
} PPGroupRelationships;

extern const struct PPGroupFetchedProperties {
} PPGroupFetchedProperties;

@class PPGroup;
@class PPGroup;
@class PPPinpoint;



@interface PPGroupID : NSManagedObjectID {}
@end

@interface _PPGroup : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PPGroupID*)objectID;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) PPGroup *group;

//- (BOOL)validateGroup:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *groups;

- (NSMutableSet*)groupsSet;




@property (nonatomic, strong) NSSet *pinpoints;

- (NSMutableSet*)pinpointsSet;





@end

@interface _PPGroup (CoreDataGeneratedAccessors)

- (void)addGroups:(NSSet*)value_;
- (void)removeGroups:(NSSet*)value_;
- (void)addGroupsObject:(PPGroup*)value_;
- (void)removeGroupsObject:(PPGroup*)value_;

- (void)addPinpoints:(NSSet*)value_;
- (void)removePinpoints:(NSSet*)value_;
- (void)addPinpointsObject:(PPPinpoint*)value_;
- (void)removePinpointsObject:(PPPinpoint*)value_;

@end

@interface _PPGroup (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (PPGroup*)primitiveGroup;
- (void)setPrimitiveGroup:(PPGroup*)value;



- (NSMutableSet*)primitiveGroups;
- (void)setPrimitiveGroups:(NSMutableSet*)value;



- (NSMutableSet*)primitivePinpoints;
- (void)setPrimitivePinpoints:(NSMutableSet*)value;


@end
