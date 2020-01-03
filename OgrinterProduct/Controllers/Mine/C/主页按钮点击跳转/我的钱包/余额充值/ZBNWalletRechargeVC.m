//
//  ZBNWalletRechargeVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/16.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNWalletRechargeVC.h"
#import "ZBNRechargeCell.h"
#import "ZBNEntryFooterView.h"

#import "ZBNRechargeModel.h"

@interface ZBNWalletRechargeVC ()

@property (nonatomic, weak) ZBNEntryFooterView *footerView;

@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation ZBNWalletRechargeVC


#pragma mark -- 控制器的生命周期方法

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置table
    [self setupTable];
    // 设置底部的按钮view
    [self setupTableView];
}

/*! 设置tableView相关 */
- (void)setupTable
{
    self.navigationItem.title = @"余额充值";
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.tableView.contentInset = UIEdgeInsetsMake(getRectNavAndStatusHight, 0, 0, 0);
}

/*! 设置底部的按钮view */
- (void)setupTableView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    ZBNEntryFooterView *footerV = [ZBNEntryFooterView viewFromXib];
    footerV.height = ZBNHeaderH;
    footerV.middleBtnClickTask = ^{
        for (ZBNRechargeModel *model in self.array) {
            NSLog(@"支付方式:%@ 账号:%@ 电话号码:%@ 充值金额:%@",model.payNumber,model.accountNumber,model.phoneNumber,model.moneyNumber);
        }
    };
    self.footerView = footerV;
    self.footerView.setButtonText(@"确认充值");
    
    self.tableView.tableFooterView = footerV;
}

#pragma mark -- 数据源和代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 创建模型
    ZBNRechargeModel *model = [[ZBNRechargeModel alloc] init];
    // 创建cell
    ZBNRechargeCell *cell = [ZBNRechargeCell registerCellForTableView:tableView];
    // 设置余额的金额
    cell.moneyLabel.text = self.moneyText;
    // 拿到充值方式
    cell.modeBlock = ^(NSString * _Nonnull mode) {
        [model setPayNumber:mode];
        if ([self.array containsObject:model]) {
            return ;
        }
        [self.array addObject:model];
    };
    // 拿到充值金额
    cell.rechargeNumberBlock = ^(NSString * _Nonnull rechargeNumber) {
        [model setMoneyNumber:rechargeNumber];
        if ([self.array containsObject:model]) {
            return ;
        }
        [self.array addObject:model];
    };
    // 拿到联系方式
    cell.contactNumberBlock = ^(NSString * _Nonnull contactNumber) {
        [model setPhoneNumber:contactNumber];
        if ([self.array containsObject:model]) {
            return ;
        }
        [self.array addObject:model];
    };
    // 拿到银行卡号
    cell.bankCardNumberBlock = ^(NSString * _Nonnull bankCardNumber) {
        [model setAccountNumber:bankCardNumber];
        if ([self.array containsObject:model]) {
            return ;
        }
        [self.array addObject:model];
    };
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 492;
}

#pragma mark -- 懒加载

- (NSMutableArray *)array
{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

@end
