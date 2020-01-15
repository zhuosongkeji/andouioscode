//
//  ZBNAddressChangeVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/13.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNAddressChangeVC.h"
#import "ZBNMyAddressModel.h"

#import "AddressView.h"
#import "SPModalView.h"

@interface ZBNAddressChangeVC ()

/*! 联系人 */
@property (weak, nonatomic) IBOutlet UITextField *name;
/*! 电话号码 */
@property (weak, nonatomic) IBOutlet UITextField *phone;

/*! 选择地址的label */
@property (weak, nonatomic) IBOutlet UILabel *chooseAdd;
/*! 详细地址 */
@property (weak, nonatomic) IBOutlet UITextField *DetailAddress;
/*! 是否设置为默认地址 */
@property (weak, nonatomic) IBOutlet UIButton *defaultBtn;

@property (nonatomic, strong) NSArray *dataArr;

// 地址view，这个view上添加了本人封装的2大控件，一个是SPPageMenu，分页菜单;  另一个是本demo的主角:SPPickerView
@property (nonatomic, strong) AddressView *addressView;

// 这个view添加了addressView，采用动画的形式从下往上弹出
@property (nonatomic, strong) SPModalView *modalView;

@end

@implementation ZBNAddressChangeVC



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置UI
    [self setupUI];
    // 设置手势
    [self setupLabelGes];
    // 请求数据
    [self loadData];
}


- (void)setupUI
{
    self.chooseAdd.userInteractionEnabled = YES;
    self.modalView = [[SPModalView alloc] initWithView:self.addressView inBaseViewController:self];
    
    self.defaultBtn.selected = self.addM.is_defualt;
    self.name.text = self.addM.name;
    self.phone.text = self.addM.mobile;
    self.chooseAdd.text = [NSString stringWithFormat:@"%@%@%@",self.addM.province,self.addM.city,self.addM.area];
    self.DetailAddress.text = self.addM.address;
}

- (void)setupLabelGes
{
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)];
    [self.chooseAdd addGestureRecognizer:tapGes];
}

- (void)labelClick
{
    [self.modalView show];
}


/*! 确认修改点击 */
- (IBAction)changeBtn:(id)sender {
    // 发起修改地址请求
    [self changeAddressRequest];
    
}


- (IBAction)defaultBtnClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.addM setIs_defualt:YES];
    } else {
        [self.addM setIs_defualt:NO];
    }
    
}


- (AddressView *)addressView {
    
    if (!_addressView) {
        _addressView = [[AddressView alloc] init];
        _addressView.frame = CGRectMake(0, 0, kScreenWidth, 400);
        ADWeakSelf;
//         最后一列的行被点击的回调
        _addressView.lastComponentClickedBlock = ^(ZBNProvince *selectedProvince, ZBNCity *selectedCity, ZBNArea *selectedArea) {

            [weakSelf.modalView hide];
            
            weakSelf.chooseAdd.text = [NSString stringWithFormat:@"%@%@%@",selectedProvince.name,selectedCity.name,selectedArea.name];
            
            [weakSelf.addM setProvince_id:selectedArea.ID];
            [weakSelf.addM setCity_id:selectedCity.ID];
            [weakSelf.addM setArea_id:selectedArea.ID];
            
        };
    }
    return _addressView;
}

/*! 加载数据 */
- (void)loadData
{
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/api/common/district" params:nil complement:^(ServerResponseInfo * _Nullable serverInfo) {
        self.dataArr = [ZBNProvince mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"]];
        self.addressView.datas = self.dataArr;
    }];
}

- (void)changeAddressRequest
{
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] = self.addM.ID;
    param[@"uid"] = unmodel.uid;
    param[@"token"] = unmodel.token;
    param[@"name"] = self.name.text;
    param[@"mobile"] = self.phone.text;
    param[@"province_id"] = self.addM.province_id;
    param[@"city_id"] = self.addM.city_id;
    param[@"area_id"] = self.addM.area_id;
    param[@"address"] = self.DetailAddress.text;
    if (self.addM.is_defualt) {
        param[@"is_defualt"] = @"1";
    } else {
        param[@"is_defualt"] = @"0";
    }
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/Usersaddress/address_edit" params:param complement:^(ServerResponseInfo * _Nullable serverInfo) {
           
           if ([[serverInfo.response objectForKey:@"code"] integerValue] == 200) {
               
               [HUDManager showTextHud:@"添加成功"];
               [[NSNotificationCenter defaultCenter] postNotificationName:@"changeOK" object:nil];
               [self.navigationController popViewControllerAnimated:YES];
               
           }
           if ([[serverInfo.response objectForKey:@"code"] integerValue] == 201) {
                      
                      [HUDManager showTextHud:@"请填写完整"];
                      
                  }
       }];
}


@end
