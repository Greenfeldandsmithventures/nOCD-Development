//
//  DateBaseManager.m
//  nOCD
//
//  Created by Argam on 7/27/15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import "DateBaseManager.h"
#import "MDDictionaryManager.h"

static DateBaseManager* instance = nil;

@implementation DateBaseManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+(DateBaseManager*) sharedInstance {
    if (!instance) {
        instance = [[DateBaseManager alloc] init];
    }
    
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)saveResponseInfo:(NSDictionary*) info
{
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    user.userID = [info valueForKey:@"userID"];
    user.userName = [info valueForKey:@"userName"];
    user.password = [info valueForKey:@"password"];
    user.firstName = [info valueForKey:@"firstName"];
    user.lastName = [info valueForKey:@"lastName"];
    user.email = [info valueForKey:@"email"];
    user.paymentType = [info valueForKey:@"paymentType"];
//    user.payed = [info valueForKey:@"payed"];
    [self saveContext];
    
    NSArray *obsessions = info[@"obsessions"];
    for (int i = 0; i < obsessions.count; i++)
    {
        NSDictionary *dic = obsessions[i];
        Obsession *model = [NSEntityDescription insertNewObjectForEntityForName:@"Obsession" inManagedObjectContext:self.managedObjectContext];
        model.obsessionID = [dic valueForKey:@"obsessionID"];
        model.userID = [dic valueForKey:@"userID"];
        model.obsession = [dic valueForKey:@"obsession"];
    }
    
    [self saveContext];
    
    NSArray *compulsions = info[@"compulsions"];
    for (int i = 0; i < compulsions.count; i++)
    {
        NSDictionary *dic = compulsions[i];
        Compulsion *model = [NSEntityDescription insertNewObjectForEntityForName:@"Compulsion" inManagedObjectContext:self.managedObjectContext];
        model.obsessionID = [dic valueForKey:@"obsessionID"];
        model.compulsionID = [dic valueForKey:@"compulsionID"];
        model.compulsion = [dic valueForKey:@"compulsion"];
    }
    
    [self saveContext];
    
    NSArray *triggers = info[@"triggers"];
    for (int i = 0; i < triggers.count; i++)
    {
        NSDictionary *dic = triggers[i];
        Trigger *trigger = [NSEntityDescription insertNewObjectForEntityForName:@"Trigger" inManagedObjectContext:self.managedObjectContext];
        trigger.obsessionID = [dic valueForKey:@"obsessionID"];
        trigger.trigger = [dic valueForKey:@"trigger"];
        trigger.triggerID = [dic valueForKey:@"triggerID"];
    }
    
    [self saveContext];
    
    NSArray *favorites = info[@"favorites"];
    
    NSArray *arr = [favorites valueForKey:@"hobbies"];
    for (int i = 0; i < arr.count; i++)
    {
        NSDictionary *dic = arr[i];
        Hobbies *model = [NSEntityDescription insertNewObjectForEntityForName:@"Hobbies" inManagedObjectContext:self.managedObjectContext];
        model.hobbyID = [dic valueForKey:@"hobbyID"];
        model.userID = [dic valueForKey:@"userID"];
        model.hobby = [dic valueForKey:@"hobby"];
    }
    
    [self saveContext];
    
    arr = [favorites valueForKey:@"apps"];
    for (int i = 0; i < arr.count; i++)
    {
        NSDictionary *dic = arr[i];
        Apps *model = [NSEntityDescription insertNewObjectForEntityForName:@"Apps" inManagedObjectContext:self.managedObjectContext];
        model.appID = [dic valueForKey:@"appID"];
        model.userID = [dic valueForKey:@"userID"];
        model.app = [dic valueForKey:@"app"];
    }
    [self saveContext];
    
    arr = [favorites valueForKey:@"tasks"];
    for (int i = 0; i < arr.count; i++)
    {
        NSDictionary *dic = arr[i];
        Tasks *model = [NSEntityDescription insertNewObjectForEntityForName:@"Tasks" inManagedObjectContext:self.managedObjectContext];
        model.taskID = [dic valueForKey:@"taskID"];
        model.userID = [dic valueForKey:@"userID"];
        model.task = [dic valueForKey:@"task"];
    }
    [self saveContext];
    
    arr = [favorites valueForKey:@"interests"];
    for (int i = 0; i < arr.count; i++)
    {
        NSDictionary *dic = arr[i];
        Interests *model = [NSEntityDescription insertNewObjectForEntityForName:@"Interests" inManagedObjectContext:self.managedObjectContext];
        model.interestID = [dic valueForKey:@"interestID"];
        model.userID = [dic valueForKey:@"userID"];
        model.interest = [dic valueForKey:@"interest"];
    }
    [self saveContext];
}

- (NSArray*)fetchObsessions
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Obsession"];
    
    NSError * error = nil;
    NSArray * expArray = [self.managedObjectContext executeFetchRequest:request error:&error];
    return expArray;
}

- (NSArray*)fetchCompulsions
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Compulsion"];
    
    NSError * error = nil;
    NSArray * expArray = [self.managedObjectContext executeFetchRequest:request error:&error];
    return expArray;
}

- (NSArray*)fetchTriggersByObsID:(NSString*) obsID
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.predicate = [NSPredicate predicateWithFormat:@"obsessionID == %@", obsID];
    [request setEntity:[NSEntityDescription entityForName:@"Trigger" inManagedObjectContext:self.managedObjectContext]];
    
    NSError * error = nil;
    NSArray * expArray = [self.managedObjectContext executeFetchRequest:request error:&error];
    return expArray;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"nOCD" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"nOCD.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
