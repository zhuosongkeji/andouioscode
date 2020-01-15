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


@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toTop;

@property (weak, nonatomic) IBOutlet UITableView *mTableView;


/********************************begin-- 数据相关*************************************/
/*! 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *headImageV;
/*! vipView */
@property (weak, nonatomic) IBOutlet UIView *vipView;
/*! 用户名 */
@property (weak, nonatomic) IBOutlet UILabel *userName;
/*! 等级 */
@property (weak, nonatomic) IBOutlet UILabel *integerL;
/*! 关注 */

/*! 收藏 */
/*! 浏览记录 */
/*! 余额 */
@property (weak, nonatomic) IBOutlet UILabel *money;


/*! 模型 */
@property (nonatomic, strong) ZBNMineModel *model;
@property (nonatomic, strong) ZBNMineSettingModel *settingM;
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
    
    // 接收登录成功过的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"loginOK" object:nil];
}

// 控制器销毁时调用
- (void)dealloc
{
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"loginOK" object:nil];
}

#pragma mark -- UI
- (void)setupUI
{
    self.toTop.constant = getRectNavAndStatusHight;
    self.mTableView.tableFooterView = [UILabel new];
    self.headImageV.image = [UIImage circleImageNamed:@"yxj"];
    self.vipView.layer.cornerRadius = 10;
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
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"uid"] = unmodel.uid;
        param[@"token"] = unmodel.token;
       [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:ZBNPersonURL params:param complement:^(ServerResponseInfo * _Nullable serverInfo) {
           self.model = [ZBNMineModel mj_objectWithKeyValues:serverInfo.response[@"data"]];
           // 设置头像
           self.headImageV.image = [UIImage circleImageNamed:@"yxj"];
           // 设置用户名
           self.userName.text = [NSString stringWithFormat:@"%@",self.model.name];
           // 余额
           self.money.text = self.model.money;
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
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(vipViewClick)];
    [self.vipView addGestureRecognizer:tapGes];
}

- (void)vipViewClick
{
    [self pushViewControllerWithString:@"ZBNMyIntegralVC"];
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
        [self pushViewControllerWithString:@"ZBNRestaurantOrderVC"];
    } else if (sender.tag == 301) { // 酒店订单
        [self pushViewControllerWithString:@"ZBNHTOrderVC"];
    } else if (sender.tag == 302) { // 饭店订单
        [self pushViewControllerWithString:@"ZBNShoppingHallOrderVC"];
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
//            [self pushViewControllerWithString:@"ZBNMyPostVC"];
        }
    
}






@end
