//
//  ZBNSHCommonPayVC.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/9.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNSHCommonPayVC : UIViewController
/*! 订单号 */
@property (nonatomic, copy) NSString *order_id;
/*! 子订单ID */
@property (nonatomic, copy) NSString *did;

@end

NS_ASSUME_NONNULL_END
