//
//  MyAddressVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/7.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "MyAddressVC.h"
#import "MyAddressCell.h"

@interface MyAddressVC ()

@end

@implementation MyAddressVC

static NSString * const MyAddressCellID = @"address";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyAddressCell class]) bundle:nil] forCellReuseIdentifier:MyAddressCellID];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:MyAddressCellID];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

@end
