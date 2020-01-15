//
//  ZBNHTWaitInDetailVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/14.
//  Copyright © 2020 RXF. All rights reserved.
//  待入住的订单详情

#import "ZBNHTWaitInDetailVC.h"
#import "ZBNHTWaitInDetailCell.h"
#import "ZBNHTComDetailModel.h"
@interface ZBNHTWaitInDetailVC ()
/*! 模型数据 */
@property (nonatomic, strong) ZBNHTComDetailModel *detailM;
@end

@implementation ZBNHTWaitInDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
}

- (void)setupTable
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(getRectNavAndStatusHight, 0, 0, 0);
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNHTWaitInDetailCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNHTWaitInDetailCell" owner:nil options:nil].lastObject;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 982;
}

@end
