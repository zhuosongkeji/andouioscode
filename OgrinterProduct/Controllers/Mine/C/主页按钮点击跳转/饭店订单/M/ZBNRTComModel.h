//
//  ZBNRTComModel.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/16.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ZBNRTTypeWaitPay = 10,
    ZBNRTTypePayes = 20,
    ZBNRTTypeWaitCom = 30,
    ZBNRTTypeComed = 40
} ZBNRTType;


@interface ZBNRTComModel : NSObject

/*! cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/*! 饭店名称 */
@property (nonatomic, copy) NSString *name;
/*! 商家logo图 */
@property (nonatomic, copy) NSString *logo_img;
/*! 订单总金额 */
@property (nonatomic, copy) NSString *prices;
/*! 商户id */
@property (nonatomic, copy) NSString *merchant_id;
/*! 订单id */
@property (nonatomic, copy) NSString *ID;
/*! 订单编号 */
@property (nonatomic, copy) NSString *order_sn;
/*! 用餐人数 */
@property (nonatomic, copy) NSString *people;
/*! 用餐时间 */
@property (nonatomic, copy) NSString *dinnertime;
/*! 备注 */
@property (nonatomic, copy) NSString *remark;
/*! 订单状态 (10未支付，20已支付,30已使用,待评价,40已评价) */
@property (nonatomic, copy) NSString *status;
/*! 菜 */
@property (nonatomic, strong) NSMutableArray *foods;

@property (nonatomic, assign) ZBNRTType type;

@end

NS_ASSUME_NONNULL_END
