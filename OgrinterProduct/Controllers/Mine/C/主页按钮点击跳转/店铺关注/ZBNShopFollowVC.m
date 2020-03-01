//
//  ZBNShopFollowVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/12.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNShopFollowVC.h"
#import "ZBNShopFollowModel.h"
#import "MsgViewCell.h"
#import "ZBNRefreshHeader.h"
#import "ZBNComDataNilCell.h"

@interface ZBNShopFollowVC ()

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, copy) NSString *nextPage;
@end

@implementation ZBNShopFollowVC

static NSString * const ZBNShopFollowCellID = @"shopCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置table
    [self setupTable];
    // 加载数据
    [self setupRefresh];
}

- (void)setupTable
{
    self.navigationItem.title = @"浏览痕迹";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"MsgViewCell" bundle:nil] forCellReuseIdentifier:ZBNShopFollowCellID];
    self.tableView.backgroundColor = KSRGBA(241, 241, 241, 1);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataArr.count > 0) {
        return self.dataArr.count;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArr.count > 0) {
        MsgViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNShopFollowCellID];
           cell.shopM = self.dataArr[indexPath.row];
           return cell;
    } else {
        ZBNComDataNilCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNComDataNilCell" owner:nil options:nil].lastObject;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArr.count > 0) {
        return 98;
    } else {
        return self.view.height;
    }
}


#pragma mark -- request
// 加载数据
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
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:ZBNFollowURL params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        weakSelf.dataArr = [ZBNShopFollowModel mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"]];
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
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:ZBNFollowURL params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        NSArray *newData = [ZBNShopFollowModel mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"]];
        [self.dataArr addObjectsFromArray:newData];
        if (newData.count < 10) {
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


#pragma mark -- lazy
- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end
