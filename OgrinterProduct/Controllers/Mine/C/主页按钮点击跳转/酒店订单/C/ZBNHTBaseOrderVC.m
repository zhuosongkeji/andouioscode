//
//  ZBNHTBaseOrderVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/11.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNHTBaseOrderVC.h"

#import "ZBNHTComModel.h"  // 酒店通用模型


@interface ZBNHTBaseOrderVC ()
/*! 模型数据 */
@property (nonatomic, strong) ZBNHTComModel *model;
/*! 保存数据的数组 */
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation ZBNHTBaseOrderVC

- (ZBNHTComType)type
{
    return 100;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tableView
    [self setupTable];
}


- (void)setupTable
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}


#pragma mark -- 懒加载

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end
