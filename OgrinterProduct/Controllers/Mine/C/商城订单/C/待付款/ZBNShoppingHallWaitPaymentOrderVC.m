//
//  ZBNShoppingHallWaitPaymentOrderVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/12.
//  Copyright © 2019 RXF. All rights reserved.
//  等待支付订单

#import "ZBNShoppingHallWaitPaymentOrderVC.h"

#import "ZBNShoppingHallWaitPaymentOrderCell.h"
#import "ZBNSHGoAndPayDetailVC.h"

@interface ZBNShoppingHallWaitPaymentOrderVC ()

@end

@implementation ZBNShoppingHallWaitPaymentOrderVC



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ZBNCommonBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNShoppingHallWaitPaymentOrderCell *cell = [ZBNShoppingHallWaitPaymentOrderCell regiserCellForTable:tableView];
    ADWeakSelf;
    cell.orderDetailBtnClickTask = ^{
        ZBNSHGoAndPayDetailVC *vc = [[ZBNSHGoAndPayDetailVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 310;
}

@end
