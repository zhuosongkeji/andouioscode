//
//  OnlineBookingViewController.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/9.
//  Copyright © 2019 RXF. All rights reserved.
//

typedef enum : NSUInteger {
    OnlineBookingViewHotelPay = 0,//酒店预订
    OnlineBookingViewProductPay = 1,//产品预订
    OnlineBookingViewOrderPay = 2,//点餐预订
} OnlineBookingViewPayType;


#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface OnlineBookingViewController : BaseViewController

@property (nonatomic) OnlineBookingViewPayType payType;

@property (nonatomic,strong) NSString *order_sn;


@property(nonatomic,strong)NSString *fjid;

@end

NS_ASSUME_NONNULL_END
