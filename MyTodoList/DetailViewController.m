//
//  DetailViewController.m
//  MyTodoList
//
//  Created by 熱海 大介 on 2014/11/16.
//  Copyright (c) 2014年 com.datsnet. All rights reserved.
//
#import "DetailViewController.h"

@interface DetailViewController() <UITableViewDelegate, UITableViewDataSource, UINavigationBarDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *datasource;
@property (nonatomic) NSArray *cellNames;
@end

@implementation DetailViewController

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

    
}

@end