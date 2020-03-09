//
//  ZBNSHCommonModel.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/3.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef enum : NSInteger {
    // 全部
    // 已取消
    ZBNCommonTypeCancel = 0,
    // 等待付款 / 未支付
    ZBNCommonTypeWaitPay = 10,
    // 待发货 / 已支付
    ZBNCommonTypePayed = 20,
    // 待收货 / 已发货
    ZBNCommonTypeShipped = 40,
    // 待评价 / 交易成功
    ZBNCommonTypeSuccess = 50,
    // 已评价
    ZBNCommonTypeCommented = 60,
    
} ZBNCommonType;

@interface ZBNSHCommonModel : NSObject


@property (nonatomic, assign) ZBNCommonType type;
/*! 商品图 */
@property (nonatomic, copy) NSString *img;
/*! 商品名字 */
@property (nonatomic, copy) NSString *name;
/*! 商品id */
@property (nonatomic, copy) NSString *goods_id;
/*! 商户id */
@property (nonatomic, copy) NSString *merchant_id;
/*! 订单号 */
@property (nonatomic, copy) NSString *order_id;
/*! 状态 0-已取消 10-未支付 20-已支付 40-已发货  50-交易成功（确认收货） 60-交易关闭（已评论） */
@property (nonatomic, copy) NSString *status;
/*! 商家名字 */
@property (nonatomic, copy) NSString *mname;
/*! 商家图 */
@property (nonatomic, copy) NSString *logo_img;
/*! 数量 */
@property (nonatomic, copy) NSString *num;
/*! 订单id */
@property (nonatomic, copy) NSString *ID;
/*! 快递公司id */
@property (nonatomic, copy) NSString *express_id;
/*! 快递单号 */
@property (nonatomic, copy) NSString *courier_num;
/*! 运费 */
@property (nonatomic, copy) NSString *shipping_free;
/*! 单价 */
@property (nonatomic, copy) NSString *price;
/*! 总价 */
@property (nonatomic, copy) NSString *pay_money;
/*! 商品subL */
@property (nonatomic, strong) NSArray *attr_value;

@end

NS_ASSUME_NONNULL_END
