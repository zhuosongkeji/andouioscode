//
//  ZBNHTCancelVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/14.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNHTCancelVC.h"
#import "ZBNHTCancelCell.h"

@interface ZBNHTCancelVC ()

@end

@implementation ZBNHTCancelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
}

- (void)setupTable
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(getRectNavAndStatusHight, 0, 0, 0);
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNHTCancelCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNHTCancelCell" owner:nil options:nil].lastObject;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 936;
}


@end
