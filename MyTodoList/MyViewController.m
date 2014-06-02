//
//  MyViewController.m
//  MyTodoList
//
//  Created by 熱海 大介 on 2014/06/01.
//  Copyright (c) 2014年 com.datsnet. All rights reserved.
//

#import "MyViewController.h"
#import <MMDrawerController.h>
#import "MySampleDrawer.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // 左、中央、右のビューコントローラを作成
    MySampleDrawer * leftDrawer = [[MySampleDrawer alloc] init];
    UIViewController * center = [[UIViewController alloc] init];
    UIViewController * rightDrawer = [[UIViewController alloc] init];// MMDrawerControllerオブジェクトを作成
    
    leftDrawer.view.backgroundColor = [UIColor redColor];
    MMDrawerController * drawerController = [[MMDrawerController alloc]
                                             initWithCenterViewController:center
                                             leftDrawerViewController:leftDrawer
                                             rightDrawerViewController:rightDrawer];
    [drawerController openDrawerGestureModeMask];
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
