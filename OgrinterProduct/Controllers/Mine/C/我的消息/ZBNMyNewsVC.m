//
//  ZBNMyNewsVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/11.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMyNewsVC.h"
#import "ZBNMyNewsCell.h"

@interface ZBNMyNewsVC ()

@end

@implementation ZBNMyNewsVC

static NSString * const ZBNMyNewsCellID = @"news";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZBNMyNewsCell" bundle:nil] forCellReuseIdentifier:ZBNMyNewsCellID];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNMyNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNMyNewsCellID];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}

@end
