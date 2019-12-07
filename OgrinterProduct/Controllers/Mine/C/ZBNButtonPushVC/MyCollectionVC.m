//
//  MyCollectionVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/7.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "MyCollectionVC.h"

#import "MyCollectionCell.h"

@interface MyCollectionVC ()

@end

@implementation MyCollectionVC

static NSString * const MyCollectionCellID = @"myCollectionCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyCollectionCell class]) bundle:nil] forCellReuseIdentifier:MyCollectionCellID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:MyCollectionCellID];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}


@end
