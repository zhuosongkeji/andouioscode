//
//  ZBNWalletRechargeVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/16.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNWalletRechargeVC.h"
#import "ZBNRechargeCell.h"
#import "ZBNRechargeCellTwo.h"
#import "ZBNRechargeCellThree.h"
#import "ZBNRechargeCellFour.h"
#import "ZBNEntryFooterView.h"

@interface ZBNWalletRechargeVC ()

@property (nonatomic, weak) ZBNEntryFooterView *footerView;

@end

@implementation ZBNWalletRechargeVC

- (instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"余额充值";
    
    [self setupTableView];
}

- (void)setupTableView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    ZBNEntryFooterView *footerV = [ZBNEntryFooterView viewFromXib];
    footerV.height = 150;
    self.footerView = footerV;
    self.footerView.setButtonText(@"确认充值");
    self.tableView.tableFooterView = footerV;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 2;
    } else if (section == 2) {
        return 1;
    } else {
        return 5;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ZBNRechargeCell *cell = [ZBNRechargeCell registerCellForTableView:tableView];
        cell.moneyLabel.text = self.moneyText;
        return cell;
    } else if (indexPath.section == 1) {
        ZBNRechargeCellTwo *twoCell = [ZBNRechargeCellTwo registerCellForTableView:tableView];
        if (indexPath.row == 1) {
            twoCell.textOne.text = @"999";
        }
        return twoCell;
    } else if (indexPath.section == 2) {
        ZBNRechargeCellThree *threeCell = [ZBNRechargeCellThree registerCellForTableView:tableView];
        
        return threeCell;
    } else {
        if (indexPath.row == 0) {
            ZBNRechargeCellTwo *twoCell = [ZBNRechargeCellTwo registerCellForTableView:tableView];
            twoCell.textOne.text = @"请选择充值方式";
            return twoCell;
        } else if (indexPath.row == 4) {
            ZBNRechargeCellThree *threeCell = [ZBNRechargeCellThree registerCellForTableView:tableView];
            threeCell.numberLabel.text = @"622202***323";
            threeCell.textOne.text = @"请输入账号";
            return threeCell;
        } else {
            ZBNRechargeCellFour *fourCell = [ZBNRechargeCellFour registerCellForTableView:tableView];
            if (indexPath.row == 1) {
                fourCell.textOne.text = @"银联支付";
            } else if (indexPath.row == 2) {
                fourCell.textOne.text = @"微信支付";
                fourCell.iconImagev.image = [UIImage imageNamed:@"微信支付"];
            } else {
                fourCell.textOne.text = @"支付宝支付";
                fourCell.iconImagev.image = [UIImage imageNamed:@"zhifub"];
            }
            return fourCell;
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    } else {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 2;
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
