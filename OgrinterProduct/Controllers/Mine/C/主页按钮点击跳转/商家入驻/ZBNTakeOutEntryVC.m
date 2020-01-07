//
//  ZBNTakeOutEntryVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/7.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNTakeOutEntryVC.h"
#import "ZBNTakeOutEntryCell.h"
#import "ZBNEntryFooterView.h"
@interface ZBNTakeOutEntryVC ()
@property (nonatomic, weak) ZBNEntryFooterView *footerView;
@end

@implementation ZBNTakeOutEntryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupFooter];
    self.tableView.contentInset = UIEdgeInsetsMake(getRectNavAndStatusHight, 0, 0, 0);
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
    ZBNTakeOutEntryCell *cell = [ZBNTakeOutEntryCell registerCellForTableView:tableView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 765;
}

@end
