//
//  MyPostBarVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/6.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "MyPostBarVC.h"
#import "MyPostBarCell.h"

@interface MyPostBarVC ()

@end

@implementation MyPostBarVC

static NSString * const PostBarCellID = @"postBarCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyPostBarCell class]) bundle:nil] forCellReuseIdentifier:PostBarCellID];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyPostBarCell *cell = [tableView dequeueReusableCellWithIdentifier:PostBarCellID];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}

@end
