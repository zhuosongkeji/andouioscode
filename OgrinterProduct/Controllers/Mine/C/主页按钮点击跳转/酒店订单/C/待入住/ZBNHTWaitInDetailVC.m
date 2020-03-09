//
//  ZBNHTWaitInDetailVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/14.
//  Copyright © 2020 RXF. All rights reserved.
//  待入住的订单详情

#import "ZBNHTWaitInDetailVC.h"
#import "ZBNHTWaitInDetailCell.h"
#import "ZBNHTComDetailModel.h"
@interface ZBNHTWaitInDetailVC ()
/*! 模型数据 */
@property (nonatomic, strong) ZBNHTComDetailModel *detailM;
@end

@implementation ZBNHTWaitInDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
    
    [self loadData];
}

- (void)setupTable
{
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.title = @"订单详情";
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.tableView.bounces = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNHTWaitInDetailCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNHTWaitInDetailCell" owner:nil options:nil].lastObject;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.detailM = self.detailM;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 982;
}


- (void)loadData
{
    ADWeakSelf;
    [FKHRequestManager cancleRequestWork];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
        NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
        userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
        params[@"uid"] = unmodel.uid;
        params[@"token"] = unmodel.token;
        params[@"book_sn"] = @[self.book_sn];
    
        [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:ZBNHTOrderdatailsURL params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
            self.detailM = [ZBNHTComDetailModel mj_objectWithKeyValues:serverInfo.response[@"data"]];
            [weakSelf.tableView reloadData];
        }];
}



@end
