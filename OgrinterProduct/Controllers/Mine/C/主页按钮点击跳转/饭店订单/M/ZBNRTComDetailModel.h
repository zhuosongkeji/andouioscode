//
//  ZBNRTComDetailModel.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/16.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNRTComDetailModel : NSObject
/*! 饭店名称 */
@property (nonatomic, copy) NSString *name; //
/*! 商家logo图 */
@property (nonatomic, copy) NSString *logo_img; //
/*! 订单总金额 */
@property (nonatomic, copy) NSString *prices; //
/*! 商户id */
@property (nonatomic, copy) NSString *merchant_id;
/*! 订单id */
@property (nonatomic, copy) NSString *ID; //
/*! 订单编号 */
@property (nonatomic, copy) NSString *order_sn; //
/*! 用餐人数 */
@property (nonatomic, copy) NSString *people; //
/*! 积分 */
@property (nonatomic, copy) NSString *integral; //
/*! 下单时间 */
@property (nonatomic, copy) NSString *orderingtime; //
/*! 到店时间 */
@property (nonatomic, copy) NSString *dinnertime; // method
/*! 支付方式 */
@property (nonatomic, copy) NSString *method; //
/*! 备注 */
@property (nonatomic, copy) NSString *remark; // pay_money
/*! 支付总金额 */
@property (nonatomic, copy) NSString *pay_money; //
/*! 菜 */
@property (nonatomic, strong) NSMutableArray *foods;
/*! 订单状态 */
@property (nonatomic, copy) NSString *status;
/*! 详细地址 */
@property (nonatomic, copy) NSString *address;
/*! 商铺电话 tel*/
@property (nonatomic, copy) NSString *tel;

@end

NS_ASSUME_NONNULL_END
