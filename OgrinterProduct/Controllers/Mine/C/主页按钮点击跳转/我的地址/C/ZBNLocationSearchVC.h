//
//  ZBNLocationSearchVC.h
//  Gaode
//
//  Created by 周芳圆 on 2020/3/1.
//  Copyright © 2020 ZhouBunian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <MAMapKit/MAMapKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ZBNLocationSearchVC : UIViewController
/*! 点击cell选择地址的回调 */
@property (nonatomic, copy) void(^selectedAddressTask)(NSString *address, NSString *areaID, NSString *province);
@property (nonatomic, strong) AMapLocationManager *locationManager;
@end

NS_ASSUME_NONNULL_END
