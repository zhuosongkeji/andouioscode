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
        if (self.model.accountNumber && self.model.moneyNumber && self.model.payNumber && self.model.phoneNumber) {
            [self dataRequest];
        } else {
            [HUDManager showTextHud:@"请将资料填写完整"];
        }
    };
    self.footerView = footerV;
    self.footerView.setButtonText(@"确认充值");
    
    self.tableView.tableFooterView = footerV;
}


- (void)dataRequest
{
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
     userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
     NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = unmodel.uid;
    param[@"token"] = unmodel.token;
    param[@"money"] = self.model.moneyNumber;
    param[@"phone"] = self.model.phoneNumber;
    param[@"method"] = self.model.payNumber;
    param[@"num"] = self.model.accountNumber;
        [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/wallet/recharge" params:param complement:^(ServerResponseInfo * _Nullable serverInfo) {
                
        }];
}



#pragma mark -- 数据源和代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZBNRechargeModel *model = [[ZBNRechargeModel alloc] init];
    // 创建cell
    ZBNRechargeCell *cell = [ZBNRechargeCell registerCellForTableView:tableView];
    // 设置余额的金额
    cell.moneyLabel.text = self.moneyText;
    // 拿到充值方式
    cell.modeBlock = ^(NSString * _Nonnull mode) {
        [model setPayNumber:mode];
    };
    // 拿到充值金额
    cell.rechargeNumberBlock = ^(NSString * _Nonnull rechargeNumber) {
        [model setMoneyNumber:rechargeNumber];
    };
    // 拿到联系方式
    cell.contactNumberBlock = ^(NSString * _Nonnull contactNumber) {
        [model setPhoneNumber:contactNumber];
    };
    // 拿到银行卡号
    cell.bankCardNumberBlock = ^(NSString * _Nonnull bankCardNumber) {
        [model setAccountNumber:bankCardNumber];
    };
        self.model = model;
        return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 475;
}


#pragma mark -- 懒加载


@end
