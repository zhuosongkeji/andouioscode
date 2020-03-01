//
//  ZBNRTCommentVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/28.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNRTCommentVC.h"
#import "ZBNRTCommentCell.h"
#import "ZBNRTCommentM.h"

@interface ZBNRTCommentVC ()
@property (nonatomic, strong) ZBNRTCommentM *comM;
@end

@implementation ZBNRTCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.comM = [ZBNRTCommentM sharedInstance];
    [self.comM setOrder_id:self.order_id];
    [self.comM setMerchants_id:self.merchants_id];
    
    [self setupTable];
}

- (void)setupTable
{
    self.tableView.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
    self.navigationItem.title = @"发表评论";
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNRTCommentCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNRTCommentCell" owner:nil options:nil].lastObject;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 495;
}


@end
