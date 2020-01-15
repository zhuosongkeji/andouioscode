//
//  ZBNSHDetailLogisticsModel.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/10.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNSHDetailLogisticsModel : NSObject

/*! 时间 */
@property (nonatomic, copy) NSString *time;
/*! 内容 */
@property (nonatomic, copy) NSString *context;
/*! cell的高度 */
@property (nonatomic, assign) CGFloat height;
/*! 是否为最后一条 */
@property (nonatomic, assign, getter=is_firstOne) BOOL firstOne;

@end

NS_ASSUME_NONNULL_END
