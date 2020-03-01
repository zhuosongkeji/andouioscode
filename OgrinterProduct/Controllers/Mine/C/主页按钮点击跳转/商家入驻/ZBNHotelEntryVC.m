//
//  ZBNHotelEntryVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/12.
//  Copyright © 2019 RXF. All rights reserved.
//  酒店商家入驻

#import "ZBNHotelEntryVC.h"
#import "ZBNHotelEntryCell.h"
#import "ZBNEntryFooterView.h"

#import "AddressView.h"
#import "SPModalView.h"


@interface ZBNHotelEntryVC ()

@property (nonatomic, weak) ZBNEntryFooterView *footerView;

// 地址view，这个view上添加了本人封装的2大控件，一个是SPPageMenu，分页菜单;  另一个是本demo的主角:SPPickerView
@property (nonatomic, strong) AddressView *addressView;

// 这个view添加了addressView，采用动画的形式从下往上弹出
@property (nonatomic, strong) SPModalView *modalView;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, copy) NSString *textLabel;
@property (nonatomic, strong) ZBNHotelEntryCell *cell;
@end

@implementation ZBNHotelEntryVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTabel];
    
    [self setupFooter];
    
    self.modalView = [[SPModalView alloc] initWithView:self.addressView inBaseViewController:self];
    // 加载地址数据
       [self loadAddressData];
}


- (void)setupFooter
{
    ZBNEntryFooterView *footerV = [ZBNEntryFooterView viewFromXib];
    footerV.height = ZBNFooterH;
    footerV.middleBtnClickTask = ^{
        [HUDManager showTextHud:@"暂不支持酒店商家入驻"];
    };
    self.tableView.tableFooterView = footerV;
    self.footerView = footerV;
}

- (void)setupTabel
{
    self.navigationItem.title = @"酒店商家入驻";
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNHotelEntryCell *cell = [ZBNHotelEntryCell registerCellForTableView:tableView];
    ADWeakSelf;
    self.cell = cell;
   
    cell.chooseAddressLTask = ^{
        [weakSelf.modalView show];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 715;
}

- (void)loadAddressData
{
//    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/api/common/district" params:nil complement:^(ServerResponseInfo * _Nullable serverInfo) {
//        self.dataArr = [ZBNProvince mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"]];
//        self.addressView.datas = self.dataArr;
//    }];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"pcd" ofType:@"plist"];
    self.dataArr = [ZBNProvince mj_objectArrayWithFile:filePath];
    self.addressView.datas = self.dataArr;
}


- (AddressView *)addressView {
    
    if (!_addressView) {
        _addressView = [[AddressView alloc] init];
        _addressView.frame = CGRectMake(0, 0, kScreenWidth, 400);
        ADWeakSelf;
//         最后一列的行被点击的回调
        _addressView.lastComponentClickedBlock = ^(ZBNProvince *selectedProvince, ZBNCity *selectedCity, ZBNArea *selectedArea) {

            [weakSelf.modalView hide];
          
            weakSelf.textLabel = [NSString stringWithFormat:@"%@%@%@",selectedProvince.name,selectedCity.name,selectedArea.fullname];
            weakSelf.cell.setLabelText(weakSelf.textLabel);
        };
    }
    return _addressView;
}


@end
