//
//  ZBNPostBarNewsVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/3/7.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNPostBarNewsVC.h"
#import "ZBNPostBarNewsCell.h"
#import "ZBNMyAllNewsModel.h"
#import "ZBNPostZanVC.h"
#import "ZBNPostMyComVC.h"
#import "ZBNPostMyReplyedVC.h"

@interface ZBNPostBarNewsVC ()

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation ZBNPostBarNewsVC

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"贴吧消息";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }else {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
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
    ZBNPostBarNewsCell *cell = [ZBNPostBarNewsCell regiserCellForTable:tableView];
    cell.model = self.dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ZBNPostZanVC *vc = [[ZBNPostZanVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1) {
        ZBNPostMyComVC *vc = [[ZBNPostMyComVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 2){
        ZBNPostMyReplyedVC *vc = [[ZBNPostMyReplyedVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        
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
    params[@"level"] = @"2";
    params[@"type_id"] = @"2";
     [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_GET pathUrl:@"http://andou.zhuosongkj.com/index.php/api/info/list" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
         weakSelf.dataArr = [ZBNMyAllNewsModel mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"][@"count"]];
         [weakSelf.tableView reloadData];
       }];
}


@end
