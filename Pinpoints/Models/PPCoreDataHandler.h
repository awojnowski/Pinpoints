//
//  PPCoreData.h
//  Pinpoints
//
//  Created by Aaron Wojnowski on 2014-04-25.
//  Copyright (c) 2014 aaron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPCoreDataHandler : NSObject

@property (nonatomic, readonly, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, readonly, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, readonly, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

-(void)saveContext;

+(PPCoreDataHandler *)sharedHandler;

@end
