//
//  ZBNRechargeCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/16.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZBNWalletRechargeModel;
@interface ZBNRechargeCell : UITableViewCell

/*! 余额的金额 */
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
/*! 快速创建cell */
+ (instancetype)registerCellForTableView:(UITableView *)tableView;

@property (nonatomic, copy) void(^modeBlock)(NSString *mode);
@property (nonatomic, copy) void(^rechargeNumberBlock)(NSString *rechargeNumber);
@property (nonatomic, copy) void(^contactNumberBlock)(NSString *contactNumber);



@end

NS_ASSUME_NONNULL_END
