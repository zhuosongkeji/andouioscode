//
//  ZBNNewAddressVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/16.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNNewAddressVC.h"
#import "ZBNProvince.h"
#import "ZBNCity.h"
#import "ZBNArea.h"

#import "AddressView.h"
#import "SPModalView.h"

@interface ZBNNewAddressVC ()


/*! ID **/
@property (nonatomic, assign) NSString *IDPro;
@property (nonatomic, assign) NSString *IDCity;
@property (nonatomic, assign) NSString *IDArea;

/*! 地址label */
@property (weak, nonatomic) IBOutlet UILabel *addLabel;
/*! 地址详情 */
@property (weak, nonatomic) IBOutlet UITextField *detailAddTex;
/*! 默认地址按钮 */
@property (weak, nonatomic) IBOutlet UIButton *defultAddBtn;
/*! 收货人 */
@property (weak, nonatomic) IBOutlet UITextField *reciveGoodsP;
/*! 收货人号码 */
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;

@property (nonatomic, assign) NSNumber *is_defualt;

// 地址view，这个view上添加了本人封装的2大控件，一个是SPPageMenu，分页菜单;  另一个是本demo的主角:SPPickerView
@property (nonatomic, strong) AddressView *addressView;

// 这个view添加了addressView，采用动画的形式从下往上弹出
@property (nonatomic, strong) SPModalView *modalView;

@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation ZBNNewAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"新增地址";

   
    self.addLabel.userInteractionEnabled = YES;
    // 设置手势
    [self setupLabelGes];
    
    self.is_defualt = @0;
    
    self.modalView = [[SPModalView alloc] initWithView:self.addressView inBaseViewController:self];

    // 加载数据
       [self loadData];

}


/*! 默认地址按钮的点击 */
- (IBAction)defultBtnClick:(UIButton *)sender {
        
//    sender.selected = !sender.selected;
    self.defultAddBtn.selected = !self.defultAddBtn.selected;
    if (self.defultAddBtn.selected) {
        self.is_defualt = @1;
    } else {
        self.is_defualt = @0;
    }
}




/*! 新增地址按钮的点击 */
- (IBAction)newAddressBtnClick:(UIButton *)sender {
    
    
    
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = unmodel.uid;
    param[@"token"] = unmodel.token;
    param[@"name"] = self.reciveGoodsP.text;
    param[@"mobile"] = self.phoneNum.text;
    param[@"province_id"] = self.IDPro;
    param[@"city_id"] = self.IDCity;
    param[@"area_id"] = self.IDArea;
    param[@"address"] = self.detailAddTex.text;
    if (self.is_defualt) {
        param[@"is_defualt"] = self.is_defualt;
    } else {
        self.is_defualt = @0;
        param[@"is_defualt"] = self.is_defualt;
    }
    
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/Usersaddress/address_add" params:param complement:^(ServerResponseInfo * _Nullable serverInfo) {
        
            
        if ([[serverInfo.response objectForKey:@"code"] integerValue] == 200) {
            
            [HUDManager showTextHud:@"添加成功"];
            [self.navigationController popViewControllerAnimated:YES];
             [[NSNotificationCenter defaultCenter] postNotificationName:@"popView" object:nil];
        }
        if ([[serverInfo.response objectForKey:@"code"] integerValue] == 201) {
                   
                   [HUDManager showTextHud:@"请填写完整"];
                   
               }
        
    }];
    
   
    
}


- (void)setupLabelGes
{
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)];
    [self.addLabel addGestureRecognizer:tapGes];
}

- (void)labelClick
{
    [self.modalView show];
}

- (AddressView *)addressView {
    
    if (!_addressView) {
        _addressView = [[AddressView alloc] init];
        _addressView.frame = CGRectMake(0, 0, kScreenWidth, 400);
        ADWeakSelf;
//         最后一列的行被点击的回调
        _addressView.lastComponentClickedBlock = ^(ZBNProvince *selectedProvince, ZBNCity *selectedCity, ZBNArea *selectedArea) {

            [weakSelf.modalView hide];

            weakSelf.addLabel.text = [NSString stringWithFormat:@"%@%@%@",selectedProvince.name,selectedCity.name,selectedArea.fullname];
            weakSelf.IDPro = selectedProvince.ID;
            weakSelf.IDCity = selectedCity.ID;
            weakSelf.IDArea = selectedArea.ID;
        };
    }
    return _addressView;
}

/*! 加载数据 */
- (void)loadData
{
//    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/api/common/district" params:nil complement:^(ServerResponseInfo * _Nullable serverInfo) {
//        self.dataArr = [ZBNProvince mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"]];
//        self.addressView.datas = self.dataArr;
//    }];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"pcd" ofType:@"plist"];
    self.dataArr = [ZBNProvince mj_objectArrayWithFile:filePath];
    self.addressView.datas = self.dataArr;
}


#pragma mark -- lazy





@end
