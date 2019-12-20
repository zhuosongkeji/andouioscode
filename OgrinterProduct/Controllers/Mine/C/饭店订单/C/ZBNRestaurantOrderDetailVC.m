//
//  ZBNRestaurantOrderDetailVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/19.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNRestaurantOrderDetailVC.h"
#import "ZBNRestaurantOrderDetailCell.h"

@interface ZBNRestaurantOrderDetailVC ()

@end

@implementation ZBNRestaurantOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNRestaurantOrderDetailCell *cell = [ZBNRestaurantOrderDetailCell regiserCellForTable:tableView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 520;
}

@end
