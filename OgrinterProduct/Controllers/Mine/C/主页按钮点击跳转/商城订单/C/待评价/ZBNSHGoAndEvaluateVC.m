//
//  ZBNSHGoAndEvaluateVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/6.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSHGoAndEvaluateVC.h"

#import "ZBNSHGoAndEvaluateCell.h"
#import "ZBNSHEvaluateSuccessVC.h"
#import "ZBNSHGoAndEvaluateModel.h"

@interface ZBNSHGoAndEvaluateVC ()

@property (nonatomic, strong) ZBNSHGoAndEvaluateModel *model;
@end

@implementation ZBNSHGoAndEvaluateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 给模型赋值
    [self setupUIData];
    // 设置界面
    [self setupTable];
}

/*! 给模型赋值 */
- (void)setupUIData
{
    ZBNSHGoAndEvaluateModel *model = [ZBNSHGoAndEvaluateModel sharedInstance];
    [model setImageName:self.imageName];
    [model setGoods_id:self.goods_id];
    [model setOrder_id:self.order_id];
    [model setMerchants_id:self.merchant_id];
    self.model = model;
}

/*! 设置table相关 */
- (void)setupTable
{
    self.navigationItem.title = @"发表评论";
    self.tableView.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }else {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ADWeakSelf;
    ZBNSHGoAndEvaluateCell *cell = [ZBNSHGoAndEvaluateCell regiserCellForTable:tableView];
    // 点击评论按钮
    cell.commentBtnClickTask = ^{
        ZBNSHEvaluateSuccessVC *vc = [[ZBNSHEvaluateSuccessVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 535;
}

@end
