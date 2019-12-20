//
//  ZBNHotelEntryVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/12.
//  Copyright © 2019 RXF. All rights reserved.
//  酒店商家入驻

#import "ZBNHotelEntryVC.h"
#import "ZBNHotelEntryCell.h"
#import "ZBNEntryFooterView.h"

@interface ZBNHotelEntryVC ()

@property (nonatomic, weak) ZBNEntryFooterView *footerView;

@end

@implementation ZBNHotelEntryVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"酒店入驻";

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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNHotelEntryCell *cell = [ZBNHotelEntryCell registerCellForTableView:tableView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 765;
}




@end
