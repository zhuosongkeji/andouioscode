//
//  ZBNVIPRechargeVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/16.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNVIPRechargeVC.h"
#import "ZBNVIPRechargeCell.h"
#import "ZBNEntryFooterView.h"
#import <WechatOpenSDK/WXApi.h>

@interface ZBNVIPRechargeVC ()
/*! 底部视图 */
@property (nonatomic, weak) ZBNEntryFooterView *footerV;
/*! 支付方式 */
@property (nonatomic, copy) NSString *pay_id;
@end

@implementation ZBNVIPRechargeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置table
    [self setupTable];
    // 设置底部视图
    [self setupFooter];
}


#pragma mark -- UI

- (void)setupFooter
{
    ZBNEntryFooterView *footerV = [ZBNEntryFooterView viewFromXib];
    footerV.height = ZBNFooterH;
    footerV.setButtonText(@"确认开通");
    // ----- >  确认开通按钮的点击
    footerV.middleBtnClickTask = ^{
        // 发起支付请求
        [self payRequest];
    };
    self.tableView.tableFooterView = footerV;
    self.footerV = footerV;
}

- (void)setupTable
{
    self.tableView.contentInset = UIEdgeInsetsMake(getRectNavAndStatusHight, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.navigationItem.title = @"会员开通";
}

#pragma mark -- 代理和数据源

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNVIPRechargeCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNVIPRechargeCell" owner:nil options:nil].lastObject;
    cell.payBtnClickTask = ^(NSString * _Nonnull pay_id) {
        // 接收pay_id
        self.pay_id = pay_id;
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 425;
}


#pragma mark -- 网络请求相关

/*! 支付请求 */
- (void)payRequest
{
  NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
        userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"uid"] = unmodel.uid;
        param[@"token"] = unmodel.token;
        param[@"pay_id"] = self.pay_id;
        if ([self.pay_id isEqualToString:@"1"]) {
            [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl: ZBNVipRechargeURL params:param complement:^(ServerResponseInfo * _Nullable serverInfo) {
                if ([[serverInfo.response objectForKey:@"code"] intValue] == 200) {
                                NSDictionary *dict = serverInfo.response[@"data"];
                                [self uploadWx:dict];
                } else if ([[serverInfo.response objectForKey:@"code"] intValue] == 201) {
                    [HUDManager showTextHud:@"积分不足"];
                }
            }];
        } else {
            [HUDManager showTextHud:@"余额支付暂不支持"];
        }
        
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

@end
