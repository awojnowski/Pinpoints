// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PPGroup.m instead.

#import "_PPGroup.h"

const struct PPGroupAttributes PPGroupAttributes = {
	.name = @"name",
};

const struct PPGroupRelationships PPGroupRelationships = {
	.group = @"group",
	.groups = @"groups",
	.pinpoints = @"pinpoints",
};

const struct PPGroupFetchedProperties PPGroupFetchedProperties = {
};

@implementation PPGroupID
@end

@implementation _PPGroup

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PPGroup" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PPGroup";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PPGroup" inManagedObjectContext:moc_];
}

- (PPGroupID*)objectID {
	return (PPGroupID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic name;






@dynamic group;

	

@dynamic groups;

	
- (NSMutableSet*)groupsSet {
	[self willAccessValueForKey:@"groups"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"groups"];
  
	[self didAccessValueForKey:@"groups"];
	return result;
}
	

@dynamic pinpoints;

	
- (NSMutableSet*)pinpointsSet {
	[self willAccessValueForKey:@"pinpoints"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"pinpoints"];
  
	[self didAccessValueForKey:@"pinpoints"];
	return result;
}
	






@end
