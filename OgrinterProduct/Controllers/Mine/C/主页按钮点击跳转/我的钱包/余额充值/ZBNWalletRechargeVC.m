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
#import <WechatOpenSDK/WXApi.h>
#import "ZBNRechargeModel.h"

#import "ZBNWalletRechargeModel.h"

@interface ZBNWalletRechargeVC ()

@property (nonatomic, weak) ZBNEntryFooterView *footerView;

@property (nonatomic, strong) ZBNWalletRechargeModel *reModel;
@end

@implementation ZBNWalletRechargeVC


#pragma mark -- 控制器的生命周期方法


- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置table
    [self setupTable];
    // 设置底部的按钮view
    [self setupTableView];
    // 加载数据
}



/*! 设置tableView相关 */
- (void)setupTable
{
    self.navigationItem.title = @"余额充值";
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.navigationController.navigationBar.translucent = NO;
}

/*! 设置底部的按钮view */
- (void)setupTableView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    ADWeakSelf;
    ZBNEntryFooterView *footerV = [ZBNEntryFooterView viewFromXib];
    footerV.height = ZBNHeaderH;
    footerV.middleBtnClickTask = ^{
        if (weakSelf.model.moneyNumber && weakSelf.model.payNumber && weakSelf.model.phoneNumber) {
            [weakSelf dataRequest];
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
    param[@"mobile"] = self.model.phoneNumber;
    param[@"method"] = self.model.payNumber;
//    param[@"num"] = self.model.accountNumber;
        [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/wallet/recharge" params:param complement:^(ServerResponseInfo * _Nullable serverInfo) {
            if ([[serverInfo.response objectForKey:@"code"] intValue] == 200) {
                    NSDictionary *dict = serverInfo.response[@"data"];
                    [self uploadWx:dict];
            } else {
                [HUDManager showTextHud:@"充值失败"];
            }
        }];
}


-(void)uploadWx:(NSDictionary *)dict{
    
    PayReq *req = [[PayReq alloc] init];
    
    req.openID = [NSString stringWithFormat:@"%@",dict[@"appid"]];
    //APPID
    req.partnerId = [NSString stringWithFormat:@"%@",dict[@"mch_id"]]; //商户号
    req.prepayId = [NSString stringWithFormat:@"%@",dict[@"prepay_id"]];
    
    req.nonceStr = [NSString stringWithFormat:@"%@",dict[@"nonce_str"]];
    
    req.timeStamp = [dict[@"timestamp"] intValue];
    
    req.package = @"Sign=WXPay";
    
    req.sign = [NSString stringWithFormat:@"%@",dict[@"sign"]];
    
    [WXApi sendReq:req completion:nil];
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
        self.model = model;
        return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 340;
}


#pragma mark -- 懒加载


@end
