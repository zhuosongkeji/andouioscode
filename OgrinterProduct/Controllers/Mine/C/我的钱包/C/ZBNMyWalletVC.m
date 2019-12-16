//
//  ZBNMyWalletVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMyWalletVC.h"
#import "ZBNMyWalletHeadView.h"
#import "ZBNCostVC.h"
#import "ZBNReChargeDetailVC.h"
#import "ZBNSegmenBarVC.h"
#import "ZBNCashWithDrawalVC.h"
#import "ZBNWalletRechargeVC.h"

@interface ZBNMyWalletVC ()

/*! headView */
@property (nonatomic, weak) ZBNMyWalletHeadView *headView;
/*! 选择卡 */
@property (nonatomic, strong) ZBNSegmenBarVC *segmentBarVC;

@end

@implementation ZBNMyWalletVC

- (ZBNSegmenBarVC *)segmentBarVC {
    if (!_segmentBarVC) {
        ZBNSegmenBarVC *vc = [[ZBNSegmenBarVC alloc] init];
        [self addChildViewController:vc];
        _segmentBarVC = vc;
    }
    return _segmentBarVC;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.segmentBarVC.segmentBar.layer.cornerRadius = 15;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // 设置headerView
    [self setupHeadView];
    // 设置选项卡
    [self setupSegmen];
}

- (void)setupHeadView
{
    ZBNMyWalletHeadView *headV = [ZBNMyWalletHeadView viewFromXib];
    headV.frame =CGRectMake(0, 0, self.view.width, 150);
    [self.view addSubview:headV];
    self.headView = headV;
    ADWeakSelf;
    self.headView.cashWithDrawalBtnClickTask = ^{
        ZBNWalletRechargeVC *reVc = [[ZBNWalletRechargeVC alloc] init];
        [self.navigationController pushViewController:reVc animated:YES];
    };
}

- (void)setupSegmen
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.segmentBarVC.segmentBar.frame = CGRectMake(0,0 , self.view.width, 50);
    self.segmentBarVC.view.frame = CGRectMake(0, 140, self.view.width, self.view.height-64);
    [self.view addSubview:self.segmentBarVC.view];
    //添加控制器
    NSArray *items = @[@"消费明细", @"充值明细"];

    ZBNCostVC *vc1 = [[ZBNCostVC alloc] init];
    
    ZBNReChargeDetailVC *vc2 = [[ZBNReChargeDetailVC alloc] init];

    [self.segmentBarVC setUpWithItems:items childVCs:@[vc1, vc2]];
    //设置样式
    [self.segmentBarVC.segmentBar updateWithConfig:^(ZBNSegmenBarConfig *config) {
        config.itemNColor([UIColor blackColor]).itemSColor([UIColor colorWithRed:50/255.0 green:193/255.0 blue:164/255.0 alpha:1]).itemF([UIFont systemFontOfSize:16]).itemBColor([UIColor whiteColor]).indicatorH(0);
        config.indicatorExtraW = 0;
    }];

    //少量标签需要均分的情形
    self.segmentBarVC.segmentBar.isDivideEqually = YES;
}

@end
