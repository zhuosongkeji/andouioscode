//
//  ZBNSHReturnGoodsOrderVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/12.
//  Copyright © 2019 RXF. All rights reserved.
//  退/换货

#import "ZBNSHReturnGoodsOrderVC.h"

#import "ZBNSHReturnGoodsOrderCell.h"
#import "ZBNSHReturnGoodsOrderCellTwo.h"
#import "ZBNSHReturnGoodsDetailVC.h"


@interface ZBNSHReturnGoodsOrderVC ()

@end

@implementation ZBNSHReturnGoodsOrderVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        ZBNSHReturnGoodsOrderCell *cell = [ZBNSHReturnGoodsOrderCell regiserCellForTable:tableView];
        ADWeakSelf;
        cell.lookDetailBtnlClickTask = ^{
            ZBNSHReturnGoodsDetailVC *detailVc = [[ZBNSHReturnGoodsDetailVC alloc] init];
            [weakSelf.navigationController pushViewController:detailVc animated:YES];
        };
        return cell;
    } else {
        ZBNSHReturnGoodsOrderCellTwo *twoCell = [ZBNSHReturnGoodsOrderCellTwo regiserCellForTable:tableView];
        return twoCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}

@end
