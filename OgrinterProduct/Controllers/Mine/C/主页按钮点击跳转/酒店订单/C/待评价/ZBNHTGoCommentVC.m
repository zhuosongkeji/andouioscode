//
//  ZBNHTGoCommentVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/14.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNHTGoCommentVC.h"
#import "ZBNHTGoCommentCell.h"
@interface ZBNHTGoCommentVC ()

@end

@implementation ZBNHTGoCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
    
}

- (void)setupTable
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.title = @"订单详情";
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.tableView.bounces = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNHTGoCommentCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNHTGoCommentCell" owner:nil options:nil].lastObject;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ADWeakSelf;
    cell.comBtnClickTask = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 588;
}

@end
