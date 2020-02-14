//
//  ZBNHTCancelVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/14.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNHTCancelVC.h"
#import "ZBNHTCancelCell.h"
#import "ZBNHTComDetailModel.h"

@interface ZBNHTCancelVC ()
@property (nonatomic, strong) ZBNHTComDetailModel *detailM;
@end

@implementation ZBNHTCancelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
    
    [self loadData];
}

- (void)setupTable
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.tableView.bounces = NO;
    self.navigationItem.title = @"订单详情";
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNHTCancelCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNHTCancelCell" owner:nil options:nil].lastObject;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.detailM = self.detailM;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 936;
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
    
        [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/htorder/orderdatails" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {

            self.detailM = [ZBNHTComDetailModel mj_objectWithKeyValues:serverInfo.response[@"data"]];
            [weakSelf.tableView reloadData];
        }];
}


@end
