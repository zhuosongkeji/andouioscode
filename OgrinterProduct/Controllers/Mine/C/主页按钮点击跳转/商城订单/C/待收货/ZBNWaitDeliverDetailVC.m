//
//  ZBNWaitDeliverDetailVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/20.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNWaitDeliverDetailVC.h"
#import "ZBNWaitDeliverDetailCell.h"
#import "ZBNSHApplyForRefundVC.h"

#import "ZBNSHCommonHeadV.h"

#import "ZBNSHOrderDetailComM.h"
#import "ZBNSHOrderUserInfoM.h"
#import "ZBNSHOrderDetailsM.h"


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
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(getRectNavAndStatusHight, 0, 0, 0);
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
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
        NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
        userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    //    params[@"uid"] = unmodel.uid;
        params[@"uid"] = @"1";
    //    params[@"token"] = unmodel.token;
        params[@"token"] = @"94e31eee8b8237c4d98e965dbcbc44b5";
        params[@"order_sn"] = self.getOrderNum;
        [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/api/order/details" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
            self.comM = [ZBNSHOrderDetailComM mj_objectWithKeyValues:serverInfo.response[@"data"]];
            self.detailsM = [ZBNSHOrderDetailsM mj_objectWithKeyValues:[serverInfo.response[@"data"] valueForKeyPath:@"details"][0]];
            NSLog(@"%@1111111",self.detailsM.attr_value);
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
    cell.comM = self.comM;
    cell.detailM = self.detailsM;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 600;
}
@end
