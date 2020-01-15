//
//  ZBNSHWaitEvaluateDetailVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/11.
//  Copyright © 2020 RXF. All rights reserved.
//  订单详情

#import "ZBNSHWaitEvaluateDetailVC.h"
#import "ZBNSHWaitEvaluateDetailCell.h"
#import "ZBNSHOrderDetailComM.h"
#import "ZBNSHOrderUserInfoM.h"
#import "ZBNSHOrderDetailsM.h"


@interface ZBNSHWaitEvaluateDetailVC ()
/*! 存储数据的数组 */
@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) ZBNSHOrderUserInfoM *userInfoM;
@property (nonatomic, strong) ZBNSHOrderDetailsM *detailsM;
@property (nonatomic, strong) ZBNSHOrderDetailComM *comM;
@end

@implementation ZBNSHWaitEvaluateDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(getRectNavAndStatusHight, 0, 0, 0);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNSHWaitEvaluateDetailCell *cell = [ZBNSHWaitEvaluateDetailCell regiserCellForTable:tableView];
    cell.comM = self.comM;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 444;
}


#pragma mark -- 数据

- (void)loadData
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
            self.comM.details = [ZBNSHOrderDetailsM mj_objectWithKeyValues:[serverInfo.response[@"data"] valueForKeyPath:@"details"][0]];
            [weakSelf.tableView reloadData];
        }];
}


@end
