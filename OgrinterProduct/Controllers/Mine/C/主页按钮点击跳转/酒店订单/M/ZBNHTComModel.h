//
//  ZBNHTComModel.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/11.
//  Copyright © 2020 RXF. All rights reserved.
//  酒店订单通用模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    /*! 已取消 */
    ZBNHTComTypeCancel = 0,
    /*! 未支付 */
    ZBNHTComTypeNotPay = 10,
    /*! 待入住 */
    ZBNHTComTypeWaitIn = 20,
    /*! 已入住 */
    ZBNHTComTypeHadIn = 30,
    /*! 待评价 */
    ZBNHTComTypeWaitEvaluate = 40,
    /*! 已评价 */
    ZBNHTComTypeEvaluated = 50,
    
} ZBNHTComType;


@interface ZBNHTComModel : NSObject

@property (nonatomic, assign) ZBNHTComType type;

/*! 订单状态（0-取消订单 10-未支付订单 20-已支付(待入住) 30 已入住 40-已完成(离店) 50-已评价） */
@property (nonatomic, copy) NSString *status;
/*! 商户id */
@property (nonatomic, copy) NSString *merchants_id;
/*! 房间id */
@property (nonatomic, copy) NSString *hotel_room_id;
/*! 订单编号 */
@property (nonatomic, copy) NSString *book_sn;
/*! 商家logo图 */
@property (nonatomic, copy) NSString *logo_img;
/*! 商家名称 */
@property (nonatomic, copy) NSString *merchants_name;
/*! 房间图片 */
@property (nonatomic, copy) NSString *img;
/*! 房间名称 */
@property (nonatomic, copy) NSString *house_name;
/*! 房间价格 */
@property (nonatomic, copy) NSString *price;

@end

NS_ASSUME_NONNULL_END
