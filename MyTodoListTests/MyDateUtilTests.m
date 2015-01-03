//
//  MyDateUtilTests.m
//  MyTodoList
//
//  Created by 熱海 大介 on 2015/01/02.
//  Copyright (c) 2015年 com.datsnet. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MyDateUtil.h"

@interface MyDateUtilTests : XCTestCase

@end

@implementation MyDateUtilTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testStringToDate {

    NSDate *date = [MyDateUtil stringToDate:@"2020-08-31"];
    XCTAssertNotNil(date);
}

- (void)testDateToString {
    NSString *dateString = @"2020-09-30";
    NSDate *date = [MyDateUtil stringToDate:dateString];

    NSString *convert = [MyDateUtil dateToString:date];
    XCTAssertEqualObjects(dateString, convert);
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
