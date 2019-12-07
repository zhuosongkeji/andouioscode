//
//  MyPostVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/6.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "MyPostVC.h"
#import "PostCell.h"

@interface MyPostVC () 



@end

@implementation MyPostVC

static NSString * const PostCellID = @"PostCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    [self setupTable];
    
}

- (void)setupTable
{
    
  
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PostCell class]) bundle:nil] forCellReuseIdentifier:PostCellID];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:PostCellID];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}


@end
