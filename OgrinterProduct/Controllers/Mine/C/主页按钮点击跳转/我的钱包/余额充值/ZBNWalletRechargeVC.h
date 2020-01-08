//
//  ZBNWalletRechargeVC.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/16.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNWalletRechargeVC : UITableViewController

@property (nonatomic, copy) void(^moneyLabelText)(NSString *moneyText);

@property (nonatomic, copy) NSString *moneyText;

@end

NS_ASSUME_NONNULL_END
