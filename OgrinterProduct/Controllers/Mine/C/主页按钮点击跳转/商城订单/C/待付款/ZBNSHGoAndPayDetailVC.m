//
//  ZBNSHGoAndPayDetailVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/20.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNSHGoAndPayDetailVC.h"

#import "ZBNSHGoAndPayDetailCell.h"
#import "ZBNSHCommonHeadV.h"

#import "ZBNSHOrderDetailComM.h"
#import "ZBNSHOrderUserInfoM.h"
#import "ZBNSHOrderDetailsM.h"

#import "ZBNSHCommonPayVC.h"

@interface ZBNSHGoAndPayDetailVC ()

@property (nonatomic, weak) ZBNSHCommonHeadV *headV;

@property (nonatomic, strong) ZBNSHOrderUserInfoM *userInfoM;
@property (nonatomic, strong) ZBNSHOrderDetailsM *detailsM;
@property (nonatomic, strong) ZBNSHOrderDetailComM *comM;

@property (nonatomic, strong) NSMutableArray *detailArr;

@end

@implementation ZBNSHGoAndPayDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置UI视图
    [self setupUI];
    // 设置头部视图
    [self setupHeaderView];
    // 加载数据
    [self loadData];

    
}


- (void)setupUI
{
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(getRectNavAndStatusHight, 0, 0, 0);
}

- (void)setupHeaderView
{
    ZBNSHCommonHeadV *headV = [ZBNSHCommonHeadV viewFromXib];
    headV.height = ZBNHeaderH;
    headV.setLabelOneText(@"待付款").setSubLabelOneText(@"等待买家付款").setImageVImage(@"组 3-2");
    self.tableView.tableHeaderView = headV;
    self.headV = headV;
}

/*! 加载模型数据 */
- (void)loadData
{
    ADWeakSelf;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
        NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
        userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
        params[@"uid"] = unmodel.uid;
        params[@"token"] = unmodel.token;
        params[@"order_sn"] = self.getOrderNum;
        [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/order/details" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
            self.comM = [ZBNSHOrderDetailComM mj_objectWithKeyValues:serverInfo.response[@"data"]];
            self.comM.details = [ZBNSHOrderDetailsM mj_objectWithKeyValues:[serverInfo.response[@"data"] valueForKeyPath:@"details"][0]];
            [weakSelf.tableView reloadData];
        }];
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNSHGoAndPayDetailCell *cell = [ZBNSHGoAndPayDetailCell regiserCellForTable:tableView];
    ADWeakSelf;
    cell.goAndPayBtnClickTask = ^{
        ZBNSHCommonPayVC *vc = [[ZBNSHCommonPayVC alloc] init];
        vc.order_id = self.getOrderNum;
        
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    cell.comM = self.comM;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 500;
}


@end
