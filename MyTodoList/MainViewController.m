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

@interface MainViewController() <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
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
    
    // DBから値を取ってくる
    MyCoreDataManager *manager = [MyCoreDataManager sharedManager];
    NSMutableArray *todos = [manager all:@"Todo" sortKey:@"sort" ascending:YES];
    _items = todos;
    for (Todo *todo in todos) {
        NSLog(@"todo = %@", todo);
    }
    
    UILongPressGestureRecognizer *gestureRecognizer = [[UILongPressGestureRecognizer alloc]
                                                       initWithTarget:self action:@selector(cellLongPress:)];
    gestureRecognizer.minimumPressDuration = 0.5; //seconds
    gestureRecognizer.delegate = self;
    [_tableView addGestureRecognizer:gestureRecognizer];
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
    cell.accessoryType = ([item.complete shortValue] == 1 ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone);
    

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

- (void)changeEditMode {
    BOOL isEditing = [_tableView isEditing];
    // 編集ボタンを切り替える
    BOOL editing = !self.tableView.editing;
    if (editing) {
        _editButton.title = NSLocalizedString(@"Done", @"Done");
        //Added in the edition for this button has the same color of the UIBarButtonSystemItemDone
        _editButton.style = UIBarButtonItemStyleDone;
    }
    else{
        _editButton.title = NSLocalizedString(@"Edit", @"Edit");
        //Added in the edition for this button has the same color of the UIBarButtonSystemItemDone
        _editButton.style = UIBarButtonItemStylePlain;
    }
    
    [_tableView setEditing:!isEditing animated:!isEditing];
}

- (IBAction)editButtonAction:(id)sender {
    
    [self changeEditMode];
}

// 編集モード時のコールバック
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 削除処理
        // 該当するデータを削除する
        // データソースの更新
        [self.items removeObjectAtIndex:indexPath.row];
        
        
        // テーブルから該当セルを削除する
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // 挿入処理
    }   
}

- (IBAction)todoTextEditingDidEnd:(id)sender {
    NSString *inputText = _todoTextField.text;
    
    NSLog(@"input Text : %@", inputText);
    
    if (inputText == nil) {
        return;
    }
    
    // Todo　CodeDataに追加
    MyCoreDataManager *manager = [MyCoreDataManager sharedManager];
    Todo *todo = (Todo *) [manager entityForInsert:@"Todo"];
    todo.name = inputText;
    todo.sort = 0;
    
    // 他のデータのソート番号をインクリメントする
    NSMutableArray *allTodos = [manager fetch:@"Todo" limit:0];
    for (Todo *item in allTodos) {
        item.sort = [NSNumber numberWithLong:[item.sort longValue] + 1];
    }
    [manager saveContext];
    
    // テーブルの先頭に新規アイテムを挿入する
    NSIndexPath *indexPathToInsert = [NSIndexPath indexPathForRow:0 inSection:0];
    
    // データソースの更新
    [self.items insertObject:todo atIndex:indexPathToInsert.row];
    // テーブルビューの更新
    [self.tableView insertRowsAtIndexPaths:@[indexPathToInsert] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    // テキストフィールドのクリア
    _todoTextField.text = @"";
    //    [[self tableView] setEditing:YES animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
//    if(fromIndexPath.section == toIndexPath.section) { // 移動元と移動先は同じセクションです。
//        if(stringArray && toIndexPath.row < [stringArray count]) {
//            id item = [[stringArray objectAtIndex:fromIndexPath.row] retain]; // 移動対象を保持します。
//            [stringArray removeObject:item]; // 配列から一度消します。
//            [stringArray insertObject:item atIndex:toIndexPath.row]; // 保持しておいた対象を挿入します。
//            [item release]; // itemは不要になるので開放します。
//        }
//    }
}

- (void) cellLongPress:(UILongPressGestureRecognizer*)gestureRecognizer
{
    if (!_tableView.editing) {
        // UILongPressGestureRecognizerからlocationInView:を使ってタップした場所のCGPointを取得する
        CGPoint p = [gestureRecognizer locationInView:_tableView];
        // 取得したCGPointを利用して、indexPathForRowAtPoint:でタップした場所のNSIndexPathを取得する
        NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:p];
        // NSIndexPathを利用して、cellForRowAtIndexPath:で該当でUITableViewCellを取得する
        UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
        if (cell != nil) {
            [self changeEditMode];
        }
    }
}

@end

