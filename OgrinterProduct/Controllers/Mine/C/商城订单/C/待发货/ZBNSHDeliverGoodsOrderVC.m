//
//  ZBNSHDeliverGoodsOrderVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/12.
//  Copyright © 2019 RXF. All rights reserved.
//  待发货

#import "ZBNSHDeliverGoodsOrderVC.h"
#import "ZBNSHDeliverGoodsOrderCell.h"
#import "ZBNWaitDeliverDetailVC.h"

@interface ZBNSHDeliverGoodsOrderVC ()

@end

@implementation ZBNSHDeliverGoodsOrderVC



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZBNCommonBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNSHDeliverGoodsOrderCell *cell = [ZBNSHDeliverGoodsOrderCell regiserCellForTable:tableView];
    ADWeakSelf;
    cell.waitDeliverBtnClickTask = ^{
        ZBNWaitDeliverDetailVC *detailVc = [[ZBNWaitDeliverDetailVC alloc] init];
        [weakSelf.navigationController pushViewController:detailVc animated:YES];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 310;
}

@end
