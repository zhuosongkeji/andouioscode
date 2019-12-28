//
//  ZBNMyCollectionVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMyCollectionVC.h"
#import "ZBNMyCollectionCommenCell.h"

@interface ZBNMyCollectionVC ()

@end

@implementation ZBNMyCollectionVC

static NSString * const ZBNMyCollectionCellID = @"collectionCommen";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MsgViewCell" bundle:nil] forCellReuseIdentifier:ZBNMyCollectionCellID];
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 13;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNMyCollectionCommenCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNMyCollectionCellID];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 98;
}

@end
