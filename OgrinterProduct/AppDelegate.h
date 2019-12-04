//
//  AppDelegate.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/27.
//  Copyright © 2019 RXF. All rights reserved.
//


// 外卖 和直播 板块不用 信息和 贴吧， 暂时不做

// 首页 商家 我的 我的个人中心 只有酒店订单 商城订单 我的钱包 我的地址  购物车 商家入驻，钱包 重点开发

#import <UIKit/UIKit.h>
#import "CustomBarViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CustomBarViewController *customBar;

@end

