//
//  ZBNWalletRechargeVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/16.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNWalletRechargeVC.h"
#import "ZBNRechargeCell.h"
#import "ZBNEntryFooterView.h"

@interface ZBNWalletRechargeVC ()

@property (nonatomic, weak) ZBNEntryFooterView *footerView;

@end

@implementation ZBNWalletRechargeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"余额充值";
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.tableView.contentInset = UIEdgeInsetsMake(getRectNavAndStatusHight, 0, 0, 0);
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNRechargeCell *cell = [ZBNRechargeCell registerCellForTableView:tableView];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 492;
}



@end
