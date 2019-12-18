//
//  ZBNShoppingMallEntryVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/11.
//  Copyright © 2019 RXF. All rights reserved.
//  商城商家入驻

#import "ZBNShoppingMallEntryVC.h"
#import "ZBNEntryCellOne.h"
#import "ZBNEntryCellTwo.h"
#import "ZBNEntryCellThree.h"
#import "ZBNEntryFooterView.h"


@interface ZBNShoppingMallEntryVC ()

@property (nonatomic, weak) ZBNEntryFooterView *footerView;

@end

@implementation ZBNShoppingMallEntryVC


- (instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"商家入驻";
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




#pragma mark -- 数据源方法 && 代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.section == 0) {
            ZBNEntryCellOne *oneCell = [ZBNEntryCellOne registerCellForTableView:tableView];
            if (indexPath.row == 0) {
                oneCell.textOne.text = @"经营品种";
                oneCell.textTwo.text = @"火锅";
                return oneCell;
            } else if (indexPath.row == 1) {
                oneCell.textOne.text = @"商户名称";
                oneCell.textTwo.text = @"安抖火锅";
                return oneCell;
            } else if (indexPath.row == 2) {
                oneCell.textOne.text = @"联系人";
                oneCell.textTwo.text = @"安抖抖";
                return oneCell;
            } else {
                oneCell.textOne.text = @"联系电话";
                oneCell.textTwo.text = @"8888-8888";
                return oneCell;
            }
        } else if (indexPath.section == 1) {
            ZBNEntryCellOne *oneCell = [ZBNEntryCellOne registerCellForTableView:tableView];
            if (indexPath.row == 0) {
                oneCell.textOne.text = @"店铺地址";
                oneCell.textTwo.text = @"请选择";
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
            threeCell.textOne.text = @"商家门头头图";
            threeCell.textTwo.text = @"(需拍出完整的牌匾,门框)";
            return threeCell;
        } else if (indexPath.section == 4){
            ZBNEntryCellThree *threeCell = [ZBNEntryCellThree registerCellForTableView:tableView];
            threeCell.textOne.text = @"营业执照";
            threeCell.textTwo.text = @"(需文字清晰,边框完整,露出国徽)";
            return threeCell;
        } else {
            ZBNEntryCellThree *threeCell = [ZBNEntryCellThree registerCellForTableView:tableView];
            threeCell.textOne.text = @"食品文字许可证";
            threeCell.textTwo.text = @"(需文字清晰,边框完整,复印件需加盖印章)";
            return threeCell;
        }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    } else if (section == 1) {
        return 2;
    } else {
        return 1;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 55;
    } else if (indexPath.section == 1) {
        return 55;
    } else if (indexPath.section == 2) {
        return 120;
    } else {
        return 170;
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
