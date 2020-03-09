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
#import "ZBNRTFoodsModel.h"
#import "ZBNRefreshHeader.h"

@interface ZBNRTBaseOrderVC ()

/*! 储存模型的数组 */
@property (nonatomic, strong) NSMutableArray *dataArr;
/*! 用来存储页码 */
@property (nonatomic, copy) NSString *page;

@end

@implementation ZBNRTBaseOrderVC

#pragma mark -- life

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置table
    [self setupTable];
    // 加载数据
    [self setupRefresh];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginRefresh) name:@"loginOK" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginRefresh) name:@"paySuccess" object:nil];
}

- (void)beginRefresh
{
    [self loadNewData];
}

#pragma mark -- UI
- (void)setupTable
{
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
        ZBNCommenOrderCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNCommenOrderCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.comM = self.dataArr[indexPath.row];
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
    self.page = @"2";
    [self.dataArr removeAllObjects];
    [FKHRequestManager cancleRequestWork];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    self.tableView.mj_footer.state = MJRefreshStateIdle;
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    params[@"uid"] = unmodel.uid;
    params[@"token"] = unmodel.token;
    params[@"page"] = @"1";
    params[@"status"] = @(self.type);
    ADWeakSelf;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl: ZBNGourmetURL params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([[serverInfo.response objectForKey:@"code"] intValue] == 202) {
            [weakSelf.tableView.mj_header endRefreshing];
        }
        weakSelf.dataArr = [ZBNRTComModel mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"]];
        if (weakSelf.dataArr.count < 8) {
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
       params[@"page"] = self.page;
       params[@"status"] = @(self.type);
       ADWeakSelf;
       [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl: ZBNGourmetURL params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
           NSArray *allData = [ZBNRTComModel mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"]];
           [weakSelf.dataArr addObjectsFromArray:allData];
           if (allData.count < 8) {
               weakSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
           } else {
               [weakSelf.tableView.mj_footer endRefreshing];
           }
           [weakSelf.tableView reloadData];
           self.page = [NSString stringWithFormat:@"%d",self.page.intValue + 1];
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
    self.tableView.mj_header = [ZBNRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}


@end
