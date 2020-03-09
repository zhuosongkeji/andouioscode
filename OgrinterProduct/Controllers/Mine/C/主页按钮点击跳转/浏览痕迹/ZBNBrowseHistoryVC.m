//
//  ZBNBrowseHistoryVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNBrowseHistoryVC.h"
#import "MsgViewCell.h"
#import "ZBNBrowseModel.h"
#import "ZBNComDataNilCell.h"
#import "ZBNRefreshHeader.h"
#import "ShopShopkeeperViewController.h"

@interface ZBNBrowseHistoryVC ()
/*! 存储数据的数组 */
@property (nonatomic, strong) NSMutableArray *dataArr;
/*! 下一页 */
@property (nonatomic, copy) NSString *nextPage;
@end

@implementation ZBNBrowseHistoryVC

static NSString * const ZBNBrowseHistoryCellID = @"collectionCommen";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
    
    [self setupRefresh];
}

- (void)setupTable
{
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }else {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    self.navigationItem.title = @"浏览痕迹";
    [self.tableView registerNib:[UINib nibWithNibName:@"MsgViewCell" bundle:nil] forCellReuseIdentifier:ZBNBrowseHistoryCellID];
    self.tableView.backgroundColor = KSRGBA(241, 241, 241, 1);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataArr.count <= 0) {
        return 1;
    } else {
        return self.dataArr.count;;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArr.count <= 0) {
        ZBNComDataNilCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNComDataNilCell" owner:nil options:nil].lastObject;
        return cell;
    } else {
        MsgViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNBrowseHistoryCellID];
        cell.browseM = self.dataArr[indexPath.row];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    ZBNBrowseModel *model = self.dataArr[indexPath.row];
    ShopShopkeeperViewController *vc = [[ShopShopkeeperViewController alloc] init];
    vc.shoperId = model.ID;
    vc.u_id = unmodel.uid;
    [self.navigationController pushViewController:vc animated:YES];
    
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
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:ZBNMerchant_recordURL params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        weakSelf.dataArr = [ZBNBrowseModel mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"]];
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
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:ZBNMerchant_recordURL params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        NSArray *newData = [ZBNBrowseModel mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"]];
        if (newData.count < 10) {
            weakSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
            [weakSelf.dataArr addObjectsFromArray:newData];
        } else {
            [weakSelf.dataArr addObjectsFromArray:newData];
            [weakSelf.tableView.mj_footer endRefreshing];
        }
        [weakSelf.tableView reloadData];
        weakSelf.nextPage = [NSString stringWithFormat:@"%d",(weakSelf.nextPage.intValue + 1)];
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
