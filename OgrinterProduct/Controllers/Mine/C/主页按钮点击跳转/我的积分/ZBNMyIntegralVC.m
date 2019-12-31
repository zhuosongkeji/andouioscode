//
//  ZBNMyIntegralVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/11.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMyIntegralVC.h"
#import "ZBNMyWalletComCell.h"
#import "ZBNMyIntegerHeadView.h"

@implementation ZBNMyIntegralVC

#pragma mark -- 生命周期方法

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置UI界面
    [self setupUI];
    
}

- (void)setupUI
{
    self.navigationItem.title = @"我的积分";
    self.tableView.contentInset = UIEdgeInsetsMake(getRectNavAndStatusHight, 0, 0, 0);
    ZBNMyIntegerHeadView *headView = [ZBNMyIntegerHeadView viewFromXib];
    headView.height = ZBNHeaderH;
    self.tableView.tableHeaderView = headView;
}


#pragma mark -- tableView的代理和数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNMyWalletComCell *cell = [ZBNMyWalletComCell registerCellForTableView:tableView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}


@end
