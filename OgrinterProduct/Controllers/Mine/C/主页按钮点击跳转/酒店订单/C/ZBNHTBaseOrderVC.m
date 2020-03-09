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
#import "ZBNComDataNilCell.h"
#import "ZBNRefreshHeader.h"


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
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
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
    if (self.dataArr.count >= 1) {
        return self.dataArr.count;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArr.count >= 1) {
        ZBNHTComCell *cell = [ZBNHTComCell regiserCellForTable:tableView];
        cell.comM = self.dataArr[indexPath.row];
        return cell;
    } else {
        ZBNComDataNilCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNComDataNilCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArr.count >= 1) {
        return 300;
    } else {
        return self.view.height;
    }
}


- (void)loadNewData
{
    self.page = @"2";
    [FKHRequestManager cancleRequestWork];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    self.tableView.mj_footer.state = MJRefreshStateIdle;
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    params[@"uid"] = unmodel.uid;
    params[@"token"] = unmodel.token;
    params[@"page"] = @"1";
    ADWeakSelf;
       [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:ZBNHTOrderURL params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
           
           weakSelf.dataArr = [ZBNHTComModel mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"]];
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
    params[@"page"] = self.page;
    ADWeakSelf;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:ZBNHTOrderURL params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        NSArray *moreArr = [ZBNHTComModel mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"]];
        [weakSelf.dataArr addObjectsFromArray:moreArr];
        if (moreArr.count < 10) {
            weakSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
        } else {
            [weakSelf.tableView.mj_footer endRefreshing];
        }
        [weakSelf.tableView reloadData];
        self.page = [NSString stringWithFormat:@"%d",(weakSelf.page.intValue + 1)];
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
