//
//  ZBNCashWithDrawalVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/14.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNCashWithDrawalVC.h"
#import "ZBNCashWithDrawalCell.h"
#import "ZBNEntryCellOne.h"
#import "ZBNEntryFooterView.h"
#import "ZBNSuccessfulWthdrawalsVC.h"

@interface ZBNCashWithDrawalVC ()

@property (nonatomic, weak) ZBNEntryFooterView *footerView;

@end

@implementation ZBNCashWithDrawalVC

- (instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupFooter];
}



- (void)setupFooter
{
    ZBNEntryFooterView *footerView = [ZBNEntryFooterView viewFromXib];
    footerView.height = 300;
    self.footerView = footerView;
    self.footerView.setButtonText(@"确认提现");
    ADWeakSelf;
    self.footerView.middleBtnClickTask = ^{
        ZBNSuccessfulWthdrawalsVC *successfulVc = [[ZBNSuccessfulWthdrawalsVC alloc] init];
        [weakSelf.navigationController pushViewController:successfulVc animated:YES];
    };
    
    self.tableView.tableFooterView = footerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ZBNCashWithDrawalCell *cell = [ZBNCashWithDrawalCell regiserCellForTableView:tableView];
        return cell;
    } else {
        ZBNEntryCellOne *cell = [ZBNEntryCellOne registerCellForTableView:tableView];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 150;
    } else {
        return 55;
    }
}

@end
