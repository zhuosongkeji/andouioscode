//
//  ZBNSHOrderCanceledVC.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/3/6.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNSHOrderCanceledVC : UITableViewController
/*! 订单编号 */
@property (nonatomic, copy) NSString *getOrderNum;
/*! 子订单ID */
@property (nonatomic, copy) NSString *dID;

@end

NS_ASSUME_NONNULL_END
