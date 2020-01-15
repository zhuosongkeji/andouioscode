//
//  ZBNSHComViewLogisticsModel.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/10.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ZBNSHDetailLogisticsModel;
@interface ZBNSHComViewLogisticsModel : NSObject

/*! 快递名称 */
@property (nonatomic, copy) NSString *name;
/*! 快递单号 */
@property (nonatomic, copy) NSString *courier_num;

/*! 存放详细物流信息的数组 */
@property (nonatomic, strong) NSMutableArray < ZBNSHDetailLogisticsModel *>*data;

@end

NS_ASSUME_NONNULL_END
