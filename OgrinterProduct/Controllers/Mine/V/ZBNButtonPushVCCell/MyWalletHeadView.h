//
//  MyWalletHeadView.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/6.
//  Copyright © 2019 RXF. All rights reserved.
//  我的钱包控制器

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyWalletHeadView : UIView

@property (nonatomic, copy) void(^rechargeBtnClickTask)(void);

@property (nonatomic, copy) void(^consumptionDetailClick)(void);

@end

NS_ASSUME_NONNULL_END
