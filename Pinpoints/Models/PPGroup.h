#import "_PPGroup.h"

@interface PPGroup : _PPGroup {}

@property (nonatomic, assign, getter = isExpanded) BOOL expanded;

-(NSArray *)pinpointsArray;

+(NSArray *)allGroups;

+(PPGroup *)createGroupWithName:(NSString *)name;
+(PPGroup *)groupWithName:(NSString *)name;

@end
