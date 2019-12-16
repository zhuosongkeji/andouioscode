//
//  ZBNHotelEntryVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/12.
//  Copyright © 2019 RXF. All rights reserved.
//  酒店商家入驻

#import "ZBNHotelEntryVC.h"
#import "ZBNEntryCellOne.h"
#import "ZBNEntryCellTwo.h"
#import "ZBNEntryCellThree.h"
#import "ZBNEntryFooterView.h"

@interface ZBNHotelEntryVC ()

@property (nonatomic, weak) ZBNEntryFooterView *footerView;

@end

@implementation ZBNHotelEntryVC

- (instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"酒店入驻";
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(- 30, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self setupFooter];
    
}

- (void)setupFooter
{
    ZBNEntryFooterView *footerV = [ZBNEntryFooterView viewFromXib];
    footerV.height = 150;
    self.tableView.tableFooterView = footerV;
    self.footerView = footerV;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 3;
    } else if (section == 1) {
        return 2;
    } else if (section == 2) {
        return 1;
    } else if (section == 3) {
        return 1;
    } else {
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ZBNEntryCellOne *oneCell = [ZBNEntryCellOne registerCellForTableView:tableView];
        if (indexPath.row == 0) {
            oneCell.textOne.text = @"商户名称";
            oneCell.textTwo.text = @"安抖公寓";
            return oneCell;
        } else if (indexPath.row == 1) {
            oneCell.textOne.text = @"联系人";
            oneCell.textTwo.text = @"安抖";
            return oneCell;
        } else {
            oneCell.textOne.text = @"联系电话";
            oneCell.textTwo.text = @"999999999999";
            return oneCell;
        }
    } else if (indexPath.section == 1) {
        ZBNEntryCellOne *oneCell = [ZBNEntryCellOne registerCellForTableView:tableView];
        if (indexPath.row == 0) {
            oneCell.textOne.text = @"店铺地址";
            oneCell.textTwo.text = @"重庆市南岸";
            return oneCell;
        } else {
            oneCell.textOne.text = @"详细地址";
            oneCell.textTwo.text = @"重庆市南岸区里面很里面";
            return oneCell;
        }
    } else if (indexPath.section == 2) {
        ZBNEntryCellTwo *twoCell = [ZBNEntryCellTwo registerCellForTableView:tableView];
        twoCell.textOne.text = @"商家简介";
        twoCell.textTwo.text = @"这是一个很厉害的商家喔这是一个很厉害的商家喔这是一个很厉害的商家喔这是一个很厉害的商家喔这是一个很厉害的商家喔";
        return twoCell;
    } else if (indexPath.section == 3) {
        ZBNEntryCellThree *threeCell = [ZBNEntryCellThree registerCellForTableView:tableView];
        threeCell.textOne.text = @"酒店门头图";
        threeCell.textTwo.text = @"(酒店门头图或者大唐图)";
        return threeCell;
    } else {
        ZBNEntryCellThree *threeCell = [ZBNEntryCellThree registerCellForTableView:tableView];
        threeCell.textOne.text = @"营业执照";
        threeCell.textTwo.text = @"(需文字清晰,边框完整,露出国徽)";
        return threeCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 ) {
        return 66;
    } else if (indexPath.section == 1) {
        return 66;
    } else if (indexPath.section == 2) {
        return 120;
    } else {
        return 165;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    } else {
        return 5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}


@end
