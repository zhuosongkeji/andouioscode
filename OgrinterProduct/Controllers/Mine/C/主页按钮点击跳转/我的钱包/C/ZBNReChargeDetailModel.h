//
//  ZBNReChargeDetailModel.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/9.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNReChargeDetailModel : NSObject
/*! 上级ID */
@property (nonatomic, copy) NSString *superior_id;
/*! 流动金额 */
@property (nonatomic, copy) NSString *price;
/*! 流动描述 */
@property (nonatomic, copy) NSString *describe;
/*! 流动时间 */
@property (nonatomic, copy) NSString *create_time;
/*! state "1获得 2消费" */
@property (nonatomic, copy) NSString *state;
@end

NS_ASSUME_NONNULL_END
