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
#import "ZBNPostBarNewsVC.h"

@interface ZBNMyAllNewsVC ()

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) ZBNMyAllNewsModel *allM;
@end

@implementation ZBNMyAllNewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    if (@available(iOS 11.0, *)) {
           self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
       }else {
           self.automaticallyAdjustsScrollViewInsets = YES;
       }
    self.tableView.bounces = NO;
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadRequest];
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
        
    ZBNMyAllNewsModel *model = self.dataArr[indexPath.row];
    if (model.ID.intValue == 1) {
        ZBNMyNewsVC *vc = [[ZBNMyNewsVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (model.ID.intValue == 2) {
        ZBNPostBarNewsVC *vc = [[ZBNPostBarNewsVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

- (void)loadRequest
{
    // 拿到uid 和 token
    ADWeakSelf;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    params[@"uid"] = unmodel.uid;
    params[@"level"] = @"1";
    params[@"type_id"] = @"1";
     [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_GET pathUrl:@"http://andou.zhuosongkj.com/index.php/api/info/list" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
         weakSelf.dataArr = [ZBNMyAllNewsModel mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"][@"count"]];
         [weakSelf.tableView reloadData];
       }];
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
