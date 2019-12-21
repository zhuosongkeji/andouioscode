//
//  ZBNShoppingMallEntryVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/11.
//  Copyright © 2019 RXF. All rights reserved.
//  商城商家入驻

#import "ZBNShoppingMallEntryVC.h"
#import "ZBNShoppingMallEntryCell.h"
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
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNShoppingMallEntryCell *cell = [ZBNShoppingMallEntryCell registerCellForTableView:tableView];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 915;
}



@end
