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
#import "ZBNMineCell.h"



@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerH;

@property (weak, nonatomic) IBOutlet UIView *headerView;


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
/*! 感恩币 */
@property (weak, nonatomic) IBOutlet UILabel *thanks;

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
    // 设置手势
    [self setupGes];
    // 设置table
    [self setupTable];
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self wr_setNavBarBackgroundAlpha:0];
    [self loadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//     [self wr_setNavBarBackgroundAlpha:1];
}



- (void)setupTable
{
    self.mTableView.bounces = NO;
    
    if (@available(iOS 11.0, *)) {
           self.mTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
       }else {
           self.automaticallyAdjustsScrollViewInsets = NO;
       }
}

#pragma mark -- UI
- (void)setupUI
{
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
    [HUDManager showTextHud:OtherMsg];
//    [self pushViewControllerWithString:@"ZBNMyAllNewsVC"];
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
           weakSelf.thanks.text = [NSString stringWithFormat:@"%@",weakSelf.model.integral];
           // 美食
           if ([weakSelf.model.foodsordernum isEqualToString:@"0"] || weakSelf.model.foodsordernum == nil) {
               [weakSelf.foodOrderBtn pp_hiddenBadge];
           } else {
               [weakSelf.foodOrderBtn pp_addBadgeWithText:weakSelf.model.foodsordernum];
               [weakSelf.foodOrderBtn pp_moveBadgeWithX:-40 Y:10];
               [weakSelf.foodOrderBtn pp_setBadgeHeight:20];
           }
           
           // 酒店
           if ([weakSelf.model.booksordernum isEqualToString:@"0"] || weakSelf.model.booksordernum == nil) {
               [weakSelf.hotelOrderBtn pp_hiddenBadge];
           } else {
               [weakSelf.hotelOrderBtn pp_addBadgeWithText:weakSelf.model.booksordernum];
               [weakSelf.hotelOrderBtn pp_moveBadgeWithX:-40 Y:10];
               [weakSelf.hotelOrderBtn pp_setBadgeHeight:20];
           }
           
           // 商城
           if ([weakSelf.model.goodordernum isEqualToString:@"0"] || weakSelf.model.goodordernum == nil) {
               [weakSelf.shopOrderBtn pp_hiddenBadge];
           } else {
               [weakSelf.shopOrderBtn pp_addBadgeWithText:weakSelf.model.goodordernum];
               [weakSelf.shopOrderBtn pp_moveBadgeWithX:-40 Y:10];
               [weakSelf.shopOrderBtn pp_setBadgeHeight:20];
           }
           
           // 是否为会员plus
           if (self.model.status.intValue == 1) {
               self.vipPlusView.image = [UIImage imageNamed:@"vipPlus"];
           } else {
               self.vipPlusView.image = [UIImage imageNamed:@"vip11"];
               
           }

       }];
}

//MARK:-tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZBNMineCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNMineCell" owner:nil options:nil].lastObject;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.height - 490;
}


//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//}


- (void)pushViewControllerWithString:(NSString *)nameStr{
    Class class = NSClassFromString(nameStr);
    UIViewController *vc = [[class alloc]initWithNibName:nil bundle:nil];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -- 点击事件

- (void)setupGes
{
    // 感恩币
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(integerViewClick)];
    self.thanks.userInteractionEnabled = YES;
    [self.thanks addGestureRecognizer:tapGes];
    
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
    //
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
    vc.hidesBottomBarWhenPushed = YES;
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
            [HUDManager showTextHud:@"暂未开放敬请期待.."];
//            [self pushViewControllerWithString:@"ZBNOperationVideoVC"];
        } else if (sender.tag == 505) { // 我的地址
            [self pushViewControllerWithString:@"ZBNMyAddressVC"];
        } else if (sender.tag == 506) { // 我的二维码
            [HUDManager showTextHud:OtherMsg];
        } else if (sender.tag == 507) { // 我的发布
            [HUDManager showTextHud:OtherMsg];
//            [self pushViewControllerWithString:@"ZBNMyPostVC"];
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
