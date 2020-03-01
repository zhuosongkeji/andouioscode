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

@interface ZBNShoppingMallEntryCell () <UITextFieldDelegate, UITextViewDelegate>

/*! 点击选择的label */
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

/*! 商家名 */
@property (weak, nonatomic) IBOutlet UITextField *shopNameInput;
/*! 联系人名称 */
@property (weak, nonatomic) IBOutlet UITextField *name;
/*! 联系人电话 */
@property (weak, nonatomic) IBOutlet UITextField *phone;

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

- (ZBNShoppingMallEntryCell * _Nonnull (^)(NSString * _Nonnull))setLabelText
{
    return ^(NSString *text) {
        [self.addressLabel setText:text];
        return self;
    };
}


- (void)awakeFromNib
{
    [super awakeFromNib];

    [self setDelegate];

    self.model = [ZBNMallEntryModel sharedInstance];
    
    // 设置第一个上传界面
    [self setUpLoadViewOne];
    [self setUpLoadViewTwo];
    [self setUpLoadViewThree];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upLoadOne) name:@"getURLOne" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upLoadTwo) name:@"getURLTwo" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upLoadThree) name:@"getURLThree" object:nil];
    
    // 设置Label的手势
    [self setupLabelGes];

    
}


- (void)setupLabelGes
{
    self.addressLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *labelGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)];
    [self.addressLabel addGestureRecognizer:labelGes];
}

- (void)labelClick
{
    if (self.upLoadViewOne.finish) {
    NSLog(@"%@image++++++++",self.upLoadViewOne.returnURL);
    }
    NSLog(@"%@image++++++++",self.upLoadViewOne.returnURL);
    if (self.addressLabelClickTask) {
        self.addressLabelClickTask();
    }
}

- (void)upLoadOne
{
    [self.model setUrlOne:self.model.upURLOne];
}

- (void)upLoadTwo
{
    [self.model setUrlTwo:self.model.upURLOne];
}

- (void)upLoadThree
{
    [self.model setUrlThree:self.model.upURLOne];
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
//              config.photoCount = 1;
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
           config.photoCount = 1;
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
              config.photoCount = 1;
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






#pragma mark -- lazy


@end
