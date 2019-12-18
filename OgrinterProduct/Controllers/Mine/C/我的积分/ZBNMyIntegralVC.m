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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的积分";
    ZBNMyIntegerHeadView *headView = [ZBNMyIntegerHeadView viewFromXib];
    headView.height = 180;
    self.tableView.tableHeaderView = headView;
    
}

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
