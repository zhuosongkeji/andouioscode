//
//  ZBNSHOrderDetailComM.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/4.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBNSHOrderDetailsM.h"
#import "ZBNSHOrderUserInfoM.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZBNSHOrderDetailComM : NSObject

/*! 订单总金额 */
@property (nonatomic, copy) NSString *order_money;
/*! 订单id */
@property (nonatomic, copy) NSString *ID;
/*! 订单号 */
@property (nonatomic, copy) NSString *order_sn;
/*! 收货地址 */
@property (nonatomic, copy) NSString *address_id;
/*! 使用积分 */
@property (nonatomic, copy) NSString *integral;
/*! 支付金额 */
@property (nonatomic, copy) NSString *pay_money;
/*! 支付时间 */
@property (nonatomic, copy) NSString *pay_time;
/*! 订单状态 */
@property (nonatomic, copy) NSString *status;
/*! 购买商品数量 */
@property (nonatomic, copy) NSString *allnum;
/*! 商品总运费 */
@property (nonatomic, copy) NSString *shipping_free;

@property (nonatomic, strong) ZBNSHOrderDetailsM *details;
@property (nonatomic, strong) ZBNSHOrderUserInfoM *userinfo;

@end

NS_ASSUME_NONNULL_END
