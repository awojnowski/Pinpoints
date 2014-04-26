// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PPPinpoint.m instead.

#import "_PPPinpoint.h"

const struct PPPinpointAttributes PPPinpointAttributes = {
	.address = @"address",
	.caption = @"caption",
	.latitude = @"latitude",
	.longitude = @"longitude",
	.name = @"name",
	.visited = @"visited",
};

const struct PPPinpointRelationships PPPinpointRelationships = {
	.group = @"group",
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
	
	if ([key isEqualToString:@"latitudeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"latitude"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"longitudeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"longitude"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"visitedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"visited"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic address;






@dynamic caption;






@dynamic latitude;



- (float)latitudeValue {
	NSNumber *result = [self latitude];
	return [result floatValue];
}

- (void)setLatitudeValue:(float)value_ {
	[self setLatitude:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveLatitudeValue {
	NSNumber *result = [self primitiveLatitude];
	return [result floatValue];
}

- (void)setPrimitiveLatitudeValue:(float)value_ {
	[self setPrimitiveLatitude:[NSNumber numberWithFloat:value_]];
}





@dynamic longitude;



- (float)longitudeValue {
	NSNumber *result = [self longitude];
	return [result floatValue];
}

- (void)setLongitudeValue:(float)value_ {
	[self setLongitude:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveLongitudeValue {
	NSNumber *result = [self primitiveLongitude];
	return [result floatValue];
}

- (void)setPrimitiveLongitudeValue:(float)value_ {
	[self setPrimitiveLongitude:[NSNumber numberWithFloat:value_]];
}





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





@dynamic group;

	






@end
