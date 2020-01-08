//
//  ZBNSHBaseOrderVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/4.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSHBaseOrderVC.h"
#import "ZBNSHCommonCell.h"
#import "ZBNSHCommonModel.h"


@interface ZBNSHBaseOrderVC ()

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) ZBNSHCommonModel *comM;

@end

@implementation ZBNSHBaseOrderVC

- (ZBNCommonType)type
{
    return 0;
}



- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return  _dataArr;
}


/*! 加载数据 */
// 加载数据
- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
//    params[@"uid"] = unmodel.uid;
    params[@"uid"] = @"1";
//    params[@"token"] = unmodel.token;
    params[@"token"] = @"94e31eee8b8237c4d98e965dbcbc44b5";
    params[@"type"] = @(self.type);
    params[@"page"] = @"1";
    ADWeakSelf;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/api/order/index" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        weakSelf.dataArr = [ZBNSHCommonModel mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"]];
        [weakSelf.tableView reloadData];
    }];
    
//    [self.manager POST:@"http://andou.zhuosongkj.com/api/order/index" parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        NSLog(@"%@",responseObject);
//        NSLog(@"hahahah");
//        weakSelf.dataArr = [ZBNSHCommonModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
    
}

- (void)initModel {
    for (int i = 0; i < 10; i++) {
        ZBNSHCommonModel *model = [[ZBNSHCommonModel alloc] init];
        if (i == 0) {
            model.status = @"20";
        } else if (i == 3) {
            model.status = @"10";
        } else if (i == 2) {
            model.status = @"40";
        } else {
            model.status = @"50";
        }
        [self.dataArr addObject:model];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
   // 设置UI
    [self setupUI];
    // 加载数据
    [self loadData];
//    [self initModel];
}

- (void)setupUI
{
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNSHCommonCell *cell = [ZBNSHCommonCell regiserCellForTable:tableView];
    cell.commonM = self.dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 310;
}

@end
