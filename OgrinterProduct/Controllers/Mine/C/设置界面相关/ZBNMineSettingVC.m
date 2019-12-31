//
//  ZBNMineSettingVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/27.
//  Copyright © 2019 RXF. All rights reserved.
//


#import "ZBNMineSettingVC.h"
#import "ZBNMineSettingCell.h"
#import "ZBNEntryFooterView.h"

#import "ZBNMineSettingAboutUsVC.h"
#import "ZBNMineFeedbackVC.h"
#import "ZBNMineSettingModel.h"


@interface ZBNMineSettingVC ()

@property (nonatomic, weak) ZBNEntryFooterView *footerV;
@property (nonatomic, strong) ZBNMineSettingModel *settingM;

@end

@implementation ZBNMineSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(getRectNavAndStatusHight, 0, 0, 0);
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    
    // 设置底部的视图
    ZBNEntryFooterView *footerV = [ZBNEntryFooterView viewFromXib];
    footerV.x = 0;
    footerV.height = 150;
    footerV.width = self.view.width;
    footerV.y = KSCREEN_HEIGHT - 150 - getRectNavAndStatusHight;
    footerV.setButtonText(@"退出登录");
    // --->  退出按钮的点击监听
    footerV.middleBtnClickTask = ^{
        
    };
    self.tableView.tableFooterView = footerV;
    self.footerV = footerV;
    
    [self loadSettingVcData];
}

- (void)loadSettingVcData
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    params[@"uid"] = unmodel.uid;
    params[@"token"] = unmodel.token;
    ADWeakSelf;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/api/opinion/set" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        self.settingM = [ZBNMineSettingModel mj_objectWithKeyValues:serverInfo.response[@"data"]];
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
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 524;
}

@end
