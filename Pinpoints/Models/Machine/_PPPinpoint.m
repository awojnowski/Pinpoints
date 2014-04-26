// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PPPinpoint.m instead.

#import "_PPPinpoint.h"

const struct PPPinpointAttributes PPPinpointAttributes = {
	.address = @"address",
	.caption = @"caption",
	.name = @"name",
	.visited = @"visited",
};

const struct PPPinpointRelationships PPPinpointRelationships = {
	.category = @"category",
};

const struct PPPinpointFetchedProperties PPPinpointFetchedProperties = {
};

@implementation PPPinpointID
@end

@implementation _PPPinpoint

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PPPinpoint" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PPPinpoint";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PPPinpoint" inManagedObjectContext:moc_];
}

- (PPPinpointID*)objectID {
	return (PPPinpointID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"visitedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"visited"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic address;






@dynamic caption;






@dynamic name;






@dynamic visited;



- (BOOL)visitedValue {
	NSNumber *result = [self visited];
	return [result boolValue];
}

- (void)setVisitedValue:(BOOL)value_ {
	[self setVisited:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveVisitedValue {
	NSNumber *result = [self primitiveVisited];
	return [result boolValue];
}

- (void)setPrimitiveVisitedValue:(BOOL)value_ {
	[self setPrimitiveVisited:[NSNumber numberWithBool:value_]];
}





@dynamic category;

	






@end
