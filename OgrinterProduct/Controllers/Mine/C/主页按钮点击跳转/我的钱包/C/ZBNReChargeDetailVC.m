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
#import "ZBNRefreshHeader.h"
#import "ZBNComDataNilCell.h"

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
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 240, 0);
//    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
}

- (void)loadNewData
{
    self.nextPage = @"2";
    [FKHRequestManager cancleRequestWork];
    self.tableView.mj_footer.state = MJRefreshStateIdle;
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
            weakSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
        }
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
            }];
}

- (void)loadMoreData
{
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
        [weakSelf.dataArr addObjectsFromArray:moreArr];
        if (moreArr.count < 10) {
            weakSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
        } else {
            [weakSelf.tableView.mj_footer endRefreshing];
        }
        [weakSelf.tableView reloadData];
        self.nextPage = [NSString stringWithFormat:@"%d",(self.nextPage.intValue + 1)];
    }];
}

- (void)setupRefresh
{
    // 下拉刷新
    self.tableView.mj_header = [ZBNRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (self.dataArr.count > 0) {
        return self.dataArr.count;
//    } else {
//        return 1;
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (self.dataArr.count > 0) {
        ZBNMyWalletComCell *cell = [ZBNMyWalletComCell registerCellForTableView:tableView];
        cell.DetailM = self.dataArr[indexPath.row];
        return cell;
//    } else {
//        ZBNComDataNilCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNComDataNilCell" owner:nil options:nil].lastObject;
//        return cell;
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (self.dataArr.count > 0) {
        return 60;
//    } else {
//        return self.view.height - 190;
//    }
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
