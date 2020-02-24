//
//  ZBNNewPostVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/19.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNNewPostVC.h"
#import "ZBNNewPostCell.h"
#import "ZBNEntryFooterView.h"
#import "ZBNPostPayVC.h"

@interface ZBNNewPostVC ()

@end

@implementation ZBNNewPostVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
}


- (void)setupTable
{
    self.tableView.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
    self.navigationItem.title = @"发布";
    
    ZBNEntryFooterView *footerV = [ZBNEntryFooterView viewFromXib];
    footerV.height = ZBNFooterH;
    footerV.setButtonText(@"发布信息");
    ADWeakSelf;
    footerV.middleBtnClickTask = ^{
        ZBNPostPayVC *vc = [[ZBNPostPayVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    self.tableView.tableFooterView = footerV;
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 475;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNNewPostCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNNewPostCell" owner:nil options:nil].lastObject;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



@end
