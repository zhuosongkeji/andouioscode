//
//  ZBNEvaluateGoodsVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/20.
//  Copyright © 2019 RXF. All rights reserved.
//  评论商品控制器

#import "ZBNEvaluateGoodsVC.h"
#import "ZBNEvaluateGoodsCell.h"
#import "ZBNEntryFooterView.h"

@interface ZBNEvaluateGoodsVC ()

@property (nonatomic, weak) ZBNEntryFooterView *footerView;

@end

@implementation ZBNEvaluateGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ZBNCommonBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setupFooterView];
}

#pragma mark - Table view data source

- (void)setupFooterView
{
    ZBNEntryFooterView *footerV = [ZBNEntryFooterView viewFromXib];
    [self.view addSubview:footerV];
    self.footerView = footerV;
    self.footerView.setButtonText(@"发表评论");
    self.tableView.tableFooterView = footerV;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNEvaluateGoodsCell *cell = [ZBNEvaluateGoodsCell regiserCellForTable:tableView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 370;
}


@end
