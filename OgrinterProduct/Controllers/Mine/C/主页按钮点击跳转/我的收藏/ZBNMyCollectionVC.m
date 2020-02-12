//
//  ZBNMyCollectionVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMyCollectionVC.h"
#import "ZBNMyCollectionCommenCell.h"
#import "ZBNMyCollectionM.h"

@interface ZBNMyCollectionVC ()
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation ZBNMyCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self setupTable];
    /*! 加载数据 */
    [self loadData];
}


- (void)setupTable
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.navigationItem.title = @"商品收藏";
    self.tableView.bounces = NO;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNMyCollectionCommenCell *cell = [ZBNMyCollectionCommenCell regiserCellForTable:tableView];
    cell.collectionM = self.dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}

#pragma mark -- request
- (void)loadData
{
     [FKHRequestManager cancleRequestWork];
        NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
        userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
            param[@"uid"] = unmodel.uid;
            param[@"token"] = unmodel.token;
        ADWeakSelf;
           [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:ZBNCollectionURL params:param complement:^(ServerResponseInfo * _Nullable serverInfo) {
               weakSelf.dataArr = [ZBNMyCollectionM mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"]];
               [weakSelf.tableView reloadData];
           }];
      
}

#pragma mark -- lazy

- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end
