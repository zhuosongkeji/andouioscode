//
//  ZBNShoppingMallEntryVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/11.
//  Copyright © 2019 RXF. All rights reserved.
//  商城商家入驻

#import "ZBNShoppingMallEntryVC.h"
#import "ZBNShoppingMallEntryCell.h"
#import "ZBNEntryFooterView.h"

#import "AddressView.h"
#import "SPModalView.h"



@interface ZBNShoppingMallEntryVC ()

@property (nonatomic, weak) ZBNEntryFooterView *footerView;


// 地址view，这个view上添加了本人封装的2大控件，一个是SPPageMenu，分页菜单;  另一个是本demo的主角:SPPickerView
@property (nonatomic, strong) AddressView *addressView;

// 这个view添加了addressView，采用动画的形式从下往上弹出
@property (nonatomic, strong) SPModalView *modalView;

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, copy) NSString *textLabel;

@property (nonatomic, strong) ZBNShoppingMallEntryCell *cell;

@end

@implementation ZBNShoppingMallEntryVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 设置tableView
    [self setupTabel];
    // 设置底部视图
    [self setupFooter];
    
    self.modalView = [[SPModalView alloc] initWithView:self.addressView inBaseViewController:self];
    
    // 加载地址数据
    [self loadAddressData];
}


- (void)loadAddressData
{
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/api/common/district" params:nil complement:^(ServerResponseInfo * _Nullable serverInfo) {
        self.dataArr = [ZBNProvince mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"]];
        self.addressView.datas = self.dataArr;
    }];
}


- (void)setupTabel
{
    self.navigationItem.title = @"商城商家入驻";
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setupFooter
{
    ZBNEntryFooterView *footerV = [ZBNEntryFooterView viewFromXib];
    footerV.height = ZBNFooterH;
    ADWeakSelf;
    footerV.middleBtnClickTask = ^{
        [weakSelf loadRequset];
    };
    self.tableView.tableFooterView = footerV;
    self.footerView = footerV;
}

- (void)loadRequset
{
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = unmodel.uid;
    param[@"token"] = unmodel.token;
    param[@"type_id"] = @"2";
    param[@"name"] = self.model.shopName;
    param[@"user_name"] = self.model.userName;
    param[@"tel"] = self.model.phoneNum;
    param[@"province_id"] = [NSString stringWithFormat:@"%@",self.model.IDPro];
    param[@"city_id"] = [NSString stringWithFormat:@"%@",self.model.IDCity];
    param[@"area_id"] = [NSString stringWithFormat:@"%@",self.model.IDArea];
    param[@"address"] = self.model.detailAdd;
    param[@"desc"] = self.model.shopIntrol;
    param[@"banner_img"] = self.model.urlOne;
    param[@"logo_img"] = self.model.urlTwo;
    param[@"management_img"] = self.model.urlThree;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/merchant/information" params:param complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([[serverInfo.response objectForKey:@"code"] intValue] == 200) {
            [HUDManager showTextHud:@"申请入驻成功"];
        } else {
            [HUDManager showTextHud:@"资料填写错误"];
        }
           
       }];
}





#pragma mark -- 数据源方法 && 代理方法


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNShoppingMallEntryCell *cell =
    [ZBNShoppingMallEntryCell registerCellForTableView:tableView];
    ADWeakSelf;
    self.cell = cell;
    cell.addressLabelClickTask = ^{
        [weakSelf.modalView show];
    };
    
    self.model = cell.model;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 876;
}

- (AddressView *)addressView {
    
    if (!_addressView) {
        _addressView = [[AddressView alloc] init];
        _addressView.frame = CGRectMake(0, 0, kScreenWidth, 400);
        ADWeakSelf;
//         最后一列的行被点击的回调
        _addressView.lastComponentClickedBlock = ^(ZBNProvince *selectedProvince, ZBNCity *selectedCity, ZBNArea *selectedArea) {

            [weakSelf.modalView hide];
            
            [weakSelf.model setIDPro:selectedProvince.ID];
            [weakSelf.model setIDCity:selectedCity.ID];
            [weakSelf.model setIDArea:selectedArea.ID];
            
            weakSelf.textLabel = [NSString stringWithFormat:@"%@%@%@",selectedProvince.name,selectedCity.name,selectedArea.name];
            weakSelf.cell.setLabelText(weakSelf.textLabel);
        };
    }
    return _addressView;
}


@end
