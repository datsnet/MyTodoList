//
//  MyBaseUIViewController.m
//  MyTodoList
//
//  Created by 熱海 大介 on 2014/08/14.
//  Copyright (c) 2014年 com.datsnet. All rights reserved.
//

#import "MyBaseUIViewController.h"
@interface MyBaseUIViewController()


@end

@implementation MyBaseUIViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.revealButtonItem setTarget: self.revealViewController];
    [self.revealButtonItem setAction: @selector( revealToggle: )];
    SWRevealViewController *revealController = [self revealViewController];
    
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
//    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
//    [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];

}
@end
