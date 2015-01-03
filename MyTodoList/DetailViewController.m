//
//  DetailViewController.m
//  MyTodoList
//
//  Created by 熱海 大介 on 2014/11/16.
//  Copyright (c) 2014年 com.datsnet. All rights reserved.
//
#import "DetailViewController.h"
#import "MyDateUtil.h"

@interface DetailViewController() <UITableViewDelegate, UITableViewDataSource, DatePickerViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *datasource;
@property (nonatomic) NSArray *cellNames;

@end

@implementation DetailViewController

UILabel *limitedDateLabel;
NSString *limitedDate;
// DatePickerの初期値
NSDate *iniDate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.cellNames = [NSArray arrayWithObjects:@"CellLimited", nil];
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    // ナビゲーションバーを表示する
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    // ツールバーの表示
    [self.navigationController setToolbarHidden:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellName = [self.cellNames objectAtIndex:indexPath.row];
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
    
    // 期限日のラベルを設定
    // TODO DBからとってきて初期値を設定する
    limitedDateLabel = (UILabel *)[cell viewWithTag:1];
    limitedDateLabel.text = @"";
    
    return cell;
}

- (void)closeButton:(id)sender
{
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    self.tableView.allowsMultipleSelectionDuringEditing = editing;
    
    [self.tableView setEditing:editing animated:animated];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    _cellNames = [[NSMutableArray alloc] init];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"TEST";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // keyboard hide
    [self.view endEditing:YES];
    
    // DatePickerViewControllerのインスタンスをStoryboardから取得し
    self.datePickerViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"DatePickerViewController"];
    // 日付の表示モードを変更する(時分を表示)
    //    self.datePickerViewController.datePickerMode_ = UIDatePickerModeDateAndTime;
    self.datePickerViewController.datePickerMode = UIDatePickerModeDate;          // 日付表示

    // date picker 表示範囲
    // TODO 今の日付プラスマイナスでやる！！
    self.datePickerViewController.minDate = [MyDateUtil stringToDate:@"2010-03-01"]; // min
    self.datePickerViewController.maxDate = [MyDateUtil stringToDate:@"2020-08-31"]; // max
    
    
    // 表示する初期日付
    self.datePickerViewController.iniDate = iniDate;
    
    
    self.datePickerViewController.delegate = self;
    
    // DatePickerViewをサブビューとして表示する
    // 表示するときはアニメーションをつけて下から上にゆっくり表示させる
    
    // アニメーション完了時のDatePickerViewの位置を計算
    UIView *datePickerView = self.datePickerViewController.view;
    CGPoint middleCenter = datePickerView.center;
    
    // アニメーション開始時のDatePickerViewの位置を計算
    UIWindow* mainWindow = (([UIApplication sharedApplication].delegate).window);
    CGSize offSize = [UIScreen mainScreen].bounds.size;
    
    CGPoint offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height * 1.5);
    datePickerView.center = offScreenCenter;
    
    [mainWindow addSubview:datePickerView];
    
    // アニメーションを使ってDatePickerViewをアニメーション完了時の位置に表示されるようにする
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    datePickerView.center = middleCenter;// 終了位置
    [UIView commitAnimations];
}

- (void)applySelectedString:(NSDate *)date
{
    NSString *strDate;
    strDate = [MyDateUtil dateToString:date];
    limitedDate = strDate;
    
    limitedDateLabel.text = strDate;
    
    // ピッカーの初期値を設定
    iniDate = date;
}

- (void)closePickerView:(DatePickerViewController *)controller
{
//    // PickerViewをアニメーションを使ってゆっくり非表示にする
//    UIView *pickerView = controller.view;
//    
//    // アニメーション完了時のPickerViewの位置を計算
//    CGSize offSize = [UIScreen mainScreen].bounds.size;
//    CGPoint offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height * 1.5);
//    
//    [UIView beginAnimations:nil context:(void *)pickerView];
//    [UIView setAnimationDuration:0.3];
//    [UIView setAnimationDelegate:self];
//    // アニメーション終了時に呼び出す処理を設定
//    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
//    pickerView.center = offScreenCenter;
//    [UIView commitAnimations];
}

// 単位のPickerViewを閉じるアニメーションが終了したときに呼び出されるメソッド
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    // PickerViewをサブビューから削除
    UIView *pickerView = (__bridge UIView *)context;
    [pickerView removeFromSuperview];
}

- (void)deleteSetting
{
    // 設定しないボタン押されたときのデリゲートメソッド
    // TODO DBの設定値を初期化する
    
    // ラベルを初期化
    limitedDateLabel.text = @"";
    
    // ピッカー初期値を削除
    iniDate = [NSDate date];

}


@end