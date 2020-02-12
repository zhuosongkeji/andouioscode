//
//  ZBNSHComViewLogisticsVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/10.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSHComViewLogisticsVC.h"

#import "ZBNSHDetailLogisticsModel.h"
#import "ZBNSHComViewLogisticsModel.h"
#import "ZBNSHComViewLogisticsCell.h"
#import "ZBNSHComViewLogisticsHeader.h"

@interface ZBNSHComViewLogisticsVC ()

/*! 存储数据的模型 */
@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) ZBNSHComViewLogisticsModel *logisticsM;
@property (nonatomic, strong) ZBNSHDetailLogisticsModel *detailM;
@property (nonatomic, strong) ZBNSHComViewLogisticsHeader *headV;

@end

@implementation ZBNSHComViewLogisticsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self setHeader];
    self.navigationItem.title = @"物流详情";
    self.navigationController.navigationBar.translucent = NO;
    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setHeader
{
    ZBNSHComViewLogisticsHeader *header = [ZBNSHComViewLogisticsHeader viewFromXib];
    header.height = 100;
    self.headV = header;
    self.tableView.tableHeaderView = self.headV;
}

/*! 发送网络请求加载数据 */
- (void)loadData
{
    [FKHRequestManager cancleRequestWork];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    // 相关参数
    params[@"uid"] = unmodel.uid;
    params[@"token"] = unmodel.token;
    params[@"express_id"] = self.express_id;
    params[@"courier_num"] = self.courier_num;
    ADWeakSelf;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/order/express" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        weakSelf.logisticsM = [ZBNSHComViewLogisticsModel mj_objectWithKeyValues:serverInfo.response[@"data"]];
        self.headV.vcM = weakSelf.logisticsM;
        weakSelf.dataArr = [ZBNSHDetailLogisticsModel mj_objectArrayWithKeyValuesArray:[serverInfo.response[@"data"] objectForKey:@"wuliu_msg"][@"data"]];
        [weakSelf.tableView reloadData];
        for (ZBNSHDetailLogisticsModel *model in weakSelf.dataArr) {
            if (model == weakSelf.dataArr.firstObject) {
                model.firstOne = YES;
            } else {
                model.firstOne = NO;
            }
        }
    }];
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNSHComViewLogisticsCell *cell = [ZBNSHComViewLogisticsCell regiserCellForTable:tableView];
    cell.detailM = self.dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNSHDetailLogisticsModel *model = self.dataArr[indexPath.row];
    return model.height;
}

#pragma mark - lazy

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end
