// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PPCategory.m instead.

#import "_PPCategory.h"

const struct PPCategoryAttributes PPCategoryAttributes = {
	.name = @"name",
};

const struct PPCategoryRelationships PPCategoryRelationships = {
	.pinpoints = @"pinpoints",
};

const struct PPCategoryFetchedProperties PPCategoryFetchedProperties = {
};

@implementation PPCategoryID
@end

@implementation _PPCategory

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PPCategory" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PPCategory";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PPCategory" inManagedObjectContext:moc_];
}

- (PPCategoryID*)objectID {
	return (PPCategoryID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic name;






@dynamic pinpoints;

	
- (NSMutableSet*)pinpointsSet {
	[self willAccessValueForKey:@"pinpoints"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"pinpoints"];
  
	[self didAccessValueForKey:@"pinpoints"];
	return result;
}
	






@end
