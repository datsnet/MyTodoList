//
//  DateViewController.h
//  MyTodoList
//
//  Created by 熱海 大介 on 2014/11/16.
//  Copyright (c) 2014年 com.datsnet. All rights reserved.
//

#ifndef MyTodoList_DateViewController_h
#define MyTodoList_DateViewController_h


#endif


#import <UIKit/UIKit.h>

@protocol DatePickerViewControllerDelegate;

@interface DatePickerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

// 空の領域にある透明なボタン
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
// 設定しないボタン
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

// 処理のデリゲート先の参照
@property (weak, nonatomic) id<DatePickerViewControllerDelegate> delegate;

// PickerViewを閉じる処理を行うメソッド。closeButtonが押下されたときに呼び出される
- (IBAction)closePickerView:(id)sender;
- (IBAction)deleteButtonAction:(id)sender;


@property (nonatomic, assign) int datePickerMode;
@property (nonatomic, retain) NSString *pickerName;
@property (nonatomic, retain) NSDate *minDate;
@property (nonatomic, retain) NSDate *maxDate;
@property (nonatomic, retain) NSDate *iniDate; // 初期値
@end

@protocol DatePickerViewControllerDelegate <NSObject>
// 選択された文字列を適用するためのデリゲートメソッド
//-(void)applySelectedString:(NSString *)str;
-(void)applySelectedString:(NSDate *)date;
// 当該PickerViewを閉じるためのデリゲートメソッド
-(void)closePickerView:(DatePickerViewController *)controller;
// 設定しないボタン押下押されたときのデリゲートメソッド
-(void)deleteSetting;
@end