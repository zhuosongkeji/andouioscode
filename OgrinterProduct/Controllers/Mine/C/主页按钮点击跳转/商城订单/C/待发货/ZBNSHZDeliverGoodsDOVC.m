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

@interface ZBNSHZDeliverGoodsDOVC ()

@property (nonatomic, strong) ZBNSHOrderDetailsM *detailsM;
@property (nonatomic, strong) ZBNSHOrderDetailComM *comM;

@end

@implementation ZBNSHZDeliverGoodsDOVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置UI
    [self setupUI];
    // 加载数据
    [self loadData];
}


- (void)setupUI
{
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(getRectNavAndStatusHight, 0, 0, 0);
}

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
        params[@"order_sn"] = self.order_num;
        [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/api/order/details" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
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
    cell.comM = self.comM;
    cell.detailM = self.detailsM;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 495;
}

@end
