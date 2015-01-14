//
//  Tag.h
//  MyTodoList
//
//  Created by 熱海大介 on 2015/01/14.
//  Copyright (c) 2015年 com.datsnet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Todo;

@interface Tag : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * sort;
@property (nonatomic, retain) Todo *todo;

@end
