//
//  ZBNMyIntegralVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/11.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMyIntegralVC.h"
#import "ZBNMyWalletComCell.h"
#import "ZBNMyIntegerHeadView.h"
#import "ZBNMyIntegralModel.h"


@interface ZBNMyIntegralVC ()

/*! 储存数据的数组 */
@property (nonatomic, strong) NSMutableArray *dataArr;
/*! 模型 */
@property (nonatomic, strong) ZBNMyIntegralModel *integerM;

@end


@implementation ZBNMyIntegralVC

#pragma mark -- 生命周期方法

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置UI界面
    [self setupUI];
    // 加载数据
    [self loadData];
    // 加载测试数据
//    [self initModel];
}

/*! 设置UI */
- (void)setupUI
{
    self.navigationItem.title = @"我的积分";
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.tableView.contentInset = UIEdgeInsetsMake(getRectNavAndStatusHight, 0, 0, 0);
    ZBNMyIntegerHeadView *headView = [ZBNMyIntegerHeadView viewFromXib];
    headView.height = ZBNHeaderH;
    self.tableView.tableHeaderView = headView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

/*! 加载数据 */
- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    params[@"uid"] = unmodel.uid;
    params[@"token"] = unmodel.token;
    params[@"page"] = @1;
    ADWeakSelf;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:ZBNIntegerURL params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        weakSelf.dataArr = [ZBNMyIntegralModel mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"][@"log"]];
    }];
}


///*! 加载假数据 */
//- (void)initModel
//{
//    for (int i = 0;i<8;i++) {
//        ZBNMyIntegralModel *model = [[ZBNMyIntegralModel alloc] init];
//        if (i % 2 == 0) {
//            model.create_time = @"昨晚";
//            model.describe = @"购买大保健";
//            model.price = @"-998";
//        } else {
//            model.create_time = @"前天";
//            model.describe = @"充值获得";
//            model.price = @"+998";
//        }
//        [self.dataArr addObject:model];
//    }
//}

#pragma mark -- tableView的代理和数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNMyWalletComCell *cell = [ZBNMyWalletComCell registerCellForTableView:tableView];
    cell.integerM = self.dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark -- lazy

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end
