//
//  MyWalletVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/6.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "MyWalletVC.h"

#import "MyWalletHeadView.h"


@interface MyWalletVC ()
/*! headView */
@property (nonatomic, weak) MyWalletHeadView *headView;
@property (nonatomic, weak) UIScrollView *contentView;

@end

@implementation MyWalletVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // 设置header
    
    [self setupContentScrollView];
    
    [self setupHeaderView];
    // 设置Block
    [self setupHeadBlock];
    
}

/*! 创建headView */
- (void)setupHeaderView
{
    // 创建
    MyWalletHeadView *headView = [MyWalletHeadView viewFromXib];
    CGFloat headX = 0;
    CGFloat headW = self.view.width;
    CGFloat headH = 220;
    CGFloat headY = kStatusBarAndNavigationBarH;
    headView.frame = CGRectMake(headX, headY, headW, headH);
    [self.view addSubview:headView];
    self.headView = headView;
}

- (void)setupContentScrollView
{
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
    contentView.pagingEnabled = YES;
    contentView.showsHorizontalScrollIndicator = NO;
    contentView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:contentView];
    self.contentView = contentView;
  
}

/*! 设置数据的回调 */
- (void)setupHeadBlock
{
    // 余额充值的回调
    self.headView.rechargeBtnClickTask = ^{
        NSLog(@"点击了余额充值按钮");
    };
    
}



@end
