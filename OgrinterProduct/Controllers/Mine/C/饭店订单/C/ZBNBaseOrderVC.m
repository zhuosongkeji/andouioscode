//
//  ZBNBaseOrderVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/16.
//  Copyright © 2019 RXF. All rights reserved.
//  订单的基类

#import "ZBNBaseOrderVC.h"
#import "ZBNCommenOrderCell.h"

@interface ZBNBaseOrderVC ()

@end

@implementation ZBNBaseOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
}


- (void)setupTable
{
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 4;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNCommenOrderCell *cell = [ZBNCommenOrderCell regiserCellForTable:tableView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 314;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


@end
