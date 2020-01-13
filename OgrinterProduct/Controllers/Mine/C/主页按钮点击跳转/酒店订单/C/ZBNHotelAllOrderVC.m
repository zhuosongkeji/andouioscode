//
//  ZBNHotelAllOrderVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/12.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNHotelAllOrderVC.h"
#import "ZBNCommenOrderCell.h"
#import "ZBNWaitDeliverDetailVC.h"

@interface ZBNHotelAllOrderVC ()

@end

@implementation ZBNHotelAllOrderVC

static NSString * const ZBNHotelAllOrderCellID = @"OrderCommenCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    [self setupTable];
}



- (void)setupTable {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNCommenOrderCell *cell = [ZBNCommenOrderCell regiserCellForTable:tableView];
    ADWeakSelf;
    cell.orderDetailClickTask = ^{
        ZBNWaitDeliverDetailVC *vc = [[ZBNWaitDeliverDetailVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
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
