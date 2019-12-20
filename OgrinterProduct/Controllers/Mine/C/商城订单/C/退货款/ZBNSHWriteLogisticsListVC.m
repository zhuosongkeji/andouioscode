//
//  ZBNSHWriteLogisticsListVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/19.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNSHWriteLogisticsListVC.h"
#import "ZBNSHWriteLogisticsListCell.h"
#import "ZBNEntryFooterView.h"

@interface ZBNSHWriteLogisticsListVC ()

@property (nonatomic, weak) ZBNEntryFooterView *footerView;

@end

@implementation ZBNSHWriteLogisticsListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    ZBNEntryFooterView *footerV = [ZBNEntryFooterView viewFromXib];
    footerV.setButtonText(@"提交");
    footerV.middleBtnClickTask = ^{
        [ZBNAlertTool zbn_alertTitle:@"确定要提交吗?" type:UIAlertControllerStyleAlert message:nil didTask:^{
            
        }];
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
    ZBNSHWriteLogisticsListCell *cell = [ZBNSHWriteLogisticsListCell regiserCellForTable:tableView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

@end
