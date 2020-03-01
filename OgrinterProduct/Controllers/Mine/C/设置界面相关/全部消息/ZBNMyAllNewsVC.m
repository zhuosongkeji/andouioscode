//
//  ZBNMyAllNewsVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/9.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNMyAllNewsVC.h"

#import "ZBNMyAllNewsModel.h"
#import "ZBNMyAllNewsCell.h"
#import "ZBNMyNewsVC.h"

@interface ZBNMyAllNewsVC ()

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) ZBNMyAllNewsModel *allM;
@end

@implementation ZBNMyAllNewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.bounces = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.dataArr removeAllObjects];
    [self initModel];;
}


- (void)initModel
{
    for (int i = 0; i < 3; i++) {
        ZBNMyAllNewsModel *model = [[ZBNMyAllNewsModel alloc] init];
        if (i == 0) {
            model.count = @"99";
            model.nameL = @"系统消息";
            model.iconV = @"系统消息";
            model.state = @"0";
        } else if (i == 1) {
            model.count = @"4";
            model.nameL = @"商城消息";
            model.state = @"1";
            model.iconV = @"商家消息";
        } else {
            model.count = @"18";
            model.nameL = @"贴吧消息";
            model.iconV = @"贴吧消息10";
            model.state = @"1";
        }
        [self.dataArr addObject:model];
    }
    [self.tableView reloadData];
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNMyAllNewsCell *cell = [ZBNMyAllNewsCell regiserCellForTable:tableView];
    cell.allM = self.dataArr[indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ZBNMyNewsVC *vc = [[ZBNMyNewsVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        ZBNMyAllNewsModel *model = self.dataArr[indexPath.row];
        [model setState:@"1"];
        [self.tableView reloadData];
    }
    
}


#pragma mark -- lazy

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr  = [NSMutableArray array];
    }
    return _dataArr;
}
@end
