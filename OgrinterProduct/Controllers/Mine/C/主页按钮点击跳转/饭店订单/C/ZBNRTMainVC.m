//
//  ZBNRTMainVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/16.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNRTMainVC.h"

#import "ZBNRTWaitPayVC.h" // 待支付
#import "ZBNRTAllVC.h" // 全部
#import "ZBNRTWaitComVC.h" // 待评价
#import "ZBNRTWaitUseVC.h" // 待使用
#import "ZBNSegmenBarVC.h"


@interface ZBNRTMainVC ()
/*! 选项卡控制器 */
@property (nonatomic, strong) ZBNSegmenBarVC *segmentBarVC;
@end

@implementation ZBNRTMainVC

#pragma mark -- life

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置UI
    [self setupUI];
    // 设置选项卡视图
     [self setupSegmen];
    
   
    
}


#pragma mark -- UI

- (void)setupUI
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.navigationItem.title = @"饭店预约";
}

- (void)setupSegmen
{
    self.segmentBarVC.segmentBar.frame = CGRectMake(0,0, self.view.width, 50);
    self.segmentBarVC.view.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    [self.view addSubview:self.segmentBarVC.view];
    //添加控制器
    NSArray *items = @[@"全部订单", @"待支付",@"待使用",@"待评价"];

    ZBNRTAllVC *vc1 = [[ZBNRTAllVC alloc] init];
        
    ZBNRTWaitPayVC *vc2 = [[ZBNRTWaitPayVC alloc] init];
        
    ZBNRTWaitUseVC *vc3 = [[ZBNRTWaitUseVC alloc] init];
    
    ZBNRTWaitComVC *vc4 = [[ZBNRTWaitComVC alloc] init];
    
        [self.segmentBarVC setUpWithItems:items childVCs:@[vc1, vc2, vc3, vc4]];
        //设置样式
        [self.segmentBarVC.segmentBar updateWithConfig:^(ZBNSegmenBarConfig *config) {
            config.itemNColor([UIColor blackColor]).itemSColor([UIColor colorWithRed:50/255.0 green:193/255.0 blue:164/255.0 alpha:1]).itemF([UIFont systemFontOfSize:13]).itemBColor([UIColor whiteColor]).indicatorH(0);
            config.indicatorExtraW = 0;
        }];

        //少量标签需要均分的情形
        self.segmentBarVC.segmentBar.isDivideEqually = YES;

}


#pragma mark -- lazy

- (ZBNSegmenBarVC *)segmentBarVC {
    if (!_segmentBarVC) {
        ZBNSegmenBarVC *vc = [[ZBNSegmenBarVC alloc] init];
        [self addChildViewController:vc];
        _segmentBarVC = vc;
    }
    return _segmentBarVC;
}

@end
