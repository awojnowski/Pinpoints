#import "_PPGroup.h"

@interface PPGroup : _PPGroup {}

+(NSArray *)allGroups;

+(PPGroup *)createGroupWithName:(NSString *)name;
+(PPGroup *)groupWithName:(NSString *)name;

@end
