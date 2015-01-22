//
//  MyCoreDataManager.m
//  MyTodoList
//
//  Created by 熱海大介 on 2015/01/13.
//  Copyright (c) 2015年 com.datsnet. All rights reserved.
//

#import "MyCoreDataManager.h"

@implementation MyCoreDataManager
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+(id)sharedManager
{
    static MyCoreDataManager* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(id)init
{
    if(self = [super init])
    {
        //initialize
    }
    return self;
}

-(void)dealloc
{
    //Should never be called, but just here for clarity really.
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


#pragma mark - Entity Access Methods
-(NSMutableArray *)all:(NSString *)entityName
{
    return [self fetch:entityName limit:0];
}

-(NSMutableArray *)all:(NSString *)entityName sortKey:(NSString *)key
{
    return [self fetch:entityName sortKey:key limit:0 ascending:NO];
}

-(NSMutableArray *)all:(NSString *)entityName sortKey:(NSString *)key ascending:(BOOL)ascending
{
    return [self fetch:entityName sortKey:key limit:0 ascending:ascending];
}

-(NSMutableArray *)fetch:(NSString *)entityName limit:(int)limit
{
    return [self fetch:entityName sortKey:nil limit:limit ascending:NO];
}

-(NSMutableArray *)fetch:(NSString *)entityName sortKey:(NSString *)key limit:(int)limit ascending:(BOOL)ascending
{
    NSManagedObjectContext* context = self.managedObjectContext;
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    [request setEntity:entity];
    if(key != nil)
    {
        NSSortDescriptor* sort = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
        [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    }
    
    [request setFetchLimit:limit];
    
    NSError* error = nil;
    NSMutableArray* mutableFetchResults = [[context executeFetchRequest:request error:&error] mutableCopy];
    if(mutableFetchResults == nil)
    {
        NSLog(@"Fetch Error");
    }
    return mutableFetchResults;
    
}


-(NSManagedObject *)entityForInsert:(NSString *)entityName
{
    NSManagedObjectContext* context = self.managedObjectContext;
    return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:context];
}

#pragma mark - Core Data stack

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

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MBCore Data.sqlite"];
    NSLog(@"storeURL : %@", storeURL);
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
