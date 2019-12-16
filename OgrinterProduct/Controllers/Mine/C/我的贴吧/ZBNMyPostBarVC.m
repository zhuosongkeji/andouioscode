//
//  ZBNMyPostBarVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMyPostBarVC.h"
#import "ZBNMyPostCommenCell.h"

@interface ZBNMyPostBarVC ()

@end

@implementation ZBNMyPostBarVC

static NSString * const ZBNMyPostBarCellID = @"postCommen";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
    
}

- (void)setupTable
{
    [self.tableView registerNib:[UINib nibWithNibName:@"ZBNMyPostCommenCell" bundle:nil] forCellReuseIdentifier:ZBNMyPostBarCellID];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNMyPostCommenCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNMyPostBarCellID];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}

@end
