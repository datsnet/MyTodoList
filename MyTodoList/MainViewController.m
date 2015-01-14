//
//  MainViewController.m
//  MyTodoList
//
//  Created by 熱海 大介 on 2014/07/05.
//  Copyright (c) 2014年 com.datsnet. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "MainViewController.h"
#import "DetailViewController.h"

@interface MainViewController() <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addItem;

@property (nonatomic) IBOutlet UIBarButtonItem *revealButtonItem;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *datasource;
@property (nonatomic) NSMutableArray *items;

@end

@implementation MainViewController

NSManagedObjectContext *context;

#pragma mark viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // TODO: DBから値を取ってくる
    MyCoreDataManager *manager = [MyCoreDataManager sharedManager];
    NSMutableArray *todos = [manager all:@"Todo"];
    _items = todos;
    for (Todo *todo in todos) {
        NSLog(@"todo = %@", todo);
    }
    
}

- (void)viewDidAppear:(BOOL)animated
{

}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TodoListPropertyCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = self.datasource[indexPath.row];
    
    
    // セルを設定する
    Todo *item = self.items[indexPath.row];
    cell.textLabel.text = item.name;
    cell.accessoryType = (item.complete ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone);
    

    return cell;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    _items = [[NSMutableArray alloc] init];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"All Todos";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    // Todoの完了と未完了をトグルする
//    MyTodoItem *item = self.items[indexPath.row];
//    item.completed = !item.completed;
//    // アクセサリーの設定
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.accessoryType = (item.completed ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone);

    [self showDetailViewController];

}

- (void) showDetailViewController
{
    DetailViewController *detaliViewController = [[DetailViewController alloc] init];
    [self presentViewController:detaliViewController animated:YES completion:nil];
}
- (IBAction)addItem:(id)sender
{
    // Todo　CodeDataに追加
    MyCoreDataManager *manager = [MyCoreDataManager sharedManager];
    Todo *todo = (Todo *) [manager entityForInsert:@"Todo"];
    todo.name = [NSString stringWithFormat:@"TODO %ld", (long)self.items.count];
    [manager saveContext];
    
    // テーブルの先頭に新規アイテムを挿入する
    NSIndexPath *indexPathToInsert = [NSIndexPath indexPathForRow:0 inSection:0];
    
    
    // データソースの更新
    [self.items insertObject:todo atIndex:indexPathToInsert.row];
    // テーブルビューの更新
    [self.tableView insertRowsAtIndexPaths:@[indexPathToInsert] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
}

@end

