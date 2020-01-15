//
//  ZBNTakeOutEntryVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/7.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNTakeOutEntryVC.h"
#import "ZBNTakeOutEntryCell.h"
#import "ZBNEntryFooterView.h"

#import "AddressView.h"
#import "SPModalView.h"


@interface ZBNTakeOutEntryVC ()
@property (nonatomic, weak) ZBNEntryFooterView *footerView;

// 地址view，这个view上添加了本人封装的2大控件，一个是SPPageMenu，分页菜单;  另一个是本demo的主角:SPPickerView
@property (nonatomic, strong) AddressView *addressView;

// 这个view添加了addressView，采用动画的形式从下往上弹出
@property (nonatomic, strong) SPModalView *modalView;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, copy) NSString *textLabel;
@property (nonatomic, strong) ZBNTakeOutEntryCell *cell;

@end

@implementation ZBNTakeOutEntryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTabel];
    [self setupFooter];
    
    self.modalView = [[SPModalView alloc] initWithView:self.addressView inBaseViewController:self];
    
    [self loadAddressData];
    
}


- (void)setupTabel
{
    self.navigationItem.title = @"饭店商家入驻";
    self.tableView.contentInset = UIEdgeInsetsMake(getRectNavAndStatusHight, 0, 0, 0);
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setupFooter
{
    ZBNEntryFooterView *footerV = [ZBNEntryFooterView viewFromXib];
    footerV.height = ZBNFooterH;
    footerV.middleBtnClickTask = ^{
        [HUDManager showTextHud:@"暂不支持饭店商家入驻"];
    };
    self.tableView.tableFooterView = footerV;
    self.footerView = footerV;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNTakeOutEntryCell *cell = [ZBNTakeOutEntryCell registerCellForTableView:tableView];
    ADWeakSelf;
    self.cell = cell;
    cell.chooseAddressLTask = ^{
        [weakSelf.modalView show];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 765;
}

- (void)loadAddressData
{
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/api/common/district" params:nil complement:^(ServerResponseInfo * _Nullable serverInfo) {
        self.dataArr = [ZBNProvince mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"]];
        self.addressView.datas = self.dataArr;
    }];
}

- (AddressView *)addressView {
    
    if (!_addressView) {
        _addressView = [[AddressView alloc] init];
        _addressView.frame = CGRectMake(0, 0, kScreenWidth, 400);
        ADWeakSelf;
//         最后一列的行被点击的回调
        _addressView.lastComponentClickedBlock = ^(ZBNProvince *selectedProvince, ZBNCity *selectedCity, ZBNArea *selectedArea) {

            [weakSelf.modalView hide];
          
            weakSelf.textLabel = [NSString stringWithFormat:@"%@%@%@",selectedProvince.name,selectedCity.name,selectedArea.name];
            weakSelf.cell.setLabelText(weakSelf.textLabel);
        };
    }
    return _addressView;
}

@end
