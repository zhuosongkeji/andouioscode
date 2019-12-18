//
//  ZBNShoppingHallAllOrderVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/12.
//  Copyright © 2019 RXF. All rights reserved.
//  全部订单

#import "ZBNShoppingHallAllOrderVC.h"
#import "ZBNCommenOrderCell.h"
@interface ZBNShoppingHallAllOrderVC ()

@end

@implementation ZBNShoppingHallAllOrderVC

static NSString * const ZBNShoppingHallAllOrderCellID = @"OrderCommenCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
