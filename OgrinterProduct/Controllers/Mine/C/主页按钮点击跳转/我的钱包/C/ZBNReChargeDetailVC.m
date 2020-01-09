//
//  ZBNReChargeDetailVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//  提现明细

#import "ZBNReChargeDetailVC.h"
#import "ZBNMyWalletComCell.h"
#import "ZBNReChargeDetailModel.h"

@interface ZBNReChargeDetailVC ()
/*! 存放模型的数组 */
@property (nonatomic, strong) NSMutableArray *dataArr;
/*! 提现明细模型 */
@property (nonatomic, strong) ZBNReChargeDetailModel *detailM;
@end

@implementation ZBNReChargeDetailVC



- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载数据
    [self loadData];
}



- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
     NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
     userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
     params[@"uid"] = unmodel.uid;
     params[@"token"] = unmodel.token;
     params[@"page"] = @"1";
     ADWeakSelf;
     [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/wallet/cash" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
         weakSelf.dataArr = [ZBNReChargeDetailModel mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"][@"log"]];
         [weakSelf.tableView reloadData];
             }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNMyWalletComCell *cell = [ZBNMyWalletComCell registerCellForTableView:tableView];
    cell.DetailM = self.dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

#pragma mark -- 懒加载

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end
