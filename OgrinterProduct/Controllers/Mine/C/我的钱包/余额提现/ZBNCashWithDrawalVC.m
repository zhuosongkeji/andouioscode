//
//  ZBNCashWithDrawalVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/14.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNCashWithDrawalVC.h"
#import "ZBNCashWithDrawalCell.h"
#import "ZBNEntryFooterView.h"
#import "ZBNSuccessfulWthdrawalsVC.h"
#import "ZBNRechargeCellThree.h"

@interface ZBNCashWithDrawalVC ()

@property (nonatomic, weak) ZBNEntryFooterView *footerView;

@end

@implementation ZBNCashWithDrawalVC

- (instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"余额提现";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setupFooter];
}



- (void)setupFooter
{
    ZBNEntryFooterView *footerView = [ZBNEntryFooterView viewFromXib];
    footerView.height = 150;
    self.footerView = footerView;
    self.footerView.setButtonText(@"确认提现");
    ADWeakSelf;
    self.footerView.middleBtnClickTask = ^{
        ZBNSuccessfulWthdrawalsVC *successfulVc = [[ZBNSuccessfulWthdrawalsVC alloc] init];
        [weakSelf.navigationController pushViewController:successfulVc animated:YES];
    };
    
    self.tableView.tableFooterView = footerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ZBNCashWithDrawalCell *cell = [ZBNCashWithDrawalCell regiserCellForTableView:tableView];
        return cell;
    } else {
        ZBNRechargeCellThree *threeCell = [ZBNRechargeCellThree registerCellForTableView:tableView];
        if (indexPath.row == 1) {
            threeCell.textOne.text = @"请输入提现账号:";
        }
        return threeCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 150;
    } else {
        return 48;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    } else {
        return 2;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}


@end
