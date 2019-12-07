//
//  MerchantEntryVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/7.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "MerchantEntryVC.h"
#import "ZBNTitleButton.h"

#import "ApplyBeBookingMerchant.h"
#import "ApplyBeTakeOutMerchantVC.h"

@interface MerchantEntryVC () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) UIView *titlesView;

@property (nonatomic, weak) UIView *titlesBottomView;

@property (nonatomic, strong) NSMutableArray *titlesBtns;

@property (nonatomic, weak) ZBNTitleButton *selectedTitleBtn;

@end

@implementation MerchantEntryVC

- (NSArray *)titlesBtns
{
    if (!_titlesBtns) {
        _titlesBtns = [NSMutableArray array];
    }
    return _titlesBtns;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // nav
    [self setupNav];
    // setupAllChildVc
    [self setupAllChildVc];
    // setupScrollView
    [self setupScrollView];
    // setupTitlesView
    [self setupTitlesView];
}

- (void)setupNav
{
    self.navigationItem.title = @"商家入驻";
}

- (void)setupTitlesView
{
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    titlesView.frame = CGRectMake(0, kStatusBarAndNavigationBarH, self.view.width, 35);
    [self.view addSubview:titlesView];
    // 内部标签按钮
    NSInteger count = self.childViewControllers.count;
    CGFloat titleBtnH = titlesView.height;
    CGFloat titleBtnW = titlesView.width / count;
    for (int i = 0; i < count; i++) {
        // 创建
        ZBNTitleButton *btn = [ZBNTitleButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:btn];
        [self.titlesBtns addObject:btn];
        // 文字
        NSString *title = [self.childViewControllers[i] title];
        [btn setTitle:title forState:UIControlStateNormal];
        // frame
        btn.y = 0;
        btn.height = titleBtnH;
        btn.width = titleBtnW;
        btn.x = i * titleBtnW;
      
    }
    // 标签栏底部的指示器控件
    UIView *titleBottomView = [[UIView alloc] init];
    titleBottomView.backgroundColor = [self.titlesBtns.lastObject titleColorForState:UIControlStateSelected];
    titleBottomView.height = 1;
    titleBottomView.y = titlesView.height - titleBottomView.height;
    [titlesView addSubview:titleBottomView];
    self.titlesBottomView = titleBottomView;
          // 默认点击最前面的按钮
          ZBNTitleButton *firstTitleButton = self.titlesBtns.firstObject;
          [firstTitleButton.titleLabel sizeToFit];
          titleBottomView.width = firstTitleButton.titleLabel.width;
          titleBottomView.centerX = firstTitleButton.centerX;
          [self titleBtnClick:firstTitleButton];
}

- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];

    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    // 默认显示第0个控制器
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)titleBtnClick:(ZBNTitleButton *)titleButton
{
    // 控制按钮的状态
    self.selectedTitleBtn.selected = NO;
    titleButton.selected = YES;
    self.selectedTitleBtn = titleButton;
    // 底部控件的位置和尺寸
    [UIView animateWithDuration:0.25 animations:^{
        self.titlesBottomView.width = titleButton.titleLabel.width;
        self.titlesBottomView.centerX = titleButton.centerX;
    }];
    // 让scrollView滚动到对应的位置
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = self.view.width * [self.titlesBtns indexOfObject:titleButton];
    [self.scrollView setContentOffset:offset animated:YES];
}

- (void)setupAllChildVc
{
    ApplyBeTakeOutMerchantVC *takeOutVc = [[ApplyBeTakeOutMerchantVC alloc] init];
    takeOutVc.title = @"申请成为外卖商家";
    [self addChildViewController:takeOutVc];
    
    ApplyBeBookingMerchant *bookingVc = [[ApplyBeBookingMerchant alloc] init];
    bookingVc.title = @"申请成为预订商家";
    [self addChildViewController:bookingVc];
}


#pragma mark - <UIScrollViewDelegate>
/**
 * 当滚动动画完毕的时候调用（通过代码setContentOffset:animated:让scrollView滚动完毕后，就会调用这个方法）
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 取出对应的子控制器
    int index = scrollView.contentOffset.x / scrollView.width;
    UIViewController *willShowChildVc = self.childViewControllers[index];
    if (willShowChildVc.isViewLoaded) return;
    
    // 添加子控制器的view到scrollView身上
    willShowChildVc.view.frame = scrollView.bounds;
    [scrollView addSubview:willShowChildVc.view];
    
}

/**
 * 当减速完毕的时候调用（人为拖拽scrollView，手松开后scrollView慢慢减速完毕到静止）
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    int index = scrollView.contentOffset.x / scrollView.width;
    [self titleBtnClick:self.titlesBtns[index]];
}


@end
