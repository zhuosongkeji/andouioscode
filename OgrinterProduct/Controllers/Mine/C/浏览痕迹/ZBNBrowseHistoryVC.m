//
//  ZBNBrowseHistoryVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNBrowseHistoryVC.h"
#import "ZBNMyCollectionCommenCell.h"

@interface ZBNBrowseHistoryVC ()

@end

@implementation ZBNBrowseHistoryVC

static NSString * const ZBNBrowseHistoryCellID = @"collectionCommen";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"浏览痕迹";
    [self.tableView registerNib:[UINib nibWithNibName:@"MsgViewCell" bundle:nil] forCellReuseIdentifier:ZBNBrowseHistoryCellID];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 14;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNMyCollectionCommenCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNBrowseHistoryCellID];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 98;
}


@end
