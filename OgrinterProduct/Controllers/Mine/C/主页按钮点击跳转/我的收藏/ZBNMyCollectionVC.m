//
//  ZBNMyCollectionVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMyCollectionVC.h"
#import "ZBNMyCollectionCommenCell.h"
#import "ZBNMyCollectionM.h"
#import "ZBNComDataNilCell.h"
#import "ZBNRefreshHeader.h"


@interface ZBNMyCollectionVC ()
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, copy) NSString *nextPage;
@end

@implementation ZBNMyCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self setupTable];
    /*! 加载数据 */
    [self setupRefresh];
}


- (void)setupTable
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.navigationItem.title = @"商品收藏";
    self.tableView.bounces = YES;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.dataArr.count <= 0) {
        return 1;
    } else {
        return self.dataArr.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArr.count <= 0) {
        ZBNComDataNilCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNComDataNilCell" owner:nil options:nil].lastObject;
        return cell;
    } else {
        ZBNMyCollectionCommenCell *cell = [ZBNMyCollectionCommenCell regiserCellForTable:tableView];
        cell.collectionM = self.dataArr[indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArr.count <= 0) {
        return self.view.height;
    } else {
        return 105;
    }
}

#pragma mark -- request
- (void)loadNewData
{
    self.nextPage = @"2";
     [FKHRequestManager cancleRequestWork];
    self.tableView.mj_footer.state = MJRefreshStateIdle;
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
            param[@"uid"] = unmodel.uid;
            param[@"token"] = unmodel.token;
            param[@"page"] = @"1";
        ADWeakSelf;
           [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:ZBNCollectionURL params:param complement:^(ServerResponseInfo * _Nullable serverInfo) {
               weakSelf.dataArr = [ZBNMyCollectionM mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"]];
               if (weakSelf.dataArr.count < 10) {
                   weakSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
               }
               [weakSelf.tableView.mj_header endRefreshing];
               [weakSelf.tableView reloadData];
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
       [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:ZBNCollectionURL params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
           NSArray *newData = [ZBNMyCollectionM mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"]];
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
