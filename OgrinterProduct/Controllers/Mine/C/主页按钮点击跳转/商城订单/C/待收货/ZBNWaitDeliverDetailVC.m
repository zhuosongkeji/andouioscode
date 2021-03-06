//
//  ZBNWaitDeliverDetailVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/20.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNWaitDeliverDetailVC.h"
#import "ZBNWaitDeliverDetailCell.h"

#import "ZBNSHCommonHeadV.h"

#import "ZBNSHOrderDetailComM.h"
#import "ZBNSHOrderUserInfoM.h"
#import "ZBNSHOrderDetailsM.h"

#import "ZBNSHComViewLogisticsVC.h" // 查看物流
#import "ZBNSHReturnGoodsVC.h"

@interface ZBNWaitDeliverDetailVC ()

@property (nonatomic, weak) ZBNSHCommonHeadV *headV;

@property (nonatomic, strong) ZBNSHOrderUserInfoM *userInfoM;
@property (nonatomic, strong) ZBNSHOrderDetailsM *detailsM;
@property (nonatomic, strong) ZBNSHOrderDetailComM *comM;

@end

@implementation ZBNWaitDeliverDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置UI视图
    [self setupUI];
    // 设置头部视图
    [self setupHeaderView];
    // 加载数据
    [self loadData];

    
}


- (void)setupUI
{
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }else {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
}

- (void)setupHeaderView
{
    ZBNSHCommonHeadV *headV = [ZBNSHCommonHeadV viewFromXib];
    headV.height = ZBNHeaderH;
    headV.setLabelOneText(@"待收货").setSubLabelOneText(@"等待买家收货").setImageVImage(@"组 3-2");
    self.tableView.tableHeaderView = headV;
    self.headV = headV;
}

/*! 加载模型数据 */
- (void)loadData
{
    ADWeakSelf;
    [FKHRequestManager cancleRequestWork];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
        NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
        userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
        params[@"uid"] = unmodel.uid;
        params[@"token"] = unmodel.token;
        params[@"order_goods_id"] = self.order_goods_id;
        params[@"order_sn"] = self.getOrderNum;
        [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/order/details" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
            self.comM = [ZBNSHOrderDetailComM mj_objectWithKeyValues:serverInfo.response[@"data"]];
            self.comM.details = [ZBNSHOrderDetailsM mj_objectWithKeyValues:serverInfo.response[@"data"][@"details"][0]];
            [weakSelf.tableView reloadData];
        }];
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNWaitDeliverDetailCell *cell = [ZBNWaitDeliverDetailCell regiserCellForTable:tableView];
    ADWeakSelf;
    // 确认收货
    cell.beSureReciveGoodsBtnClickTask = ^{
        [ZBNAlertTool zbn_alertTitle:@"确认收货?" type:UIAlertControllerStyleAlert message:@"确认收货" didTask:^{
            // 发起确认收货的请求
            [weakSelf beSureReciveRequest];
        }];
    };
    // 退货退款
    cell.returnGoodsBtnClickTask = ^{
        ZBNSHReturnGoodsVC *vc = [[ZBNSHReturnGoodsVC alloc] init];
        vc.did = self.order_goods_id;
        vc.order_goods_id = self.getOrderNum;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    // 查看物流
    cell.viewLogisticsBtnClickTask = ^{
        ZBNSHComViewLogisticsVC *vc = [[ZBNSHComViewLogisticsVC alloc] init];
        vc.courier_num = weakSelf.courier_num;
        vc.express_id = weakSelf.express_id;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    cell.comM = self.comM;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 570;
}


/*! 确认收货的请求 */
- (void)beSureReciveRequest
{
    [FKHRequestManager cancleRequestWork];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    params[@"uid"] = unmodel.uid;
    params[@"token"] = unmodel.token;
    params[@"id"] = self.comM.details.ID;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/order/confirm"params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([[serverInfo.response objectForKey:@"code"] intValue] == 200) {
            [HUDManager showStateHud:@"确认收货成功" state:HUDStateTypeSuccess];
        } else {
            [HUDManager showStateHud:@"确认收货失败" state:HUDStateTypeFail];
        }
    }];
}


@end
