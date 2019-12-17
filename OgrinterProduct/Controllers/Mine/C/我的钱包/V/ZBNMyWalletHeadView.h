//
//  ZBNMyWalletHeadView.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNMyWalletHeadView : UIView
/*! 点击余额提现按钮的回调 */
@property (nonatomic, copy) void(^cashWithDrawalBtnClickTask)(void);
/*! 点击余额充值的回调 */
@property (nonatomic, copy) void (^reChargeBtnClickTask)(NSString *money);

@end

NS_ASSUME_NONNULL_END
