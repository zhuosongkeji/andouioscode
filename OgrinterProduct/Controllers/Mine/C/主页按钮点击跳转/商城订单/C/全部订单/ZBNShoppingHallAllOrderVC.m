//
//  ZBNShoppingHallAllOrderVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/12.
//  Copyright © 2019 RXF. All rights reserved.
//  全部订单

#import "ZBNShoppingHallAllOrderVC.h"
#import "ZBNCommenOrderCell.h"
#import "ZBNWaitDeliverDetailVC.h"
@interface ZBNShoppingHallAllOrderVC ()

@end

@implementation ZBNShoppingHallAllOrderVC

static NSString * const ZBNShoppingHallAllOrderCellID = @"OrderCommenCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"ZBNCommenOrderCell" bundle:nil] forCellReuseIdentifier:ZBNShoppingHallAllOrderCellID];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNCommenOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNShoppingHallAllOrderCellID];
    ADWeakSelf
    cell.orderDetailClickTask = ^{
        ZBNWaitDeliverDetailVC *Vc = [[ZBNWaitDeliverDetailVC alloc] init];
        [weakSelf.navigationController pushViewController:Vc animated:YES];
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
