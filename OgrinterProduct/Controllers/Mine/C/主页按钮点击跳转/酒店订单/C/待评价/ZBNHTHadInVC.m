//
//  ZBNHTHadInVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/14.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNHTHadInVC.h"
#import "ZBNHTHadInCell.h"
#import "ZBNHTComDetailModel.h"
@interface ZBNHTHadInVC ()

/*! 模型数据 */
@property (nonatomic, strong) ZBNHTComDetailModel *detailM;

@end

@implementation ZBNHTHadInVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    [self setupTable];
}

- (void)setupTable
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.title = @"订单详情";
    self.tableView.contentInset = UIEdgeInsetsMake(getRectNavAndStatusHight, 0, 0, 0);
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.tableView.bounces = NO;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNHTHadInCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNHTHadInCell" owner:nil options:nil].lastObject;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.detailM = self.detailM;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 773;
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
