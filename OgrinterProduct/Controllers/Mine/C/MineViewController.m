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
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
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
    // 加载数据
    [self loadData];
    
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
    self.toTop.constant = kStatusBarAndNavigationBarH;
    self.mTableView.tableFooterView = [UILabel new];
    self.headImageV.image = [UIImage circleImageNamed:@"yxj"];
    self.vipView.layer.cornerRadius = 10;
}

#pragma mark -- loadData
- (void)loadData
{
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"uid"] = unmodel.uid;
        param[@"token"] = unmodel.token;
       [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/api/wallet/personal" params:param complement:^(ServerResponseInfo * _Nullable serverInfo) {
           self.model = [ZBNMineModel mj_objectWithKeyValues:serverInfo.response[@"data"]];
           // 如果是vip显示,不是就隐藏
           if (self.model.grade) {
               self.gradeLabel.text = [NSString stringWithFormat:@"%@", self.model.grade];
           } else {
               self.view.hidden = YES;
           }
           // 设置头像
           [self.headImageV sd_setImageWithURL:[NSURL URLWithString:self.model.avator]];
           // 设置用户名
           self.userName.text = [NSString stringWithFormat:@"%@",self.model.name];
           
           
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



/*! 设置按钮的点击 */
- (IBAction)settingBtnClick:(UIButton *)sender {
    [self pushViewControllerWithString:@"ZBNMineSettingVC"];
    
}





/*! 中间View按钮的点击事件 */
- (IBAction)middleViewBtnClick:(UIButton *)sender {
    // 商家订单
    if (sender.tag == 300) {
        [self pushViewControllerWithString:@"ZBNRestaurantOrderVC"];
    } else if (sender.tag == 301) { // 酒店订单
        [self pushViewControllerWithString:@"ZBNHotelOrderVC"];
    } else if (sender.tag == 302) { // 饭店订单
        [self pushViewControllerWithString:@"ZBNShoppingHallOrderVC"];
    }
}

/*! 底部View按钮的点击事件 */
- (IBAction)bottomViewBtnClick:(UIButton *)sender {
    
    if (sender.tag == 500) { // 邀请有礼
            [self pushViewControllerWithString:@"InviteCourtesyVC"];
        } else if (sender.tag == 501) {  // 我的钱包
            [self pushViewControllerWithString:@"ZBNMyWalletVC"];
        } else if (sender.tag == 502) {  // 我的发布
    //        [self pushViewControllerWithString:@"ZBNMyPostVC"];
            [HUDManager showTextHud:OtherMsg];
        } else if (sender.tag == 503) {  // 我的贴吧
    //        [self pushViewControllerWithString:@"ZBNMyPostBarVC"];
            [HUDManager showTextHud:OtherMsg];
        } else if (sender.tag == 504) { // 购物车
            [self pushViewControllerWithString:@"ZBNShopingCartVC"];
        } else if (sender.tag == 505) { // 我的收藏
            [self pushViewControllerWithString:@"ZBNMyCollectionVC"];
        } else if (sender.tag == 506) { // 浏览痕迹
            [self pushViewControllerWithString:@"ZBNBrowseHistoryVC"];
        } else if (sender.tag == 507) { // 我的地址
            [self pushViewControllerWithString:@"ZBNMyAddressVC"];
        } else if (sender.tag == 508) { // 我的积分
            [self pushViewControllerWithString:@"ZBNMyIntegralVC"];
        } else if (sender.tag == 509) { // 我的消息
            [self pushViewControllerWithString:@"ZBNMyNewsVC"];
        } else if (sender.tag == 510) { // 商家入驻
            [self pushViewControllerWithString:@"ZBNMerchantEntry"];
        } else if (sender.tag == 511) { // 成为配送员
            [HUDManager showTextHud:OtherMsg];
        } else if (sender.tag == 512) { // 下载APP
            [self pushViewControllerWithString:@"ZBNDowmLoadAppVC"];
        } else if (sender.tag == 513) {  // 操作视频
            [self pushViewControllerWithString:@"ZBNOperationVideoVC"];
        }
    
}






@end
