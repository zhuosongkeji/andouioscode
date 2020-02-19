//
//  MineViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/28.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "MineViewController.h"

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ZBNMineModel.h"
#import "ZBNMineSettingModel.h"
#import "InviteCourtesyVC.h"
#import "ZBNDowmLoadAppVC.h"
#import "ZBNMyWalletVC.h"
#import "Img+lable.h"
#import "PPBadgeView.h"




@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toTop;

@property (weak, nonatomic) IBOutlet UITableView *mTableView;


/********************************begin-- 数据相关*************************************/
/*! 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *headImageV;
/*! integerView */
@property (weak, nonatomic) IBOutlet UIView *integerView;
/*! 用户名 */
@property (weak, nonatomic) IBOutlet UILabel *userName;
/*! 积分label */
@property (weak, nonatomic) IBOutlet UILabel *integerL;
/*! 店铺关注 */
@property (weak, nonatomic) IBOutlet UILabel *shopFocus;
/*! 商品收藏 */
@property (weak, nonatomic) IBOutlet UILabel *goodsCollection;
/*! 浏览记录 */
@property (weak, nonatomic) IBOutlet UILabel *historyL;
/*! 余额 */
@property (weak, nonatomic) IBOutlet UILabel *money;
/*! 会员plus */
@property (weak, nonatomic) IBOutlet UIImageView *vipPlusView;
/*! 模型 */
@property (nonatomic, strong) ZBNMineModel *model;
@property (nonatomic, strong) ZBNMineSettingModel *settingM;

/*! 美食 */
@property (weak, nonatomic) IBOutlet Img_lable *foodOrderBtn;
/*! 酒店 */
@property (weak, nonatomic) IBOutlet Img_lable *hotelOrderBtn;
/*! 商城 */
@property (weak, nonatomic) IBOutlet Img_lable *shopOrderBtn;
/********************************end-- 数据相关**************************************/
@end

@implementation MineViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置界面相关
    [self setupUI];
    // 设置导航栏
    [self setupNav];
    // 加载数据
    [self loadData];
    // 设置手势
    [self setupGes];
    // 设置table
    [self setupTable];
    
    
//    [self.shopOrderBtn pp_addBadgeWithText:@"4"];
//    [self.shopOrderBtn pp_moveBadgeWithX:-30 Y:0];
//    [self.shopOrderBtn pp_setBadgeFlexMode:PPBadgeViewFlexModeTail];
    // 接收登录成功过的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"loginOK" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"iconChangeOK" object:nil];

}


- (void)setupTable
{
    self.mTableView.bounces = NO;
}

// 控制器销毁时调用
- (void)dealloc
{
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"loginOK" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"iconChangeOK" object:nil];
}

#pragma mark -- UI
- (void)setupUI
{
//    self.toTop.constant = getRectNavAndStatusHight;
    self.navigationController.navigationBar.translucent = NO;
    self.mTableView.tableFooterView = [UILabel new];
    self.integerView.layer.cornerRadius = 10;
    self.headImageV.userInteractionEnabled = YES;
}

- (void)setupNav
{
    self.navigationItem.title = @"会员中心";
    
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"Settings" highImage:@"" target:self action:@selector(settingClick)];
    UIBarButtonItem *newsItem = [UIBarButtonItem itemWithImage:@"消息" highImage:@"" target:self action:@selector(newsClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem, newsItem];
    
}

- (void)settingClick
{
    [self pushViewControllerWithString:@"ZBNMineSettingVC"];
}

- (void)newsClick
{
    [self pushViewControllerWithString:@"ZBNMyAllNewsVC"];
}




#pragma mark -- loadData
- (void)loadData
{
    [FKHRequestManager cancleRequestWork];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"uid"] = unmodel.uid;
        param[@"token"] = unmodel.token;
    ADWeakSelf;
       [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:ZBNPersonURL params:param complement:^(ServerResponseInfo * _Nullable serverInfo) {
           
           weakSelf.model = [ZBNMineModel mj_objectWithKeyValues:serverInfo.response[@"data"]];
           // 设置头像
           [weakSelf.headImageV setHeader:[NSString stringWithFormat:@"%@%@",imgServer,weakSelf.model.avator]];
           // 设置用户名 
            weakSelf.userName.text = [NSString stringWithFormat:@"%@",weakSelf.model.name];
           // 余额
           weakSelf.money.text = weakSelf.model.money;
           // 店铺关注
           weakSelf.shopFocus.text = weakSelf.model.focus;
           // 商品收藏
           weakSelf.goodsCollection.text = weakSelf.model.collect;
           // 浏览记录
           weakSelf.historyL.text = weakSelf.model.record;
           // 我的积分
           weakSelf.integerL.text = [NSString stringWithFormat:@"我的积分:%@",weakSelf.model.integral];
           // 美食
           if ([weakSelf.model.foodsordernum isEqualToString:@"0"]) {
               [weakSelf.foodOrderBtn pp_hiddenBadge];
           } else {
               [weakSelf.foodOrderBtn pp_addBadgeWithText:weakSelf.model.foodsordernum];
               [weakSelf.foodOrderBtn pp_moveBadgeWithX:-30 Y:0];
               [weakSelf.foodOrderBtn pp_setBadgeHeight:20];
           }
           
           // 酒店
           if ([weakSelf.model.booksordernum isEqualToString:@"0"]) {
               [weakSelf.hotelOrderBtn pp_hiddenBadge];
           } else {
               [weakSelf.hotelOrderBtn pp_addBadgeWithText:weakSelf.model.booksordernum];
               [weakSelf.hotelOrderBtn pp_moveBadgeWithX:-30 Y:0];
               [weakSelf.hotelOrderBtn pp_setBadgeHeight:20];
           }
           
           // 商城
           if ([weakSelf.model.goodordernum isEqualToString:@"0"]) {
               [weakSelf.shopOrderBtn pp_hiddenBadge];
           } else {
               [weakSelf.shopOrderBtn pp_addBadgeWithText:weakSelf.model.goodordernum];
               [weakSelf.shopOrderBtn pp_moveBadgeWithX:-30 Y:0];
               [weakSelf.shopOrderBtn pp_setBadgeHeight:20];
           }
           
           // 是否为会员plus
           if (self.model.status.intValue == 1) {
               self.vipPlusView.hidden = NO;
           } else {
               self.vipPlusView.hidden = YES;
           }

       }];
}

