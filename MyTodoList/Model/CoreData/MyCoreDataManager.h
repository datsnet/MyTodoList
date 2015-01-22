//
//  MyCoreDataManager.h
//  MyTodoList
//
//  Created by 熱海大介 on 2015/01/13.
//  Copyright (c) 2015年 com.datsnet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface MyCoreDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
-(NSMutableArray *)all:(NSString *)entityName;
-(NSMutableArray *)all:(NSString *)entityName sortKey:(NSString *)key;
-(NSMutableArray *)all:(NSString *)entityName sortKey:(NSString *)key ascending:(BOOL)ascending;
-(NSMutableArray *)fetch:(NSString *)entityName limit:(int)limit;
-(NSMutableArray *)fetch:(NSString *)entityName sortKey:(NSString *)key limit:(int)limit ascending:(BOOL)ascending;
-(NSManagedObject *)entityForInsert:(NSString *)entityName;

- (NSURL *)applicationDocumentsDirectory;

+ (id)sharedManager;

@end
