//
//  ZBNVIPRechargeCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/16.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNVIPRechargeCell : UITableViewCell
@property (nonatomic, copy) void(^payBtnClickTask)(NSString *pay_id);
@end

NS_ASSUME_NONNULL_END
