//
//  DetailViewController.h
//  MyTodoList
//
//  Created by 熱海 大介 on 2014/11/16.
//  Copyright (c) 2014年 com.datsnet. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "DatePickerViewController.h"
@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeButton;
- (IBAction)closeButton:(id)sender;


// 呼び出すPickerViewControllerのポインタ　※strongを指定してポインタを掴んでおかないと解放されてしまう
@property (strong, nonatomic) DatePickerViewController *datePickerViewController;
@end
