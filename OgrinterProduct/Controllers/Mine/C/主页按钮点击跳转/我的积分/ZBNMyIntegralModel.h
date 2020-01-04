//
//  ZBNMyIntegralModel.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/30.
//  Copyright © 2019 RXF. All rights reserved.
//  我的积分模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNMyIntegralModel : NSObject

/*! 上级id */
@property (nonatomic, copy) NSString *superior_id;
/*! 流动金额 */
@property (nonatomic, copy) NSString *price;
/*! 流动描述 */
@property (nonatomic, copy) NSString *describe;
/*! 流动时间 */
@property (nonatomic, copy) NSString *create_time;
/*! 消费/获得 */
@property (nonatomic, copy) NSString *state;
/*! 总积分 */
@property (nonatomic, copy) NSString *integral;

@end

NS_ASSUME_NONNULL_END
