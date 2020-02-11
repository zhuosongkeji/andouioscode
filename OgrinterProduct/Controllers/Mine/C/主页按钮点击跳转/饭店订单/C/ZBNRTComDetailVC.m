//
//  ZBNRTComDetailVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/16.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNRTComDetailVC.h"

#import "ZBNRTComDetailCell.h" // 中间的cell
#import "ZBNRTComDetailCellOne.h" // 上面的cell
#import "ZBNRTComDetailCellTwo.h" // 下面的cell
#import "ZBNRTComDetailHeader.h" // sectionHeader

#import "ZBNRTComDetailModel.h"
#import "ZBNRTFoodsModel.h"


@interface ZBNRTComDetailVC ()
@property (nonatomic, strong) ZBNRTComDetailHeader *header;
@property (nonatomic, strong) ZBNRTComDetailModel *comDetailM;
@end

@implementation ZBNRTComDetailVC


//- (instancetype)init
//{
//    return  [super initWithStyle:UITableViewStyleGrouped];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 加载数据
    [self loadData];
    // 设置table
    [self setupTable];
    // 设置sectionHeader
    [self setupSecHeader];
    
}

#pragma mark -- UI

- (void)setupTable
{
    
    self.navigationItem.title = @"订单详情";
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationController.navigationBar.translucent = NO;
    self.tableView.bounces = NO;
}

- (void)setupSecHeader
{
    ZBNRTComDetailHeader *header = [ZBNRTComDetailHeader viewFromXib];
    header.height = 40;
    self.header = header;
}



#pragma mark -- request

- (void)loadData
{
    [FKHRequestManager cancleRequestWork];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    params[@"uid"] = unmodel.uid;
    params[@"token"] = unmodel.token;
    params[@"id"] = self.order_id;
    ADWeakSelf;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl: ZBNGourmetDetailURL params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([[serverInfo.response objectForKey:@"code"] intValue] == 200) {
            weakSelf.comDetailM = [ZBNRTComDetailModel mj_objectWithKeyValues:serverInfo.response[@"data"]];
            [weakSelf.tableView reloadData];
        } else {
            [HUDManager showTextHud:@"加载失败"];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return self.comDetailM.foods.count;
    } else  {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ZBNRTComDetailCellOne *oneCell = [[NSBundle mainBundle] loadNibNamed:@"ZBNRTComDetailCellOne" owner:nil options:nil].lastObject;
        oneCell.selectionStyle = UITableViewCellSelectionStyleNone;
        oneCell.detailM = self.comDetailM;
        return oneCell;
    } else if (indexPath.section == 1) {
        ZBNRTComDetailCell *middleCell = [ZBNRTComDetailCell regiserCellForTable:tableView];
        middleCell.detailM = self.comDetailM.foods[indexPath.row];
        return middleCell;
    } else {
        ZBNRTComDetailCellTwo *twoCell = [[NSBundle mainBundle] loadNibNamed:@"ZBNRTComDetailCellTwo" owner:nil options:nil].lastObject;
        twoCell.detailM = self.comDetailM;
        return twoCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 80;
    } else if (indexPath.section == 1) {
        return 110;
    } else {
        return 625;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 40;
    } else {
        return 0;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        self.header.comDetailM = self.comDetailM;
        return self.header;
    } else {
        return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    } else if (section == 1) {
        return 10;
    } else {
        return 0;
    }
}


@end
