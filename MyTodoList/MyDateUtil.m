//
//  MyDateUtil.m
//  MyTodoList
//
//  Created by 熱海 大介 on 2015/01/01.
//  Copyright (c) 2015年 com.datsnet. All rights reserved.
//

#import "MyDateUtil.h"

@implementation MyDateUtil

+ (NSDate *)stringToDate:(NSString *) dateString
{
    NSLog(@"dateString: %@", dateString);
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];

    // 書式が変わらないことが保証されている特別なlocaleを設定
    // ※和暦とかユーザーが設定していたら表記が変わるらしいので防止
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    formatter.locale = locale;
    //タイムゾーンの指定
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    NSDate *date = [formatter dateFromString:dateString];
    
    NSLog(@"date: %@",date);
    
    return date;
}

+ (NSString *)dateToString:(NSDate *) date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    formatter.locale = locale;
    
    //タイムゾーンの指定
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    NSString *stringFromDate = [formatter stringFromDate:date];
    return stringFromDate;
}


@end