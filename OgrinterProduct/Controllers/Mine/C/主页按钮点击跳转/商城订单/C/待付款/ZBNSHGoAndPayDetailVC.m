//
//  ZBNSHGoAndPayDetailVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/20.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNSHGoAndPayDetailVC.h"
#import "ZBNSHGoAndPayDetailCell.h"
#import "ZBNWaitPayHeaderView.h"

@interface ZBNSHGoAndPayDetailVC ()

@property (nonatomic, weak) ZBNWaitPayHeaderView *headerView;

@end

@implementation ZBNSHGoAndPayDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setupHeaderView];
}

- (void)setupHeaderView
{
    ZBNWaitPayHeaderView *headerV = [ZBNWaitPayHeaderView viewFromXib];
    headerV.height = 145;
    self.headerView = headerV;
    self.tableView.tableHeaderView = headerV;
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNSHGoAndPayDetailCell *cell = [ZBNSHGoAndPayDetailCell regiserCellForTable:tableView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 500;
}


@end
