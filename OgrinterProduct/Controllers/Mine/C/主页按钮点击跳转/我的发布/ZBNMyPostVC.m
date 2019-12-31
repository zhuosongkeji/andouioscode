//
//  ZBNMyPostVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMyPostVC.h"
#import "ZBNMyPostCommenCell.h"

@implementation ZBNMyPostVC

static NSString * const ZBNMyPostCellID = @"postCommen";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTable];
}

- (void)setupTable
{
    [self.tableView registerNib:[UINib nibWithNibName:@"ZBNMyPostCommenCell" bundle:nil] forCellReuseIdentifier:ZBNMyPostCellID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 14;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNMyPostCommenCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNMyPostCellID];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}

@end
