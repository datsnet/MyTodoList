//
//  MyDateUtil.h
//  MyTodoList
//
//  Created by 熱海 大介 on 2015/01/02.
//  Copyright (c) 2015年 com.datsnet. All rights reserved.
//

@interface MyDateUtil : NSObject
+ (NSDate *)stringToDate:(NSString *) dateString;
+ (NSString *)dateToString:(NSDate *) date;
@end
