//
//  MainViewController.h
//  MyTodoList
//
//  Created by 熱海 大介 on 2014/07/05.
//  Copyright (c) 2014年 com.datsnet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBaseUIViewController.h"
#import "MyCoreDataManager.h"
#import "Todo.h"
#import "TodoTableViewCell.h"

@interface MainViewController : MyBaseUIViewController
@property (weak, nonatomic) IBOutlet UITextField *todoTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
- (IBAction)editButtonAction:(id)sender;

- (IBAction)todoTextEditingDidEnd:(id)sender;


@end
