//
//  MyNewsVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/7.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "MyNewsVC.h"
#import "MyNewsCell.h"

@interface MyNewsVC ()

@end

@implementation MyNewsVC

static NSString * const MyNewsCellID = @"news";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyNewsCell class]) bundle:nil] forCellReuseIdentifier:MyNewsCellID];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:MyNewsCellID];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end
