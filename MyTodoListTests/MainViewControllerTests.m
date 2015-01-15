//
//  MainViewControllerTests.m
//  MyTodoList
//
//  Created by 熱海大介 on 2015/01/15.
//  Copyright (c) 2015年 com.datsnet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "MainViewController.h"

@interface MainViewControllerTests : XCTestCase

@end

@implementation MainViewControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)getTodoData {
    MyCoreDataManager *manager = [MyCoreDataManager sharedManager];
    NSMutableArray *todos = [manager all:@"Todo"];
    XCTAssertTrue(todos.count == 0 || todos.count > 0);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
