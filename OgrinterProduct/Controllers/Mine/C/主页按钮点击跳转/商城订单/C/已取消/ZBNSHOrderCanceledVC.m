//
//  ZBNSHOrderCanceledVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/3/6.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSHOrderCanceledVC.h"
#import "ZBNSHOrderCanceledCell.h"
#import "ZBNSHOrderDetailComM.h"
#import "ZBNSHOrderDetailsM.h"
#import "ZBNSHReturnGoodsVC.h"

@interface ZBNSHOrderCanceledVC ()
@property (nonatomic, strong) ZBNSHOrderDetailComM *comM;
@end

@implementation ZBNSHOrderCanceledVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadRequest];
    
    [self setupTable];
}

- (void)setupTable
{
    self.navigationItem.title = @"订单详情";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }else {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ADWeakSelf;
    ZBNSHOrderCanceledCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNSHOrderCanceledCell" owner:nil options:nil].lastObject;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.detailM = self.comM;
    cell.returnGoodsClickTask = ^(ZBNSHOrderCanceledCell * _Nonnull cell) {
        ZBNSHReturnGoodsVC *vc = [[ZBNSHReturnGoodsVC alloc] init];
        vc.order_goods_id = weakSelf.comM.order_sn;
        vc.did = weakSelf.comM.details.ID;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 500;
}

- (void)loadRequest
{
    ADWeakSelf;
    [FKHRequestManager cancleRequestWork];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
        NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
        userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
        params[@"uid"] = unmodel.uid;
        params[@"token"] = unmodel.token;
        params[@"order_sn"] = self.getOrderNum;
        params[@"did"] = self.dID;
        [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/order/details" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
            self.comM = [ZBNSHOrderDetailComM mj_objectWithKeyValues:serverInfo.response[@"data"]];
            [weakSelf.tableView reloadData];
             self.comM.details = [ZBNSHOrderDetailsM mj_objectWithKeyValues:[serverInfo.response[@"data"] valueForKeyPath:@"details"][0]];
        }];
}

@end
