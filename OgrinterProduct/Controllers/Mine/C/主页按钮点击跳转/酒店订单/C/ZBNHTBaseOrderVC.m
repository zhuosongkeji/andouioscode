//
//  ZBNHTBaseOrderVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/11.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNHTBaseOrderVC.h"

#import "ZBNHTComModel.h"  // 酒店通用模型
#import "ZBNHTComCell.h"


@interface ZBNHTBaseOrderVC ()
/*! 模型数据 */
@property (nonatomic, strong) ZBNHTComModel *model;
/*! 保存数据的数组 */
@property (nonatomic, strong) NSMutableArray *dataArr;
/*! 用来存储分页 */
@property (nonatomic, copy) NSString *page;

@end

@implementation ZBNHTBaseOrderVC

- (ZBNHTComType)type
{
    return 100;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRefresh];
    // 设置tableView
    [self setupTable];
}


- (void)setupTable
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    ZBNHTComCell *cell = [ZBNHTComCell regiserCellForTable:tableView];
    cell.comM = self.dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}


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
       [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/hotel/order" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
           NSArray *allDataArr = [ZBNHTComModel mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"]];
           for (ZBNHTComModel *model in allDataArr) {
               if (model.status.intValue == 0) {
                   [self.dataArr addObject:model];
               } else if (model.status.intValue == 20) {
                   [self.dataArr addObject:model];
               } else if (model.status.intValue == 40) {
                   [self.dataArr addObject:model];
               }
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
    params[@"type"] = @(self.type);
    params[@"page"] = self.page;
    ADWeakSelf;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/hotel/order" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        NSArray *moreArr = [ZBNHTComModel mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"]];
        for (ZBNHTComModel *model in moreArr) {
            if (model.status.intValue == 0) {
                    [self.dataArr addObject:model];
                } else if (model.status.intValue == 20) {
                    [self.dataArr addObject:model];
                } else if (model.status.intValue == 40) {
                    [self.dataArr addObject:model];
                }
        }
        [weakSelf.tableView reloadData];
        self.page = [NSString stringWithFormat:@"%d",(weakSelf.page.intValue + 1)];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
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
