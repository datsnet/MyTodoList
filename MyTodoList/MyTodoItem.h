//
//  MyTodoItem.h
//  MyTodoList
//
//  Created by 熱海 大介 on 2014/08/13.
//  Copyright (c) 2014年 com.datsnet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyTodoItem : NSObject <NSCopying>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *note;
@property (nonatomic) NSInteger priority;
@property (nonatomic) BOOL completed;


@end
