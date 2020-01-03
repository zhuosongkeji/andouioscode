//
//  ZBNMyNewsVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/11.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMyNewsVC.h"
#import "ZBNMyNewsCell.h"

#import "ZBNMyNewsModel.h"

@interface ZBNMyNewsVC ()
/*! 储存数据的数组 */
@property (nonatomic, strong) NSMutableArray *dataArr;
/*! 信息模型 */
@property (nonatomic, strong) ZBNMyNewsModel *news;

@end

@implementation ZBNMyNewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置table
    [self setupTable];
    // 创建数据
    [self initModel];
}


- (void)setupTable
{
    self.navigationItem.title = @"通知信息";
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.tableView.contentInset = UIEdgeInsetsMake(getRectNavAndStatusHight, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)initModel
{
    for (int i = 0; i < 10; i++) {
        ZBNMyNewsModel *model = [[ZBNMyNewsModel alloc] init];
        if (i%2==0) {
            model.title = @"大满足";
            model.messageStatus = @"1";
            model.created_at = @"昨天深夜";
        } else {
            model.messageStatus = @"0";
            model.title = @"大劲爆";
            model.created_at = @"刚刚";
        }
        [self.dataArr addObject:model];
    }
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNMyNewsCell *cell = [ZBNMyNewsCell registerCellForTable:tableView];
    cell.news = self.dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end
