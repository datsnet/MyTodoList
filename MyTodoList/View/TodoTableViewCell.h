//
//  TodoTableViewCell.h
//  MyTodoList
//
//  Created by 熱海大介 on 2015/01/22.
//  Copyright (c) 2015年 com.datsnet. All rights reserved.
//


#import "SWTableViewCell.h"
@interface TodoTableViewCell : SWTableViewCell

@property (weak, nonatomic) UILabel *title;
@property (weak, nonatomic) UIButton *check;

@end
