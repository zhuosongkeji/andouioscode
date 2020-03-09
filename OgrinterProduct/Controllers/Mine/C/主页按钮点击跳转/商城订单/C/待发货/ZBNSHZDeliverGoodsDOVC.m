//
//  ZBNSHZDeliverGoodsDOVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/4.
//  Copyright © 2020 RXF. All rights reserved.
//  待发货订单详情

#import "ZBNSHZDeliverGoodsDOVC.h"

#import "ZBNSHZDeliverGoodsDOCell.h"
#import "ZBNSHOrderDetailsM.h"
#import "ZBNSHOrderDetailComM.h"
#import "ZBNSHCommonHeadV.h"
#import "ZBNSHReturnGoodsVC.h"

@interface ZBNSHZDeliverGoodsDOVC ()
/*! 模型数据 */
@property (nonatomic, strong) ZBNSHOrderDetailsM *detailsM;
/*! 模型数据 */
@property (nonatomic, strong) ZBNSHOrderDetailComM *comM;

@property (nonatomic, weak) ZBNSHCommonHeadV *headV;

@end

@implementation ZBNSHZDeliverGoodsDOVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置UI
    [self setupUI];
    // 设置头部视图
    [self setupHeadV];
    // 加载数据
    [self loadData];
}


- (void)setupHeadV
{
    ZBNSHCommonHeadV *headV = [ZBNSHCommonHeadV viewFromXib];
    headV.height = ZBNHeaderH;
    headV.setImageVImage(@"组 3").setLabelOneText(@"待发货").setSubLabelOneText(@"商家正积极的给您发货喔");
    self.tableView.tableHeaderView = headV;
    self.headV = headV;
}

- (void)setupUI
{
    self.navigationItem.title = @"订单详情";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }else {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
}

- (void)loadData
{
    ADWeakSelf;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
        NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
        userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
        params[@"uid"] = unmodel.uid;
        params[@"token"] = unmodel.token;
        params[@"order_sn"] = self.order_num;
        params[@"did"] = self.dID;
        [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/order/details" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
            self.comM = [ZBNSHOrderDetailComM mj_objectWithKeyValues:serverInfo.response[@"data"]];
            self.detailsM = [ZBNSHOrderDetailsM mj_objectWithKeyValues:[serverInfo.response[@"data"] valueForKeyPath:@"details"][0]];
            [weakSelf.tableView reloadData];
        }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNSHZDeliverGoodsDOCell *cell= [ZBNSHZDeliverGoodsDOCell regiserCellForTable:tableView];
    ADWeakSelf;
    cell.returnGoodsBtnClickTask = ^{
        ZBNSHReturnGoodsVC *vc = [[ZBNSHReturnGoodsVC alloc] init];
        vc.did = self.dID;
        vc.order_goods_id = self.order_num;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    cell.comM = self.comM;
    cell.detailM = self.detailsM;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 510;
}

@end
