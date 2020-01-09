//
//  ZBNSHBaseOrderVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/4.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSHBaseOrderVC.h"
#import "ZBNSHCommonCell.h"
#import "ZBNSHCommonModel.h"


@interface ZBNSHBaseOrderVC ()

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) ZBNSHCommonModel *comM;
@property (nonatomic, copy) NSString *nextPage;

@end

@implementation ZBNSHBaseOrderVC

- (ZBNCommonType)type
{
    return 0;
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return  _dataArr;
}


/*! 加载数据 */
// 加载数据
- (void)loadNewData
{
    [FKHRequestManager cancleRequestWork];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    
    params[@"uid"] = unmodel.uid;
    params[@"token"] = unmodel.token;
    params[@"type"] = @(self.type);
    params[@"page"] = @"1";
    ADWeakSelf;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/api/order/index" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        weakSelf.dataArr = [ZBNSHCommonModel mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"]];
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
    params[@"type"] = @(self.type);
    params[@"page"] = self.nextPage;
    ADWeakSelf;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/api/order/index" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        NSArray *moreArr = [ZBNSHCommonModel mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"]];
        [weakSelf.dataArr addObjectsFromArray:moreArr];
        [weakSelf.tableView reloadData];
        self.nextPage = [NSString stringWithFormat:@"%d",(self.nextPage.intValue + 1)];
        [weakSelf.tableView.mj_footer endRefreshing];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nextPage = @"2";
   // 设置UI
    [self setupUI];
    // 加载数据
    [self setupRefresh];
}

- (void)setupUI
{
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNSHCommonCell *cell = [ZBNSHCommonCell regiserCellForTable:tableView];
    cell.commonM = self.dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 310;
}

@end
