//
//  DateBaseManager.h
//  nOCD
//
//  Created by Argam on 7/27/15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "User.h"
#import "Trigger.h"
#import "Interests.h"
#import "Obsession.h"
#import "Tasks.h"
#import "Apps.h"
#import "Hobbies.h"
#import "Compulsion.h"

@interface DateBaseManager : NSObject


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


+(DateBaseManager*) sharedInstance;
- (void)saveContext;
- (void)saveResponseInfo:(NSDictionary*) info;

- (NSArray*)fetchObsessions;
- (NSArray*)fetchCompulsions;
- (NSArray*)fetchTriggersByObsID:(NSString*) obsID;
@end
