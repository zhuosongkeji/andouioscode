//
//  ZBNShoppingMallEntryCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/20.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNShoppingMallEntryCell.h"
#import "YNImageUploadView.h"
#import "Masonry.h"
#import "ZBNMallEntryModel.h"
#import "ZBNProvince.h"
#import "ZBNCity.h"
#import "ZBNArea.h"


@interface ZBNShoppingMallEntryCell () <UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource>


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

/*! 商家名 */
@property (weak, nonatomic) IBOutlet UITextField *shopNameInput;
/*! 联系人名称 */
@property (weak, nonatomic) IBOutlet UITextField *name;
/*! 联系人电话 */
@property (weak, nonatomic) IBOutlet UITextField *phone;
/*! 店铺地址 */
@property (weak, nonatomic) IBOutlet UITextField *address_id;
/*! 店铺详细地址 */
@property (weak, nonatomic) IBOutlet UITextField *detailAdd;
/*! 商家简介 */
@property (weak, nonatomic) IBOutlet UITextView *shopIntrol;
/*! 商家海报图 */
@property (weak, nonatomic) IBOutlet UIView *haibaoView;
/*! 海报图上传的view */
@property (nonatomic, weak) YNImageUploadView *upLoadViewOne;
/*! 商家LOGO图 */
@property (weak, nonatomic) IBOutlet UIView *shopLOGOView;
@property (nonatomic, weak) YNImageUploadView *upLoadViewTWo;
/*! 营业执照 */
@property (weak, nonatomic) IBOutlet UIView *yingYeView;
@property (nonatomic, weak) YNImageUploadView *upLoadViewThree;
@end

@implementation ZBNShoppingMallEntryCell


- (void)setDelegate
{
    self.shopNameInput.delegate = self;
    self.name.delegate = self;
    self.phone.delegate = self;
    self.detailAdd.delegate = self;
    self.shopIntrol.delegate = self;
}


#pragma mark -- 注册cell

+ ( instancetype )registerCellForTableView:(UITableView *)tableView
                                       
{
    static NSString * const ZBNShoppingMallEntryCellID = @"ZBNShoppingMallEntryCellID";
    ZBNShoppingMallEntryCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNShoppingMallEntryCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNShoppingMallEntryCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.model setDetailAdd:self.detailAdd.text];
    [self.model setPhoneNum:self.phone.text];
    [self.model setShopName:self.shopNameInput.text];
    [self.model setUserName:self.name.text];
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self.model setShopIntrol:self.shopIntrol.text];
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setDelegate];
    
    // 设置选择器
    [self setupPickerView];
    [self loadData];
    self.model = [ZBNMallEntryModel sharedInstance];
    
    // 设置第一个上传界面
    [self setUpLoadViewOne];
    [self setUpLoadViewTwo];
    [self setUpLoadViewThree];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upLoadOne) name:@"getURLOne" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upLoadTwo) name:@"getURLTwo" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upLoadThree) name:@"getURLThree" object:nil];
}

- (void)upLoadOne
{
    [self.model setUrlOne:self.upLoadViewOne.get_url];
    NSLog(@"%@",self.model.urlOne);
}

- (void)upLoadTwo
{
    [self.model setUrlTwo:self.upLoadViewTWo.get_url];
}

- (void)upLoadThree
{
    [self.model setUrlThree:self.upLoadViewThree.get_url];
}

- (void)setUpLoadViewOne
{
    __weak typeof(self)weakSelf = self;
       NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
       userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
       NSMutableDictionary *param = [NSMutableDictionary dictionary];
           param[@"uid"] = unmodel.uid;
           param[@"token"] = unmodel.token;
          YNImageUploadView *imageView = [[YNImageUploadView alloc] initWithConfig:^(YNImageUploadViewConfig * _Nonnull config) {
              config.insets = UIEdgeInsetsMake(5, 10, 5, 10);
              config.autoHeight = YES;
              config.isNeedUpload = YES;
              config.uploadUrl = @"http://andou.zhuosongkj.com/index.php/api/goods/uploads";
              config.parameter = param;
          }];

              [weakSelf.haibaoView addSubview:imageView];
                self.upLoadViewOne = imageView;
              [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.right.equalTo(weakSelf.haibaoView);
              make.height.equalTo(@(80));
              
              }];
}


- (void)setUpLoadViewTwo
{
    __weak typeof(self)weakSelf = self;
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"uid"] = unmodel.uid;
        param[@"token"] = unmodel.token;
       YNImageUploadView *imageView = [[YNImageUploadView alloc] initWithConfig:^(YNImageUploadViewConfig * _Nonnull config) {
           config.insets = UIEdgeInsetsMake(5, 10, 5, 10);
           config.autoHeight = YES;
           config.isNeedUpload = YES;
           config.uploadUrl = @"http://andou.zhuosongkj.com/index.php/api/goods/uploads";
           config.parameter = param;
       }];

           [weakSelf.shopLOGOView addSubview:imageView];
             self.upLoadViewTWo = imageView;
           [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.right.equalTo(weakSelf.haibaoView);
           make.height.equalTo(@(80));
           
           }];
}

- (void)setUpLoadViewThree
{
    __weak typeof(self)weakSelf = self;
       NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
       userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
       NSMutableDictionary *param = [NSMutableDictionary dictionary];
           param[@"uid"] = unmodel.uid;
           param[@"token"] = unmodel.token;
          YNImageUploadView *imageView = [[YNImageUploadView alloc] initWithConfig:^(YNImageUploadViewConfig * _Nonnull config) {
              config.insets = UIEdgeInsetsMake(5, 10, 5, 10);
              config.autoHeight = YES;
              config.isNeedUpload = YES;
              config.uploadUrl = @"http://andou.zhuosongkj.com/index.php/api/goods/uploads";
              config.parameter = param;
          }];

              [weakSelf.yingYeView addSubview:imageView];
                self.upLoadViewThree = imageView;
              [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.right.equalTo(weakSelf.haibaoView);
              make.height.equalTo(@(80));
              
              }];
}


/*! 加载数据 */
- (void)loadData
{
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/api/common/district" params:nil complement:^(ServerResponseInfo * _Nullable serverInfo) {
        [self.dataArr addObjectsFromArray: serverInfo.response[@"data"]];
        
    }];
}

/*! 设置选择器 */
- (void)setupPickerView
{
    UIPickerView *pickV = [[UIPickerView alloc] init];
    pickV.delegate = self;
    pickV.dataSource = self;
    self.address_id.inputView = pickV;

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
        [pickerView selectRow:0 inComponent:2 animated:YES];
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
    self.address_id.text = [NSString stringWithFormat:@"%@%@%@",pName,cityName,areaName];
    // 存储选中地区的ID
    self.IDPro = pID;
    self.IDCity = cID;
    self.IDArea = aID;
    [self.model setIDPro:self.IDPro];
    [self.model setIDCity:self.IDCity];
    [self.model setIDArea:self.IDArea];
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
