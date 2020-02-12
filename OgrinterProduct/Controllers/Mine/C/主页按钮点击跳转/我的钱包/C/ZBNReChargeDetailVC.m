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

@property (nonatomic, copy) NSString *nextPage;

@end

@implementation ZBNReChargeDetailVC



- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载数据
    [self setupRefresh];
}

- (void)loadNewData
{
    [FKHRequestManager cancleRequestWork];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    params[@"uid"] = unmodel.uid;
    params[@"token"] = unmodel.token;
    params[@"page"] = @"1";
    ADWeakSelf;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:ZBNCashURL params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        weakSelf.dataArr = [ZBNReChargeDetailModel mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"][@"log"]];
        if (weakSelf.dataArr.count < 10) {
            [weakSelf.tableView.mj_footer setHidden:YES];
        }
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
            }];
}

- (void)loadMoreData
{
    self.nextPage = @"2";
    [FKHRequestManager cancleRequestWork];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    params[@"uid"] = unmodel.uid;
    params[@"token"] = unmodel.token;
    params[@"page"] = self.nextPage;
    ADWeakSelf;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:ZBNCashURL params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        NSArray *moreArr = [ZBNReChargeDetailModel mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"][@"log"]];
        if (moreArr == nil) {
            [weakSelf.tableView.mj_footer setHidden:YES];
        } else {
            [weakSelf.dataArr addObjectsFromArray:moreArr];
                   [weakSelf.tableView reloadData];
                   self.nextPage = [NSString stringWithFormat:@"%d",(self.nextPage.intValue + 1)];
                   [weakSelf.tableView.mj_footer endRefreshing];
        }
       
    }];
}

- (void)setupRefresh
{
    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
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
