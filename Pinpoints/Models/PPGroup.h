#import "_PPGroup.h"

@interface PPGroup : _PPGroup {}

-(NSArray *)pinpointsArray;

+(NSArray *)allGroups;

+(PPGroup *)createGroupWithName:(NSString *)name;
+(PPGroup *)groupWithName:(NSString *)name;

@end
