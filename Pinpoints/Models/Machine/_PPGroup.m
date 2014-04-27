// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PPGroup.m instead.

#import "_PPGroup.h"

const struct PPGroupAttributes PPGroupAttributes = {
	.hidden = @"hidden",
	.name = @"name",
};

const struct PPGroupRelationships PPGroupRelationships = {
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
	
	if ([key isEqualToString:@"hiddenValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"hidden"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic hidden;



- (BOOL)hiddenValue {
	NSNumber *result = [self hidden];
	return [result boolValue];
}

- (void)setHiddenValue:(BOOL)value_ {
	[self setHidden:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveHiddenValue {
	NSNumber *result = [self primitiveHidden];
	return [result boolValue];
}

- (void)setPrimitiveHiddenValue:(BOOL)value_ {
	[self setPrimitiveHidden:[NSNumber numberWithBool:value_]];
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
