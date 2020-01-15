//
//  ZBNHTComDetailModel.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/14.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNHTComDetailModel : NSObject

/*! 订单编号 */
@property (nonatomic, copy) NSString *book_sn;
/*! 下单时间 */
@property (nonatomic, copy) NSString *created_at;
/*! 支付方式 */
@property (nonatomic, copy) NSString *pay_way;
/*! 房间id */
@property (nonatomic, copy) NSString *ID;
/*! 商户id */
@property (nonatomic, copy) NSString *merchant_id;
/*! 商户名字 */
@property (nonatomic, copy) NSString *merchants_name;
/*! 房间图片 */
@property (nonatomic, copy) NSString *img;
/*! 订单状态 */
@property (nonatomic, copy) NSString *status;
/*! 房间名字 */
@property (nonatomic, copy) NSString *house_name;
/*! 单价 */
@property (nonatomic, copy) NSString *price;
/*! 使用积分 */
@property (nonatomic, copy) NSString *integral;
/*! 订单总金额 */
@property (nonatomic, copy) NSString *money;
/*! 入住时间 */
@property (nonatomic, copy) NSString *start_time;
/*! 离开时间 */
@property (nonatomic, copy) NSString *end_time;
/*! 入住天数 */
@property (nonatomic, copy) NSString *day_num;
/*! 入住人 */
@property (nonatomic, copy) NSString *real_name;
/*! 联系电话 */
@property (nonatomic, copy) NSString *mobile;
/*! 支付金额 */
@property (nonatomic, copy) NSString *pay_money;

@end

NS_ASSUME_NONNULL_END
