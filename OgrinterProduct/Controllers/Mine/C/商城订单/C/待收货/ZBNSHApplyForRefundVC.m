//
//  ZBNSHApplyForRefundVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/20.
//  Copyright © 2019 RXF. All rights reserved.
//  申请退款控制器

#import "ZBNSHApplyForRefundVC.h"
#import "ZBNSHApplyForRefundCell.h"
#import "ZBNEntryFooterView.h"
#import "ZBNReturnGoodsReasonView.h"

@interface ZBNSHApplyForRefundVC ()

@property (nonatomic, weak) ZBNEntryFooterView *footerView;

@end

@implementation ZBNSHApplyForRefundVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    [self setupFooterView];
}


- (void)setupFooterView
{
    ZBNEntryFooterView *footerV = [ZBNEntryFooterView viewFromXib];
    footerV.setButtonText(@"提交申请");
    footerV.middleBtnClickTask = ^{
        NSLog(@"你点击了提交申请按钮");
    };
    
    self.footerView = footerV;
    self.tableView.tableFooterView = footerV;
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNSHApplyForRefundCell *cell = [ZBNSHApplyForRefundCell regiserCellForTable:tableView];
    ADWeakSelf;
    cell.twoCellClickTask = ^{
        NSLog(@"click");
        ZBNReturnGoodsReasonView *reView = [ZBNReturnGoodsReasonView viewFromXib];
        reView.width = self.view.width;
        QWAlertView *alertV = [QWAlertView sharedMask];
        [alertV show:reView withType:0];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 480;
}

@end
