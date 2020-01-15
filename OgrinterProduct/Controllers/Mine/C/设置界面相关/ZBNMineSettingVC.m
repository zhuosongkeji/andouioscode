//
//  ZBNMineSettingVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/27.
//  Copyright © 2019 RXF. All rights reserved.
//  设置界面控制器


#import "ZBNMineSettingVC.h"

#import "ZBNMineSettingCell.h"   // 设置界面的cell
#import "ZBNEntryFooterView.h"  // 通用的底部视图类
#import "ZBNMineSettingAboutUsVC.h" // 关于我们
#import "ZBNMineFeedbackVC.h"  // 反馈信息的控制器
#import "ZBNMineSettingModel.h" // 模型类
#import "ZBNChangePhoneNumberVC.h"  // 修改手机号
#import "ZBNChangePwdVC.h"     // 修改密码
#import "LoginViewController.h"

@interface ZBNMineSettingVC ()
/*! 底部视图 */
@property (nonatomic, weak) ZBNEntryFooterView *footerV;
/*! 模型数据 */
@property (nonatomic, strong) ZBNMineSettingModel *settingM;
@end

@implementation ZBNMineSettingVC

#pragma mark -- 生命周期方法

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置table
    [self setupTable];
    // 设置底部视图
    [self setupFooterView];
    // 加载数据
    [self loadSettingVcData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOK) name:@"loginOK" object:nil];
    
}

/*! 设置tableView */
- (void)setupTable
{
    self.tableView.contentInset = UIEdgeInsetsMake(getRectNavAndStatusHight, 0, 0, 0);
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.navigationItem.title = @"设置";
    self.tableView.bounces = NO;
}
/*! 设置底部视图 */
- (void)setupFooterView
{
    // 设置底部的视图
    ZBNEntryFooterView *footerV = [ZBNEntryFooterView viewFromXib];
    footerV.x = 0;
    footerV.height = 150;
    footerV.width = self.view.width;
    footerV.y = KSCREEN_HEIGHT - 150 - getRectNavAndStatusHight;
    footerV.setButtonText(@"退出登录");
    
    // --->  退出按钮的点击监听 ----------------------------> >>>>>>>>> 在这里
    ADWeakSelf;
    footerV.middleBtnClickTask = ^{

        [weakSelf exitRequest];
        [weakSelf loadSettingVcData];

        [self exitRequest];
        [self loadSettingVcData];

    };
    self.tableView.tableFooterView = footerV;
    self.footerV = footerV;
}


- (void)loginOK
{
    [self loadSettingVcData];
}

- (void)exitRequest
{
    // 拿到uid 和 token
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    params[@"uid"] = unmodel.uid;
    params[@"token"] = unmodel.token;
     [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/goods/quit" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
          
       }];
}

/*! 加载数据 */
- (void)loadSettingVcData
{
    // 拿到uid 和 token
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    params[@"uid"] = unmodel.uid;
    params[@"token"] = unmodel.token;
    ADWeakSelf;
    // 发送网络请求
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:ZBNPersonSettingURL params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        
        
        NSLog(@"%@loadData",serverInfo.response[@"data"]);
        // 将字典转换成模型
        weakSelf.settingM = [ZBNMineSettingModel mj_objectWithKeyValues: serverInfo.response[@"data"]];
        // 刷新table
        [weakSelf.tableView reloadData];
    }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNMineSettingCell *cell = [ZBNMineSettingCell regiserCellForTable:tableView];
    cell.settingM = self.settingM;
    // 关于我们的点击
    ADWeakSelf;
    cell.aboutUsCellClickTask = ^{
        ZBNMineSettingAboutUsVC *vc = [[ZBNMineSettingAboutUsVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    // 反馈
    cell.feedbackClickTask = ^{
        ZBNMineFeedbackVC *vc = [[ZBNMineFeedbackVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    // 修改手机号码
    cell.changePhoneNumClickTask = ^{
        ZBNChangePhoneNumberVC *vc = [[ZBNChangePhoneNumberVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    // 修改密码
    cell.changePwdClickTask = ^{
        ZBNChangePwdVC *vc = [[ZBNChangePwdVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    // 清除缓存
    cell.cacheClearClickTask = ^{
        
    };
    return cell;
}

// cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 暂定
    return 524;
}

@end
