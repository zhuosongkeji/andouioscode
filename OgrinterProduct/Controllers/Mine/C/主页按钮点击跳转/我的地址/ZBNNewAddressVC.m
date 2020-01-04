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

@interface ZBNNewAddressVC () <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

/*! 储存数据的数组 */
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *addArrays;
@property (nonatomic, strong) NSMutableArray *addArrCitys;
@property (nonatomic, strong) NSMutableArray *addArrAreas;

/*! ID **/
@property (nonatomic, assign) NSNumber *IDPro;
@property (nonatomic, assign) NSNumber *IDCity;
@property (nonatomic, assign) NSNumber *IDArea;

/*! 选中省的行数 */
@property (nonatomic, assign) NSInteger selProvinceIndex;
/*! 选中城市的行数 */
@property (nonatomic, assign) NSInteger selCityIndex;
/*! 选中地区的行数 */
@property (nonatomic, assign) NSInteger selAreaIndex;
/*! 用来选则的textField */
@property (weak, nonatomic) IBOutlet UITextField *choseAdd;
/*! 地址详情 */
@property (weak, nonatomic) IBOutlet UITextField *detailAddTex;
/*! 默认地址按钮 */
@property (weak, nonatomic) IBOutlet UIButton *defultAddBtn;
/*! 收货人 */
@property (weak, nonatomic) IBOutlet UITextField *reciveGoodsP;
/*! 收货人号码 */
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;

@property (nonatomic, assign) NSNumber *is_defualt;

@end

@implementation ZBNNewAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"新增地址";
    // 设置代理
    self.choseAdd.delegate = self;
    // 设置选择器
    [self setupPickerView];
    // 加载数据
    [self loadData];
    
    self.is_defualt = @0;

}

/*! 选择街道按钮的点击 */
- (IBAction)chooseRoad:(UIButton *)sender {
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
    
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/api/Usersaddress/address_add" params:param complement:^(ServerResponseInfo * _Nullable serverInfo) {
        
            
        if ([[serverInfo.response objectForKey:@"code"] integerValue] == 200) {
            
            [HUDManager showTextHud:@"添加成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        if ([[serverInfo.response objectForKey:@"code"] integerValue] == 201) {
                   
                   [HUDManager showTextHud:@"请填写完整"];
                   
               }
        
    }];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"popView" object:nil];
    
}


// 是否允许用户输入文字
// 作用:拦截用户的输入
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return NO;
}

/*! 加载数据 */
- (void)loadData
{
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/api/common/district" params:nil complement:^(ServerResponseInfo * _Nullable serverInfo) {
        [self.dataArr addObjectsFromArray: serverInfo.response[@"data"]];
        NSLog(@"%@data",self.dataArr);
    }];
}


/*! 设置选择器 */
- (void)setupPickerView
{
    UIPickerView *pickV = [[UIPickerView alloc] init];
    pickV.delegate = self;
    pickV.dataSource = self;
    self.choseAdd.inputView = pickV;
//    [self setUpText];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
   
    if (self.dataArr) {
    
    if (component == 0) {
        self.addArrays = [ZBNProvince mj_objectArrayWithKeyValuesArray:self.dataArr];
        return self.addArrays.count;
    } else if (component == 1) {
        self.addArrCitys = [ZBNCity mj_objectArrayWithKeyValuesArray:[self.dataArr[_selProvinceIndex] valueForKeyPath:@"cities"]];
        return self.addArrCitys.count;
    } else {
        self.addArrAreas = [ZBNArea mj_objectArrayWithKeyValuesArray:[[self.dataArr[_selProvinceIndex] valueForKeyPath:@"cities"][_selCityIndex] valueForKeyPath:@"areas"]];
        return self.addArrAreas.count;
    }
    } else {
        
        [HUDManager showTextHud:@"正在加载数据"];
        return 0;
    }
}


#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        ZBNProvince *p = self.addArrays[row];
        return p.name;
    } else if (component == 1) {
        ZBNCity *c = self.addArrCitys[row];
        return c.name;
    } else {
        ZBNArea *a = self.addArrAreas[row];
        return a.name;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        _selProvinceIndex = row;
        _selCityIndex = 0;
        _selAreaIndex = 0;
        self.addArrCitys = [ZBNCity mj_objectArrayWithKeyValuesArray:[self.dataArr[_selProvinceIndex] valueForKeyPath:@"cities"]];
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        self.addArrAreas = [[self.addArrays[_selAreaIndex] valueForKeyPath:@"cities"][0] valueForKeyPath:@"areas"];
        [pickerView reloadComponent:2];
    } else if (component == 1) {
        _selCityIndex = row;
        _selAreaIndex = 0;
        self.addArrAreas = [[self.addArrays[_selProvinceIndex] valueForKeyPath:@"cities"][_selCityIndex] valueForKeyPath:@"areas"];
        [pickerView reloadComponent:2];
    } else {
        _selAreaIndex = row;
    }
    
    
    // 给文本框赋值
    // 获取当前选中的第0列
    ZBNProvince *p = self.addArrays[_selProvinceIndex];
    // 省会名称
    NSString *pName = p.name;
    NSNumber *pID = p.ID;
//    NSNumber *pPid = p.pid;
    // 获取第一列选中的市
    ZBNCity *c = self.addArrCitys[_selCityIndex];
    // 获取市名称
    NSString *cityName = c.name;
    NSNumber *cID = c.ID;
//    NSNumber *cPid = c.pid;
    // 获取第2列选中的区
    ZBNArea *a = self.addArrAreas[_selAreaIndex];
    NSString *areaName = a.name;
    NSNumber *aID = a.ID;
//    NSNumber *aPid = a.pid;
    self.choseAdd.text = [NSString stringWithFormat:@"%@%@%@",pName,cityName,areaName];
    // 存储选中地区的ID
    self.IDPro = pID;
    self.IDCity = cID;
    self.IDArea = aID;
}

#pragma mark -- lazy

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


- (NSMutableArray *)addArrays
{
    if (!_addArrays) {
        _addArrays = [NSMutableArray array];
    }
    return _addArrays;
}

- (NSMutableArray *)addArrCitys
{
    if (!_addArrCitys) {
        _addArrCitys = [NSMutableArray array];
    }
    return _addArrCitys;
}

- (NSMutableArray *)addArrAreas
{
    if (!_addArrAreas) {
        _addArrAreas = [NSMutableArray array];
    }
    return _addArrAreas;
}

@end
