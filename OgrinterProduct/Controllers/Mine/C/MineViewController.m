//
//  MineViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/28.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "MineViewController.h"

#import "MyWalletVC.h"
#import "MyPostVC.h"

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


//MARK: 按钮事件点击

/*! 邀请有礼 */
- (IBAction)giftForInviteClick:(UIButton *)sender
{
    NSLog(@"giftClick");
}
/*! 我的钱包 */
- (IBAction)myWallet:(UIButton *)sender
{
    MyWalletVC *myWalletVC = [[MyWalletVC alloc] init];
    [self.navigationController pushViewController:myWalletVC animated:YES];
}

/*! 我的发布 */
- (IBAction)myRelease:(UIButton *)sender
{
    MyPostVC *myPostVC = [[MyPostVC alloc] init];
    [self.navigationController pushViewController:myPostVC animated:YES];
}

/*! 我的贴吧 */

- (IBAction)myPostBar:(UIButton *)sender {
}

/*! 购物车 */
- (IBAction)shoppingCart:(UIButton *)sender {
}
/*! 我的收藏 */
- (IBAction)myCollection:(UIButton *)sender {
}
/*! 浏览痕迹 */
- (IBAction)browsingHistory:(UIButton *)sender {
}
/*! 我的地址 */
- (IBAction)myaddress:(UIButton *)sender {
}
/*! 我的积分 */
- (IBAction)myIntegral:(UIButton *)sender {
}
/*! 我的消息 */
- (IBAction)myNews:(UIButton *)sender {
}
/*! 商家入驻 */
- (IBAction)merchantEntry:(UIButton *)sender {
}
/*! 成为配送员 */
- (IBAction)beDeliveryClerk:(UIButton *)sender {
}
/*! 下载APP */
- (IBAction)downloadApp:(UIButton *)sender {
}
/*! 我的直播 */
- (IBAction)myLiveBroadcast:(UIButton *)sender {
}

/*! 操作视频 */
- (IBAction)operationVideo:(UIButton *)sender {
}

@end
