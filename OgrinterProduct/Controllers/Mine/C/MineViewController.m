//
//  MineViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/28.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "MineViewController.h"

//#import "MyWalletVC.h"
//#import "MyPostVC.h"
//#import "ShoppingCartVc.h"
//#import "MyPostBarVC.h"
//#import "MyCollectionVC.h"
//#import "BrowseHistoryVC.h"
//#import "MyAddressVC.h"
//#import "MyIntegerVC.h"
//#import "MyNewsVC.h"
//#import "MerchantEntryVC.h"


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


////MARK: 按钮事件点击
//
///*! 邀请有礼 */
//- (IBAction)giftForInviteClick:(UIButton *)sender
//{
//    NSLog(@"giftClick");
//}
///*! 我的钱包 */
//- (IBAction)myWallet:(UIButton *)sender
//{
//    MyWalletVC *myWalletVC = [[MyWalletVC alloc] init];
//    [self.navigationController pushViewController:myWalletVC animated:YES];
//}
///*! 我的发布 */
//- (IBAction)myRelease:(UIButton *)sender
//{
//    MyPostVC *myPostVC = [[MyPostVC alloc] init];
//    [self.navigationController pushViewController:myPostVC animated:YES];
//}
///*! 我的贴吧 */
//
//- (IBAction)myPostBar:(UIButton *)sender {
//
//    MyPostBarVC *postBarVc = [[MyPostBarVC alloc] init];
//    [self.navigationController pushViewController:postBarVc animated:YES];
//}
//
///*! 购物车 */
//- (IBAction)shoppingCart:(UIButton *)sender {
//    ShoppingCartVc *shoppingVc = [[ShoppingCartVc alloc] init];
//    [self.navigationController pushViewController:shoppingVc animated:YES];
//}
///*! 我的收藏 */
//- (IBAction)myCollection:(UIButton *)sender {
//    MyCollectionVC *collectionVc = [[MyCollectionVC alloc] init];
//    [self.navigationController pushViewController:collectionVc animated:YES];
//}
///*! 浏览痕迹 */
//- (IBAction)browsingHistory:(UIButton *)sender {
//    BrowseHistoryVC *historyVC = [[BrowseHistoryVC alloc] init];
//    [self.navigationController pushViewController:historyVC animated:YES];
//}
///*! 我的地址 */
//- (IBAction)myaddress:(UIButton *)sender {
//    MyAddressVC *addressVc = [[MyAddressVC alloc] init];
//    [self.navigationController pushViewController:addressVc animated:YES];
//}
///*! 我的积分 */
//- (IBAction)myIntegral:(UIButton *)sender {
//    MyIntegerVC *integerVc = [[MyIntegerVC alloc] init];
//    [self.navigationController pushViewController:integerVc animated:YES];
//}
///*! 我的消息 */
//- (IBAction)myNews:(UIButton *)sender {
//    MyNewsVC *newsVc = [[MyNewsVC alloc] init];
//    [self.navigationController pushViewController:newsVc animated:YES];
//}
///*! 商家入驻 */
//- (IBAction)merchantEntry:(UIButton *)sender {
//    MerchantEntryVC *merchantVc = [[MerchantEntryVC alloc] init];
//    [self.navigationController pushViewController:merchantVc animated:YES];
//}
///*! 成为配送员 */
//- (IBAction)beDeliveryClerk:(UIButton *)sender {
//}
///*! 下载APP */
//- (IBAction)downloadApp:(UIButton *)sender {
//}
///*! 我的直播 */
//- (IBAction)myLiveBroadcast:(UIButton *)sender {
//}
//
///*! 操作视频 */
//- (IBAction)operationVideo:(UIButton *)sender {
//}

@end
