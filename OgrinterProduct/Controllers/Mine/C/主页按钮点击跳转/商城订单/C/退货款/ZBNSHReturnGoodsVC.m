//
//  ZBNSHReturnGoodsVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/19.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSHReturnGoodsVC.h"
#import "ZBNSHOrderDetailsM.h"
#import "ZBNSHAppReturnGoodsCell.h"

@interface ZBNSHReturnGoodsVC ()

@property (nonatomic, strong) ZBNSHOrderDetailsM *detailsM;

@end

@implementation ZBNSHReturnGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 加载数据
    [self loadData];
    
    [self setupTable];
    
}
- (void)setupTable
{
    // 关于内容视图
    self.tableView.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.title = @"退款";
    self.tableView.bounces = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }else {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
}

- (void)loadData
{
    ADWeakSelf;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    params[@"uid"] = unmodel.uid;
    params[@"token"] = unmodel.token;
    params[@"order_sn"] = self.order_goods_id;
    params[@"did"] = self.did;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/order/details" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        self.detailsM = [ZBNSHOrderDetailsM mj_objectWithKeyValues:[serverInfo.response[@"data"] valueForKeyPath:@"details"][0]];
        [weakSelf.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ADWeakSelf;
    ZBNSHAppReturnGoodsCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNSHAppReturnGoodsCell" owner:nil options:nil].firstObject;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.detailsM = self.detailsM;
    cell.orderNum = self.detailsM.ID;
    cell.requestSuccessBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 560;
}




@end
