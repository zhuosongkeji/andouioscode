//
//  ZBNPostBarVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/17.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNPostBarVC.h"
#import "ZBNSegmenBarVC.h"
#import "ZBNSquareVC.h"
#import "ZBNPostMineVC.h"
#import "ZBNNewPostVC.h"

@interface ZBNPostBarVC ()
/*! 选项卡控制器 */
@property (nonatomic, strong) ZBNSegmenBarVC *segmentBarVC;
@end

@implementation ZBNPostBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupSegmen];
}

- (void)setupNav
{
    UIBarButtonItem *addItem = [UIBarButtonItem itemWithImage:@"+" highImage:@"+" target:self action:@selector(addItemClick)];
    self.navigationItem.rightBarButtonItem = addItem;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)addItemClick
{
    ZBNNewPostVC *vc = [[ZBNNewPostVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setupSegmen
{
    self.segmentBarVC.view.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    [self.view addSubview:self.segmentBarVC.view];
    NSArray *items = @[@"广场",@"我的"];
    ZBNSquareVC *vc1 = [[ZBNSquareVC alloc] init];
    ZBNPostMineVC *vc2 = [[ZBNPostMineVC alloc] init];
    [self.segmentBarVC setUpWithItems:items childVCs:@[vc1,vc2]];
    [self.segmentBarVC.segmentBar updateWithConfig:^(ZBNSegmenBarConfig * _Nonnull config) {
        config.itemNColor([UIColor whiteColor]).itemSColor([UIColor whiteColor]).indicatorH(1).indictColor([UIColor whiteColor]);
        config.indicatorExtraW = 20;
    }];
    
    self.segmentBarVC.segmentBar.isDivideEqually = YES;
    self.segmentBarVC.segmentBar.frame = CGRectMake(0, 0, 160, 40);
    self.navigationItem.titleView = self.segmentBarVC.segmentBar;
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
