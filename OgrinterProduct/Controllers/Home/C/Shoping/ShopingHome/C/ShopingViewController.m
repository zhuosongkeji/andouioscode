//
//  ShopingViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/5.
//  Copyright © 2019 RXF. All rights reserved.
//


#import "ShopingViewController.h"
#import "ShopingHomeViewController.h"
#import "ShopingCategoryViewController.h"
#import "ShoingMsgViewController.h"
#import "ShoingMineViewController.h"

#import "ZJScrollPageView.h"


@interface ShopingViewController ()<ZJScrollPageViewDelegate>

@property(weak, nonatomic)ZJScrollPageView *scrollPageView;

@property(strong, nonatomic)NSArray<NSString *> *titles;

@property(strong, nonatomic)NSArray<UIViewController<ZJScrollPageViewChildVcDelegate> *> *childVcs;

@end

@implementation ShopingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createScroll];
    // Do any additional setup after loading the view from its nib.
}


-(void)createScroll{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    
    style.showLine = NO;
    /// 设置滚动条高度
    style.segmentHeight = kStatusBarAndNavigationBarH;
    /// 显示图片 (在显示图片的时候只有下划线的效果可以开启, 其他的'遮盖','渐变',效果会被内部关闭)
    style.showImage = YES;
    /// 平分宽度
    //    style.scrollTitle = NO;
    
    style.imagePosition = TitleImagePositionTop;
    style.autoAdjustTitlesWidth = YES;
    
    CGRect scrollPageViewFrame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - kStatusBarAndNavigationBarH);
    
    self.titles = @[@"商城",
                    @"分类",
                    @"收藏",
                    @"消息"];
    
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:scrollPageViewFrame segmentStyle:style titles:_titles parentViewController:self delegate:self];
    
    self.scrollPageView = scrollPageView;
    
    __weak typeof(self) weakSelf = self;
    self.scrollPageView.extraBtnOnClick = ^(UIButton *extraBtn){
        weakSelf.title = @"点击了extraBtn";
        NSLog(@"点击了extraBtn");
        
    };
    
    [self.view addSubview:self.scrollPageView];
    
    
}


//MARK:- numberOfChildViewControllers
- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}

/// 设置图片
- (void)setUpTitleView:(ZJTitleView *)titleView forIndex:(NSInteger)index {
    titleView.normalImage = [UIImage imageNamed:[NSString stringWithFormat:@"normal_%ld", index+1]];
    titleView.selectedImage = [UIImage imageNamed:@"selected"];
}


- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    
    if (index == 0) {
        
        ShopingHomeViewController *childVc = (ShopingHomeViewController *)reuseViewController;
        if (childVc == nil) {
            childVc = [[ShopingHomeViewController alloc] init];
            childVc.view.backgroundColor = [UIColor blueColor];
        }
        
        return childVc;
        
    } else if (index == 1) {
        ShopingCategoryViewController *childVc = (ShopingCategoryViewController *)reuseViewController;
        if (childVc == nil) {
            childVc = [[ShopingCategoryViewController alloc] init];
        }
        
        return childVc;
        
    } else if (index == 2){
        ShoingMsgViewController *childVc = (ShoingMsgViewController *)reuseViewController;
        if (childVc == nil) {
            childVc = [[ShoingMsgViewController alloc] init];
        }
        
        return childVc;
        
    } else {
        ShoingMineViewController *childVc = (ShoingMineViewController *)reuseViewController;
        if (childVc == nil) {
            childVc = [[ShoingMineViewController alloc] init];
        }
        
        return childVc;
    }
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
