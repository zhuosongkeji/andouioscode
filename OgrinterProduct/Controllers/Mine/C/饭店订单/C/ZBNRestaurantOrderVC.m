//
//  ZBNRestaurantOrderVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/12.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNRestaurantOrderVC.h"
#import "ZBNSegmenBarVC.h"
#import "ZBNRestaurantCancelVC.h"
#import "ZBNRestaurantAllOrderVC.h"
#import "ZBNRestaurantBookOrderVC.h"
#import "ZBNRestaurantWaitEvaluateVC.h"

@interface ZBNRestaurantOrderVC ()

/*! 选择卡 */
@property (nonatomic, strong) ZBNSegmenBarVC *segmentBarVC;


@end

@implementation ZBNRestaurantOrderVC

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
    
    self.navigationItem.title = @"饭店订单";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSegmen];
}


- (void)setupSegmen
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.segmentBarVC.segmentBar.frame = CGRectMake(0,0 , self.view.width, 50);
    self.segmentBarVC.view.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    [self.view addSubview:self.segmentBarVC.view];
    //添加控制器
    NSArray *items = @[@"全部订单", @"我的预订",@"待评价",@"已取消"];

    ZBNRestaurantAllOrderVC *vc1 = [[ZBNRestaurantAllOrderVC alloc] init];
        
    ZBNRestaurantBookOrderVC *vc2 = [[ZBNRestaurantBookOrderVC alloc] init];
        
    ZBNRestaurantWaitEvaluateVC *vc3 = [[ZBNRestaurantWaitEvaluateVC alloc] init];
    
    ZBNRestaurantCancelVC *vc4 = [[ZBNRestaurantCancelVC alloc] init];
    
        [self.segmentBarVC setUpWithItems:items childVCs:@[vc1, vc2, vc3, vc4]];
        //设置样式
        [self.segmentBarVC.segmentBar updateWithConfig:^(ZBNSegmenBarConfig *config) {
            config.itemNColor([UIColor blackColor]).itemSColor([UIColor colorWithRed:50/255.0 green:193/255.0 blue:164/255.0 alpha:1]).itemF([UIFont systemFontOfSize:16]).itemBColor([UIColor whiteColor]).indicatorH(0);
            config.indicatorExtraW = 0;
        }];

        //少量标签需要均分的情形
        self.segmentBarVC.segmentBar.isDivideEqually = YES;
    
}


@end
