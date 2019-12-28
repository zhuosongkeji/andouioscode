//
//  ZBNMineFeedbackVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/28.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMineFeedbackVC.h"

#import "ZBNEntryFooterView.h"

@interface ZBNMineFeedbackVC ()

@property (nonatomic, weak) ZBNEntryFooterView *footerV;

@end

@implementation ZBNMineFeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"意见反馈";
    // 设置底部按钮
    [self setupFooterView];
}


- (void)setupFooterView
{
    ZBNEntryFooterView *footerV = [ZBNEntryFooterView viewFromXib];
    footerV.height = 150;
    footerV.width = self.view.width;
    footerV.x = 0;
    footerV.y = KSCREEN_HEIGHT * 0.9;
    [self.view addSubview:footerV];
    self.footerV = footerV;
    
}


@end
