//
//  ZBNShoppingHallOrderVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/12.
//  Copyright © 2019 RXF. All rights reserved.
//  商城订单控制器

#import "ZBNShoppingHallOrderVC.h"
#import "ZBNShoppingHallAllOrderVC.h"
#import "ZBNShoppingHallWaitPaymentOrderVC.h"
#import "ZBNSHWaitReceivingGoodsOrderVC.h"
#import "ZBNSHWaitEvaluateOrderVC.h"
#import "ZBNSegmenBarVC.h"
#import "ZBNSHDeliverGoodsOrderVC.h"

@interface ZBNShoppingHallOrderVC ()

@property (nonatomic, strong) ZBNSegmenBarVC *segmentBarVC;

@end

@implementation ZBNShoppingHallOrderVC

- (ZBNSegmenBarVC *)segmentBarVC {
    if (!_segmentBarVC) {
        ZBNSegmenBarVC *vc = [[ZBNSegmenBarVC alloc] init];
        [self addChildViewController:vc];
        _segmentBarVC = vc;
    }
    return _segmentBarVC;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.navigationItem.title = @"商城订单";
    [self setupSegmen];
}

- (void)setupSegmen
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.segmentBarVC.segmentBar.frame = CGRectMake(0,0, self.view.width, 50);
    self.segmentBarVC.view.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    [self.view addSubview:self.segmentBarVC.view];
    //添加控制器
    NSArray *items = @[@"全部订单", @"待付款",@"待发货",@"待收货",@"待评价"];

    ZBNShoppingHallAllOrderVC *vc1 = [[ZBNShoppingHallAllOrderVC alloc] init];
        
    ZBNShoppingHallWaitPaymentOrderVC *vc2 = [[ZBNShoppingHallWaitPaymentOrderVC alloc] init];
        
    ZBNSHDeliverGoodsOrderVC *vc4 = [[ZBNSHDeliverGoodsOrderVC alloc] init];
    
    ZBNSHWaitReceivingGoodsOrderVC *vc3 = [[ZBNSHWaitReceivingGoodsOrderVC alloc] init];
    
    ZBNSHWaitEvaluateOrderVC *vc5 = [[ZBNSHWaitEvaluateOrderVC alloc] init];
    
        [self.segmentBarVC setUpWithItems:items childVCs:@[vc1, vc2, vc4, vc3, vc5]];
        //设置样式
        [self.segmentBarVC.segmentBar updateWithConfig:^(ZBNSegmenBarConfig *config) {
            config.itemNColor([UIColor blackColor]).itemSColor([UIColor colorWithRed:50/255.0 green:193/255.0 blue:164/255.0 alpha:1]).itemF([UIFont systemFontOfSize:13]).itemBColor([UIColor whiteColor]).indicatorH(0);
            config.indicatorExtraW = 0;
        }];

        //少量标签需要均分的情形
        self.segmentBarVC.segmentBar.isDivideEqually = YES;
}

@end
