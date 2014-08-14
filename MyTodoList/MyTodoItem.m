//
//  MyTodoItem.m
//  MyTodoList
//
//  Created by 熱海 大介 on 2014/08/13.
//  Copyright (c) 2014年 com.datsnet. All rights reserved.
//

#import "MyTodoItem.h"

@implementation MyTodoItem

- (id)copyWithZone:(NSZone *)zone
{
    MyTodoItem *copiedObject = [[[self class] allocWithZone:zone] init];
    if (copiedObject) {
        copiedObject->_title = [_title copyWithZone:zone];
        copiedObject->_note = [_note copyWithZone:zone];
        copiedObject->_priority = _priority;
        copiedObject->_completed = _completed;
    }
    return copiedObject;
}

@end