//MARK:-tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *Identifier = @"Identifier";
    
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


- (void)pushViewControllerWithString:(NSString *)nameStr{
    Class class = NSClassFromString(nameStr);
    UIViewController *vc = [[class alloc]initWithNibName:nil bundle:nil];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -- 点击事件

- (void)setupGes
{
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(integerViewClick)];
    [self.integerView addGestureRecognizer:tapGes];
    
    UITapGestureRecognizer *headerGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerClick)];
    [self.headImageV addGestureRecognizer:headerGes];
    
    // 商品收藏
    UITapGestureRecognizer *collectionGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(collectionClick)];
    self.goodsCollection.userInteractionEnabled = YES;
    [self.goodsCollection addGestureRecognizer:collectionGes];
    // 浏览痕迹
    UITapGestureRecognizer *browseGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(browseClick)];
    self.historyL.userInteractionEnabled = YES;
    [self.historyL addGestureRecognizer:browseGes];
    // 店铺关注
    UITapGestureRecognizer *shopFocusGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shopFocusClick)];
    self.shopFocus.userInteractionEnabled = YES;
    [self.shopFocus addGestureRecognizer:shopFocusGes];
}

- (void)shopFocusClick
{
    [self pushViewControllerWithString:@"ZBNShopFollowVC"];
}

- (void)headerClick
{
    // 进入vip充值界面
    [self pushViewControllerWithString:@"ZBNVIPRechargeVC"];
}


- (void)integerViewClick
{
    [self pushViewControllerWithString:@"ZBNMyIntegralVC"];
}

- (void)collectionClick
{
    [self pushViewControllerWithString:@"ZBNMyCollectionVC"];
}

- (void)browseClick
{
    [self pushViewControllerWithString:@"ZBNBrowseHistoryVC"];
}



/*! 我的钱包点击 */
- (IBAction)myWalletBtnClick:(UIButton *)btn
{
    ZBNMyWalletVC *vc = [[ZBNMyWalletVC alloc] init];
    vc.money = self.model.money;
    [self.navigationController pushViewController:vc animated:YES];
}

/*! 中间View按钮的点击事件 */
- (IBAction)middleViewBtnClick:(UIButton *)sender {
    // 商家订单
    if (sender.tag == 300) {
        [self pushViewControllerWithString:@"ZBNShoppingHallOrderVC"];
    } else if (sender.tag == 301) { // 酒店订单
        [self pushViewControllerWithString:@"ZBNHTOrderVC"];
    } else if (sender.tag == 302) { // 饭店订单
        [self pushViewControllerWithString:@"ZBNRTMainVC"];
    }
}

/*! 底部View按钮的点击事件 */
- (IBAction)bottomViewBtnClick:(UIButton *)sender {
    
    if (sender.tag == 500) { // 商家入驻
            [self pushViewControllerWithString:@"ZBNMerchantEntryVC"];
        } else if (sender.tag == 501) {  // 邀请有礼
            InviteCourtesyVC *vc = [[InviteCourtesyVC alloc] init];
            vc.modalPresentationStyle = 0;
            [self presentViewController:vc animated:YES completion:nil];
        } else if (sender.tag == 502) {  // 下载APP
            ZBNDowmLoadAppVC *vc  = [[ZBNDowmLoadAppVC alloc] init];
            vc.modalPresentationStyle = 0;
            [self presentViewController:vc animated:YES completion:nil];
        } else if (sender.tag == 503) {  // 我的收藏
            [self pushViewControllerWithString:@"ZBNShopingCartVC"];
        } else if (sender.tag == 504) { // 操作视频
            [self pushViewControllerWithString:@"ZBNOperationVideoVC"];
        } else if (sender.tag == 505) { // 我的地址
            [self pushViewControllerWithString:@"ZBNMyAddressVC"];
        } else if (sender.tag == 506) { // 我的二维码
            [HUDManager showTextHud:OtherMsg];
        } else if (sender.tag == 507) { // 我的发布
            [HUDManager showTextHud:OtherMsg];
            [self pushViewControllerWithString:@"ZBNMyPostVC"];
        }
    
}



- (void)setupRefresh
{
    // 下拉刷新
    self.mTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    // 自动改变透明度
    self.mTableView.mj_header.automaticallyChangeAlpha = YES;

}


@end
