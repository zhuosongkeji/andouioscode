//
//  ZBNMyAddressVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/11.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMyAddressVC.h"
#import "ZBNMyAddressCell.h"
#import "ZBNMyAddressModel.h"
#import "ZBNEntryFooterView.h"
#import "ZBNNewAddressVC.h"
#import "ZBNRefreshHeader.h"
#import "ZBNAddressChangeVC.h"

@interface ZBNMyAddressVC () <ZBNMyAddressCellDelegate>
/*! 保存地址模型的数组 */
@property (nonatomic, strong) NSMutableArray *addressArray;

@property (nonatomic, weak) ZBNEntryFooterView *footerView;


@end

@implementation ZBNMyAddressVC

static NSString * const ZBNMyAddressCellID = @"address";



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化模型数据
    [self setupRefresh];
    // 设置table
    [self setupTable];
    // 设置底部的view
    [self setupFooterView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"popView" object:nil];
    
}

/*! 设置table */
- (void)setupTable
{
 
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }else {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    
    self.navigationItem.title = @"我的地址";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"changeOK" object:nil];
}

- (void)setupRefresh
{
    // 下拉刷新
    self.tableView.mj_header = [ZBNRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];

}


- (void)setupFooterView
{
    ZBNEntryFooterView *footerView = [ZBNEntryFooterView viewFromXib];
    footerView.height = 150;
    self.tableView.tableFooterView = footerView;
    self.footerView = footerView;
    self.footerView.setButtonText(@"新增地址");
    self.footerView.middleBtnClickTask = ^{
        ZBNNewAddressVC *newAddressVc = [[ZBNNewAddressVC alloc] init];
        [self.navigationController pushViewController:newAddressVc animated:YES];
    };
}

/*! 加载数据 */
- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    params[@"uid"] = unmodel.uid;
    params[@"token"] = unmodel.token;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/api/Usersaddress/address" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        self.addressArray = [ZBNMyAddressModel mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"]];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.addressArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    
    ZBNMyAddressCell *cell = [ZBNMyAddressCell registerCellForTable:tableView];
    cell.delegate = self;
    cell.addModel = self.addressArray[indexPath.row];
    // 设置默认
    cell.DefaultClickTask = ^(ZBNMyAddressModel * _Nonnull model) {
        for (ZBNMyAddressModel *addModel in self.addressArray) {
            if (model == addModel) {
                NSMutableDictionary *params = [NSMutableDictionary dictionary];
                params[@"uid"] = unmodel.uid;
                params[@"token"] = unmodel.token;
                params[@"id"] = model.ID;
                if (model.is_defualt == YES) {
                    // 如果原本就是默认地址,不做操作
                } else {
                    // 发送网络请求,更改默认地址
                    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/api/Usersaddress/defualt" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
                        addModel.is_defualt = YES;
                        [HUDManager showStateHud:@"设置默认地址成功" state:HUDStateTypeSuccess];
                        [self.tableView reloadData];
                    }];
                }
                
                
            } else {
                addModel.is_defualt = NO;
            }
        }
        
    };
    // 删除点击
    ADWeakSelf;
    cell.deleteAddClickTask = ^(ZBNMyAddressModel * _Nonnull model) {
        for (ZBNMyAddressModel *addMole in self.addressArray) {
            if (model == addMole) {
                NSMutableDictionary *params = [NSMutableDictionary dictionary];
                params[@"uid"] = unmodel.uid;
                params[@"token"] = unmodel.token;
                params[@"id"] = model.ID;
                [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/api/Usersaddress/address_del" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
                    [weakSelf.addressArray removeObject:model];
                    [weakSelf.tableView reloadData];
                    [HUDManager showStateHud:@"删除地址成功" state:HUDStateTypeSuccess];
                }];
                
            }
        }
        [self.tableView reloadData];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNMyAddressModel *model = self.addressArray[indexPath.row];
    return model.cellHeight;
}

/*!  cell的代理方法 */
- (void)ZBNMyAddressCellDidClickChangeButton:(ZBNMyAddressCell *)cell
{
    
    for (ZBNMyAddressModel *model in self.addressArray) {
        if (model == cell.addModel) {
            ZBNAddressChangeVC *vc  = [[ZBNAddressChangeVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            vc.addM = cell.addModel;
        }
    }
    
}



#pragma mark -- lazy

- (NSMutableArray *)addressArray
{
    if (!_addressArray) {
        _addressArray = [NSMutableArray array];
    }
    return _addressArray;
}

@end
