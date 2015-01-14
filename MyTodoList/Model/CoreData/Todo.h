//
//  Todo.h
//  MyTodoList
//
//  Created by 熱海大介 on 2015/01/14.
//  Copyright (c) 2015年 com.datsnet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Tag;

@interface Todo : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * complete;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSNumber * favorite;
@property (nonatomic, retain) NSDate * limitedDate;
@property (nonatomic, retain) NSDate * reminderDate;
@property (nonatomic, retain) NSNumber * sort;
@property (nonatomic, retain) NSSet *tag;
@end

@interface Todo (CoreDataGeneratedAccessors)

- (void)addTagObject:(Tag *)value;
- (void)removeTagObject:(Tag *)value;
- (void)addTag:(NSSet *)values;
- (void)removeTag:(NSSet *)values;

@end
