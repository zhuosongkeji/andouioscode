//
//  ZBNSHGoAndEvaluateVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/6.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSHGoAndEvaluateVC.h"

#import "ZBNSHGoAndEvaluateCell.h"
#import "ZBNEntryFooterView.h"
#import "ZBNSHEvaluateSuccessVC.h"


@interface ZBNSHGoAndEvaluateVC ()

@property (nonatomic, weak) ZBNEntryFooterView *footerV;

@property (nonatomic, copy) NSString *comText;
@property (nonatomic, copy) NSString *starNum;

@end

@implementation ZBNSHGoAndEvaluateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupTable];
    [self setupFooter];
}


- (void)setupFooter
{
    ADWeakSelf;
    ZBNEntryFooterView *footerV = [ZBNEntryFooterView viewFromXib];
    footerV.height = ZBNFooterH;
    footerV.setButtonText(@"发表评论");
    // -------------> 发表评论在这里设置点击
    footerV.middleBtnClickTask = ^{
        
        
        
        
        ZBNSHEvaluateSuccessVC *vc = [[ZBNSHEvaluateSuccessVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    self.tableView.tableFooterView = footerV;
    self.footerV = footerV;
}

- (void)commentRequest
{
    
}


- (void)setupTable
{
    self.navigationItem.title = @"发表评论";
    self.tableView.contentInset = UIEdgeInsetsMake(getRectNavAndStatusHight, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNSHGoAndEvaluateCell *cell = [ZBNSHGoAndEvaluateCell regiserCellForTable:tableView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 450;
}

@end
