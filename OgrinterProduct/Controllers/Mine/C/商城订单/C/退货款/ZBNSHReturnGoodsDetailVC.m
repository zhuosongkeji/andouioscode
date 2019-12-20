//
//  ZBNSHReturnGoodsDetailVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/19.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNSHReturnGoodsDetailVC.h"
#import "ZBNEntryFooterView.h"
#import "ZBNSHReturnGoodsDetailCell.h"
#import "ZBNSHWriteLogisticsListVC.h"

@interface ZBNSHReturnGoodsDetailVC ()

@property (nonatomic, weak) ZBNEntryFooterView *footerView;

@end

@implementation ZBNSHReturnGoodsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    [self setupFooterView];
}

- (void)setupFooterView
{
    ZBNEntryFooterView *footerV = [ZBNEntryFooterView viewFromXib];
    footerV.setButtonText(@"填写物流单号");
    ADWeakSelf;
    footerV.middleBtnClickTask = ^{
        ZBNSHWriteLogisticsListVC *writeVc = [[ZBNSHWriteLogisticsListVC alloc] init];
        [weakSelf.navigationController pushViewController:writeVc animated:YES];
    };
    
    self.footerView = footerV;
    self.tableView.tableFooterView = footerV;
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNSHReturnGoodsDetailCell *detailCell = [ZBNSHReturnGoodsDetailCell regiserCellForTable:tableView];
    return detailCell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 460;
}


@end
