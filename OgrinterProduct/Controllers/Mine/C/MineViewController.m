//
//  MineViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/28.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "MineViewController.h"




@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mTableView;




@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mTableView.tableFooterView = [UILabel new];
    // Do any additional setup after loading the view from its nib.
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
