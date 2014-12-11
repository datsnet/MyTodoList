//
//  DatePickerViewController.m
//  MyTodoList
//
//  Created by 熱海 大介 on 2014/11/16.
//  Copyright (c) 2014年 com.datsnet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "DatePickerViewController.h"

@interface DatePickerViewController ()

@end
@implementation DatePickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //    NSLog(@"%d",_datePickerMode);
    //    NSLog(@"\n%@",_pickerName);
    // 日付の表示モードを変更する(時分を表示)
    _datePicker.datePickerMode = _datePickerMode;
    
    // 日付ピッカーの値が変更されたときに呼ばれるメソッドを設定
    [_datePicker addTarget:self
                    action:@selector(datePickerValueChanged:)
          forControlEvents:UIControlEventValueChanged];
    
    [_datePicker setMinimumDate:_minDate];
    [_datePicker setMaximumDate:_maxDate];
    
    // 初期値
    if (_iniDate != nil) {
        [_datePicker setDate:_iniDate];
    }
    
    // 背景だけ透過
    UIColor *alphaColor = [self.view.backgroundColor colorWithAlphaComponent:0.2]; //透過率
    self.view.backgroundColor = alphaColor;
    // button だけ透過
    UIColor *alphaColor2 = [self.closeButton.backgroundColor colorWithAlphaComponent:0.2]; //透過率
    self.closeButton.backgroundColor = alphaColor2;
    // UIDatepicker だけ非透過
    self.datePicker.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)getFormat{
    if (_datePickerMode == UIDatePickerModeDateAndTime) {
        return @"yyyy/MM/dd HH:mm";
    } else {
        return @"yyyy/MM/dd";
    }
}

/**
 * 日付ピッカーの値が変更されたとき
 */
- (void)datePickerValueChanged:(id)sender
{
    // デリゲート先の処理を呼び出し、選択された文字列を親Viewに表示させる
    //[self.delegate applySelectedString:_datePicker.date];
}

// 空の領域にある透明なボタンがタップされたときに呼び出されるメソッド
- (IBAction)closePickerView:(id)sender {
    // デリゲート先の処理を呼び出し、選択された文字列を親Viewに表示させる
    [self.delegate applySelectedString:_datePicker.date];
    
    // datePickerを閉じるための処理を呼び出す
    [self.delegate closePickerView:self];
    
}
@end