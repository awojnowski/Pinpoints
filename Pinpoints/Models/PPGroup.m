#import "PPCoreDataHandler.h"
#import "PPGroup.h"

@interface PPGroup ()



@end

@implementation PPGroup

#pragma mark - Getters & Setters

-(NSArray *)pinpointsArray {
    
    NSArray *pinpoints = [[self pinpoints] allObjects];
    pinpoints = [pinpoints sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        return [[obj1 name] compare:[obj2 name]];
        
    }];
    return pinpoints;
    
}

-(NSString *)description {
    
    return [NSString stringWithFormat:@"<PPGroup: %p> %@",self,[self name]];
    
}

#pragma mark - Class Methods

+(NSArray *)allGroups {
    
    NSManagedObjectContext *managedObjectContext = [[PPCoreDataHandler sharedHandler] managedObjectContext];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PPGroup" inManagedObjectContext:managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"group = nil"]];
    
    NSArray *results = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
    return results;
    
}

+(PPGroup *)createGroupWithName:(NSString *)name {
    
    // check to see that the group isn't taken
    
    NSInteger iteration = 1;
    NSString *originalName = [NSString stringWithString:name];
    
    while ([PPGroup groupWithName:name] != nil) {
        
        name = [originalName stringByAppendingFormat:@"%ld",iteration];
        iteration ++;
        
    }
    
    // create the group
    
    PPGroup *group = (PPGroup *)[NSEntityDescription insertNewObjectForEntityForName:@"PPGroup" inManagedObjectContext:[[PPCoreDataHandler sharedHandler] managedObjectContext]];
    [group setName:name];
    return group;
    
}

+(PPGroup *)groupWithName:(NSString *)name {
    
    NSManagedObjectContext *managedObjectContext = [[PPCoreDataHandler sharedHandler] managedObjectContext];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PPGroup" inManagedObjectContext:managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchLimit:1];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"name = %@",name]];
    
    NSArray *results = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
    return [results firstObject];
    
}

@end
