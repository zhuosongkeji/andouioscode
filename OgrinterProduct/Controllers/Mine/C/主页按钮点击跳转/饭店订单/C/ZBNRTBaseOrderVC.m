//
//  ZBNRTBaseOrderVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/16.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNRTBaseOrderVC.h"

#import "ZBNRTComModel.h"
#import "ZBNCommenOrderCell.h"
#import "ZBNRTComDetailVC.h"
#import "ZBNComDataNilCell.h"

@interface ZBNRTBaseOrderVC ()

/*! 储存模型的数组 */
@property (nonatomic, strong) NSMutableArray *dataArr;
/*! 用来存储页码 */
@property (nonatomic, copy) NSString *page;
/*! 用来记录模型 */
@property (nonatomic, strong) ZBNRTComModel *comM;

@end

@implementation ZBNRTBaseOrderVC

#pragma mark -- life

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置table
    [self setupTable];
    // 加载数据
    [self setupRefresh];

}


#pragma mark -- UI
- (void)setupTable
{
    self.page = @"2";
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataArr.count < 1) {
        return 1;
    } else {
        return self.dataArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArr.count >= 1) {
        ZBNCommenOrderCell *cell = [ZBNCommenOrderCell regiserCellForTable:tableView];
        cell.comM = self.dataArr[indexPath.row];
        self.comM = cell.comM;
        ADWeakSelf;
        cell.detailBtnClickTask = ^{
            ZBNRTComDetailVC *vc = [[ZBNRTComDetailVC alloc] init];
            vc.order_id = weakSelf.comM.ID;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        return cell;
    } else {
        
        ZBNComDataNilCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNComDataNilCell" owner:nil options:nil].lastObject;
              return cell;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.dataArr.count >= 1) {
        ZBNRTComModel *model = self.dataArr[indexPath.row];
        return model.cellHeight;
    } else {
        return self.tableView.height;
    }
}

#pragma mark -- netRequest

- (void)loadNewData
{
    [FKHRequestManager cancleRequestWork];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    params[@"uid"] = unmodel.uid;
    params[@"token"] = unmodel.token;
    params[@"page"] = @"1";
    params[@"status"] = @(self.type);
    ADWeakSelf;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl: ZBNGourmetURL params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        NSArray *allData = [ZBNRTComModel mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"]];
        for (ZBNRTComModel *model in allData) {
            if (model.status.intValue == 10) {
                [weakSelf.dataArr addObject:model];
            } else if (model.status.intValue == 30) {
                [weakSelf.dataArr addObject:model];
            } else if (model.status.intValue == 40) {
                [weakSelf.dataArr addObject:model];
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
       params[@"page"] = self.page;
       params[@"status"] = @(self.type);
       ADWeakSelf;
       [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl: ZBNGourmetURL params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
           NSArray *allData = [ZBNRTComModel mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"]];
           for (ZBNRTComModel *model in allData) {
               if (model.status.intValue == 10) {
                   [weakSelf.dataArr addObject:model];
               } else if (model.status.intValue == 30) {
                   [weakSelf.dataArr addObject:model];
               } else if (model.status.intValue == 40) {
                   [weakSelf.dataArr addObject:model];
               }
           }
           [weakSelf.tableView reloadData];
           self.page = [NSString stringWithFormat:@"%d",self.page.intValue + 1];
           [weakSelf.tableView.mj_footer endRefreshing];
       }];
}


#pragma mark -- lazy

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

#pragma mark -- Other

- (ZBNRTType)type
{
    return 0;
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


@end
