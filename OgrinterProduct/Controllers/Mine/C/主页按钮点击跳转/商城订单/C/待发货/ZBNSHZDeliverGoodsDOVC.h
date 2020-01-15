//
//  ZBNSHZDeliverGoodsDOVC.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/4.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNSHZDeliverGoodsDOVC : UITableViewController
/*! 订单编号 */
@property (nonatomic, copy) NSString *order_num;
/*! 子订单的ID */
@property (nonatomic, copy) NSString *dID;
@end

NS_ASSUME_NONNULL_END
