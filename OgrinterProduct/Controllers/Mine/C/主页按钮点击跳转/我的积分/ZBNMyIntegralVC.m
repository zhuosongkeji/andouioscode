//
//  ZBNMyIntegralVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/11.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMyIntegralVC.h"
#import "ZBNMyWalletComCell.h"
#import "ZBNMyIntegerHeadView.h"
#import "ZBNMyIntegralModel.h"


@interface ZBNMyIntegralVC ()

/*! 储存数据的数组 */
@property (nonatomic, strong) NSMutableArray *dataArr;
/*! 模型 */
@property (nonatomic, strong) ZBNMyIntegralModel *integerM;

@property (nonatomic, weak) ZBNMyIntegerHeadView *headView;

@property (nonatomic, copy) NSString *nextPage;
@end


@implementation ZBNMyIntegralVC

#pragma mark -- 生命周期方法

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置UI界面
    [self setupUI];
    // 加载数据
    [self setupRefresh];

}

/*! 设置UI */
- (void)setupUI
{
    self.navigationItem.title = @"我的积分";
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.navigationController.navigationBar.translucent = NO;
    ZBNMyIntegerHeadView *headView = [ZBNMyIntegerHeadView viewFromXib];
    headView.height = ZBNHeaderH;
    self.tableView.tableHeaderView = headView;
    self.headView = headView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

// 加载数据
- (void)loadNewData
{
    
    self.nextPage = @"2";
    [FKHRequestManager cancleRequestWork];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    params[@"uid"] = unmodel.uid;
    params[@"token"] = unmodel.token;
    params[@"page"] = @"1";
    ADWeakSelf;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:ZBNIntegerURL params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        weakSelf.dataArr = [ZBNMyIntegralModel mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"][@"log"]];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        if (weakSelf.dataArr.count < 10) {
            [weakSelf.tableView.mj_footer setHidden:YES];
        }
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
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:ZBNIntegerURL params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        NSArray *newData = [ZBNMyIntegralModel mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"][@"log"]];
        [self.dataArr addObjectsFromArray:newData];
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

#pragma mark -- tableView的代理和数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNMyWalletComCell *cell = [ZBNMyWalletComCell registerCellForTableView:tableView];
    cell.integerM = self.dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark -- lazy

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end
