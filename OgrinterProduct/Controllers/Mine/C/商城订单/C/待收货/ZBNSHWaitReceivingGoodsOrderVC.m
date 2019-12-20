//
//  ZBNSHWaitReceivingGoodsOrderVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/12.
//  Copyright © 2019 RXF. All rights reserved.
//  等待收货订单

#import "ZBNSHWaitReceivingGoodsOrderVC.h"

#import "ZBNSHWaitReceivingGoodsOrderCell.h"
#import "ZBNWaitDeliverDetailVC.h"
#import "ZBNEvaluateGoodsVC.h"

@interface ZBNSHWaitReceivingGoodsOrderVC ()

@end

@implementation ZBNSHWaitReceivingGoodsOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ZBNCommonBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建待收货样式的cell
    ZBNSHWaitReceivingGoodsOrderCell *cell = [ZBNSHWaitReceivingGoodsOrderCell regiserCellForTable:tableView];
    ADWeakSelf;
    // 订单详情按钮的点击
    cell.orderDetailBtnClickTask = ^{
        ZBNWaitDeliverDetailVC *Vc = [[ZBNWaitDeliverDetailVC alloc] init];
        [weakSelf.navigationController pushViewController:Vc animated:YES];
    };
    // 确认收货按钮的点击
    cell.beSureRecivedGoodsBtnClickTask = ^{
        
        [ZBNAlertTool zbn_alertTitle:@"确认收到货了吗?" type:UIAlertControllerStyleAlert message:nil didTask:^{
                ZBNEvaluateGoodsVC *Vc = [[ZBNEvaluateGoodsVC alloc] init];
            [weakSelf.navigationController pushViewController:Vc animated:YES];
        }];
    };
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 310;
}

@end
