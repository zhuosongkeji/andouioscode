//
//  ZBNWaitDeliverDetailVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/20.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNWaitDeliverDetailVC.h"
#import "ZBNWaitDeliverDetailCell.h"
#import "ZBNSHApplyForRefundVC.h"

@interface ZBNWaitDeliverDetailVC ()


@end

@implementation ZBNWaitDeliverDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
}





#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNWaitDeliverDetailCell *cell = [ZBNWaitDeliverDetailCell regiserCellForTable:tableView];
    ADWeakSelf;
    cell.beSureReciveGoodsBtnClickTask = ^{
        [ZBNAlertTool zbn_alertTitle:@"您确定货收到了吗?" type:UIAlertControllerStyleAlert message:nil didTask:^{
            
        }];
    };
    cell.returnGoodsBtnClickTask = ^{
        ZBNSHApplyForRefundVC *Vc = [[ZBNSHApplyForRefundVC alloc] init];
        [weakSelf.navigationController pushViewController:Vc animated:YES];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 600;
}
@end
