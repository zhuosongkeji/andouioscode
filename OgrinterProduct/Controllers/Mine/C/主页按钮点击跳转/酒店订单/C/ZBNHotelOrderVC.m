//
//  ZBNHotelOrderVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/12.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNHotelOrderVC.h"
#import "ZBNHotelAllOrderVC.h"
#import "ZBNHotelCancelOrderVC.h"
#import "ZBNHotelWaitEvaluateOrderVC.h"
#import "ZBNSegmenBarVC.h"
#import "ZBNStayInOrderVC.h"

@interface ZBNHotelOrderVC ()

/*! 选择卡 */
@property (nonatomic, strong) ZBNSegmenBarVC *segmentBarVC;


@end

@implementation ZBNHotelOrderVC

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
    self.navigationItem.title = @"酒店预约";
    [self setupSegmen];
}

- (void)setupSegmen
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.segmentBarVC.segmentBar.frame = CGRectMake(0,getRectNavAndStatusHight, self.view.width, 50);
    self.segmentBarVC.view.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    [self.view addSubview:self.segmentBarVC.view];
    //添加控制器
    NSArray *items = @[@"全部订单",@"待入住", @"待评价",@"已取消"];

    ZBNHotelAllOrderVC *vc1 = [[ZBNHotelAllOrderVC alloc] init];
        
    ZBNStayInOrderVC *stayInVc = [[ZBNStayInOrderVC alloc] init];
    
    ZBNHotelWaitEvaluateOrderVC *vc2 = [[ZBNHotelWaitEvaluateOrderVC alloc] init];
        
    ZBNHotelCancelOrderVC *vc3 = [[ZBNHotelCancelOrderVC alloc] init];
    
    
        [self.segmentBarVC setUpWithItems:items childVCs:@[vc1,stayInVc, vc2, vc3]];
        //设置样式
        [self.segmentBarVC.segmentBar updateWithConfig:^(ZBNSegmenBarConfig *config) {
            config.itemNColor([UIColor blackColor]).itemSColor([UIColor colorWithRed:50/255.0 green:193/255.0 blue:164/255.0 alpha:1]).itemF([UIFont systemFontOfSize:13]).itemBColor([UIColor whiteColor]).indicatorH(0);
            config.indicatorExtraW = 0;
        }];

        //少量标签需要均分的情形
        self.segmentBarVC.segmentBar.isDivideEqually = YES;
}

@end
