//
//  ZBNCashWithDrawalVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/14.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNCashWithDrawalVC.h"
#import "ZBNCashWithDrawalCell.h"
#import "ZBNEntryFooterView.h"
#import "ZBNSuccessfulWthdrawalsVC.h"

@interface ZBNCashWithDrawalVC ()

@property (nonatomic, weak) ZBNEntryFooterView *footerView;

@end

@implementation ZBNCashWithDrawalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"余额提现";
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.tableView.contentInset = UIEdgeInsetsMake(getRectNavAndStatusHight, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setupFooter];
}





- (void)setupFooter
{
    ZBNEntryFooterView *footerView = [ZBNEntryFooterView viewFromXib];
    footerView.height = 150;
    self.footerView = footerView;
    self.footerView.setButtonText(@"确认提现");
    ADWeakSelf;
    self.footerView.middleBtnClickTask = ^{
        ZBNSuccessfulWthdrawalsVC *successfulVc = [[ZBNSuccessfulWthdrawalsVC alloc] init];
        [weakSelf.navigationController pushViewController:successfulVc animated:YES];
    };
    
    self.tableView.tableFooterView = footerView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        ZBNCashWithDrawalCell *cell = [ZBNCashWithDrawalCell regiserCellForTableView:tableView];
        return cell;
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 266;
}



@end
