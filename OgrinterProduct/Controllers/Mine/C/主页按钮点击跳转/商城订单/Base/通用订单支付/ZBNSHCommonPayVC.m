//
//  ZBNSHCommonPayVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/9.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSHCommonPayVC.h"
#import "ZBNSHCommonPayCell.h"
#import "ZBNSHOrderDetailComM.h"
#import "ZBNSHOrderUserInfoM.h"
#import "ZBNSHOrderDetailsM.h"
#import <WechatOpenSDK/WXApi.h>

@interface ZBNSHCommonPayVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;


/*! 价格label */
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
/*! 立即购买的按钮 */
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
/*! 订单详情的模型 */
@property (nonatomic, strong) ZBNSHOrderDetailComM *comM;
/*! 存储pay_id */
@property (nonatomic, copy) NSString *pay_id;
/*! 是否使用积分 */
@property (nonatomic, copy) NSString *is_integer;
/*! 是否使用积分按钮 */

@property (nonatomic, strong) ZBNSHOrderUserInfoM *userInfoM;
@property (nonatomic, strong) ZBNSHOrderDetailsM *detailM;
@end

@implementation ZBNSHCommonPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.myTableView.scrollEnabled = NO;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self loadData];
}

- (void)loadData
{
    ADWeakSelf;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
        NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
        userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
        params[@"uid"] = unmodel.uid;
        params[@"token"] = unmodel.token;
        params[@"order_sn"] = self.order_id;
        params[@"did"]  = self.did;
        [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/order/details" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
            self.comM = [ZBNSHOrderDetailComM mj_objectWithKeyValues:serverInfo.response[@"data"]];
            self.detailM = [ZBNSHOrderDetailsM mj_objectWithKeyValues:[serverInfo.response[@"data"] valueForKeyPath:@"details"][0]];
            self.userInfoM = [ZBNSHOrderUserInfoM mj_objectWithKeyValues:[serverInfo.response[@"data"] valueForKeyPath:@"userinfo"]];
            self.priceLabel.text = [NSString stringWithFormat:@"¥%@",self.comM.pay_money];
            [weakSelf.myTableView reloadData];
        }];
}







/*! 立即购买按钮的点击 */
- (IBAction)buyButtonClick:(UIButton *)sender {
    
    [self payRequest];
    
}

/*! 订单支付的请求 */
- (void)payRequest
{
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = unmodel.uid;
    param[@"token"] = unmodel.token;
    param[@"sNo"] = self.order_id;
    param[@"pay_id"] = self.pay_id;
    param[@"is_integral"] = self.is_integer;
    if ([self.pay_id isEqualToString:@"1"]) {
        [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/order/pay" params:param complement:^(ServerResponseInfo * _Nullable serverInfo) {
            if ([[serverInfo.response objectForKey:@"code"] intValue] == 200) {
                            NSDictionary *dict = serverInfo.response[@"data"];
                            [self uploadWx:dict];
            } else if ([[serverInfo.response objectForKey:@"code"] intValue] == 201) {
                [HUDManager showTextHud:@"积分不足"];
            }
        }];
    } else {
        [HUDManager showTextHud:@"请选择支付方式"];
    }
    
}

-(void)uploadWx:(NSDictionary *)dict{
    
    PayReq *req = [[PayReq alloc] init];
    
    req.openID = [NSString stringWithFormat:@"%@",dict[@"appid"]];
    //APPID
    req.partnerId = [NSString stringWithFormat:@"%@",dict[@"mch_id"]]; //商户号
    req.prepayId = [NSString stringWithFormat:@"%@",dict[@"prepay_id"]];
    
    req.nonceStr = [NSString stringWithFormat:@"%@",dict[@"nonce_str"]];
    
    req.timeStamp = [dict[@"timestamp"] intValue]; //wxa2ea994d7f5b42e9
    
    req.package = @"Sign=WXPay";
    
    req.sign = [NSString stringWithFormat:@"%@",dict[@"sign"]];
    
    [WXApi sendReq:req completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNSHCommonPayCell *cell = [ZBNSHCommonPayCell regiserCellForTable:tableView];
    cell.comM = self.comM;
    cell.userInfoM = self.userInfoM;
    cell.detailM = self.detailM;
    ADWeakSelf;
    cell.selBtnClick = ^(NSString * _Nonnull pay_id) {
        weakSelf.pay_id = pay_id;
    };
    cell.integerBtnClickTask = ^(UIButton * _Nonnull integralBtn) {
        if (integralBtn.selected) {
            weakSelf.is_integer = @"1";
        } else {
            weakSelf.is_integer = @"0";
        }
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 475;
}


@end
