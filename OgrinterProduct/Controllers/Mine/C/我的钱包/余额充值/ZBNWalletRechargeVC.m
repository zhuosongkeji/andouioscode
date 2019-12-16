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

@interface ZBNWalletRechargeVC ()

@end

@implementation ZBNWalletRechargeVC

- (instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
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
        return cell;
    } else if (indexPath.section == 1) {
        ZBNRechargeCellTwo *twoCell = [ZBNRechargeCellTwo registerCellForTableView:tableView];
        return twoCell;
    } else if (indexPath.section == 2) {
        ZBNRechargeCellThree *threeCell = [ZBNRechargeCellThree registerCellForTableView:tableView];
        return threeCell;
    } else {
        if (indexPath.row == 0) {
            ZBNRechargeCellTwo *twoCell = [ZBNRechargeCellTwo registerCellForTableView:tableView];
            return twoCell;
        } else if (indexPath.row == 4) {
            ZBNRechargeCellThree *threeCell = [ZBNRechargeCellThree registerCellForTableView:tableView];
            return threeCell;
        } else {
            ZBNRechargeCellFour *fourCell = [ZBNRechargeCellFour registerCellForTableView:tableView];
            return fourCell;
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}




@end
