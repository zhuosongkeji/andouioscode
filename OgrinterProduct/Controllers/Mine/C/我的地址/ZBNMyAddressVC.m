//
//  ZBNMyAddressVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/11.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMyAddressVC.h"
#import "ZBNMyAddressCell.h"
#import "ZBNMyAddressModel.h"
#import "ZBNEntryFooterView.h"
#import "ZBNNewAddressVC.h"

@interface ZBNMyAddressVC ()
/*! 保存地址模型的数组 */
@property (nonatomic, strong) NSMutableArray *addressArray;

@property (nonatomic, weak) ZBNEntryFooterView *footerView;
@end

@implementation ZBNMyAddressVC

static NSString * const ZBNMyAddressCellID = @"address";

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化模型数据
    [self initModel];
    self.navigationItem.title = @"我的地址";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setupFooterView];
    
}


- (void)setupFooterView
{
    ZBNEntryFooterView *footerView = [ZBNEntryFooterView viewFromXib];
    footerView.height = 200;
    self.tableView.tableFooterView = footerView;
    self.footerView = footerView;
    self.footerView.setButtonText(@"新增地址");
    self.footerView.middleBtnClickTask = ^{
        ZBNNewAddressVC *newAddressVc = [[ZBNNewAddressVC alloc] init];
        [self.navigationController pushViewController:newAddressVc animated:YES];
    };
}

- (void)initModel {
    for (int i = 0; i < 4; i++) {
        ZBNMyAddressModel *addModel = [[ZBNMyAddressModel alloc] init];
        if (i == 0) {
            addModel.isSelcted = YES;
        } else {
            addModel.isSelcted = NO;
        }
        
        [self.addressArray addObject:addModel];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.addressArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNMyAddressCell *cell = [ZBNMyAddressCell registerCellForTable:tableView];
    cell.addModel = self.addressArray[indexPath.row];
    cell.DefaultClickTask = ^(ZBNMyAddressModel * _Nonnull model) {
        for (ZBNMyAddressModel *addModel in self.addressArray) {
            if (model == addModel) {
                addModel.isSelcted = YES;
            } else {
                addModel.isSelcted = NO;
            }
        }
        [self.tableView reloadData];
    };
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}




#pragma mark -- lazy

- (NSMutableArray *)addressArray
{
    if (!_addressArray) {
        _addressArray = [NSMutableArray array];
    }
    return _addressArray;
}

@end
