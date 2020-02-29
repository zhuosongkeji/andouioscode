//
//  ZBNMyNewsVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/11.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMyNewsVC.h"
#import "ZBNMyNewsCell.h"
#import "ZBNMyNewsDetailVC.h"
#import "ZBNMyNewsModel.h"

@interface ZBNMyNewsVC ()
/*! 储存数据的数组 */
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation ZBNMyNewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置table
    [self setupTable];
    // 发起请求
    [self loadData];
}


- (void)setupTable
{
    self.tableView.bounces = NO;
    self.navigationItem.title = @"通知信息";
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.navigationController.navigationBar.translucent = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNMyNewsCell *cell = [ZBNMyNewsCell registerCellForTable:tableView];
    cell.news = self.dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

/*! 点击cell */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNMyNewsDetailVC *vc = [[ZBNMyNewsDetailVC alloc] init];
    ZBNMyNewsModel *model = self.dataArr[indexPath.row];
    vc.get_id = model.ID;
    NSLog(@"%@model",model.ID);
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -- request

- (void)loadData {
    [FKHRequestManager cancleRequestWork];
       NSMutableDictionary *params = [NSMutableDictionary dictionary];
       NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
       userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
       params[@"uid"] = unmodel.uid;
       ADWeakSelf;
       [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:ZBNNotificationCenterlURL params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
           if ([[serverInfo.response objectForKey:@"code"] intValue] == 200) {
               weakSelf.dataArr = [ZBNMyNewsModel mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"]];
               [weakSelf.tableView reloadData];
           } else {
               [HUDManager showStateHud:[serverInfo.response objectForKey:@"msg"] state:HUDStateTypeFail];
           }
       }];
}

@end
