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
    [self.closeButton setTitle:@"" forState:UIControlStateNormal];
    
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
    [self.delegate applySelectedString:_datePicker.date];
}

// 空の領域にある透明なボタンがタップされたときに呼び出されるメソッド
- (IBAction)closePickerView:(id)sender {
    // デリゲート先の処理を呼び出し、選択された文字列を親Viewに表示させる
    [self.delegate applySelectedString:_datePicker.date];
    
    // datePickerを閉じるための処理を呼び出す
    [self.delegate closePickerView:self];
    [self closePickerView];
}

- (void) closePickerView
{
    // PickerViewをアニメーションを使ってゆっくり非表示にする
    UIView *pickerView = self.view;
    
    // アニメーション完了時のPickerViewの位置を計算
    CGSize offSize = [UIScreen mainScreen].bounds.size;
    CGPoint offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height * 1.5);
    
    [UIView beginAnimations:nil context:(void *)pickerView];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    // アニメーション終了時に呼び出す処理を設定
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    pickerView.center = offScreenCenter;
    [UIView commitAnimations];
}

// 単位のPickerViewを閉じるアニメーションが終了したときに呼び出されるメソッド
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    // PickerViewをサブビューから削除
    UIView *pickerView = (__bridge UIView *)context;
    [pickerView removeFromSuperview];
}

- (IBAction)deleteButtonAction:(id)sender
{
    [self closePickerView];
    // 設定しないボタン押下されたので通知
    [self.delegate deleteSetting];
}

@end