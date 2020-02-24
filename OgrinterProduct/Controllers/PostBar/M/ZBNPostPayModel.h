//
//  ZBNPostPayModel.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/22.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNPostPayModel : NSObject

/*! 支付方式 */
@property (nonatomic, strong) NSMutableArray *payWays;
/*! 置顶天数 */
@property (nonatomic, strong) NSMutableArray *dingWays;

@end

NS_ASSUME_NONNULL_END
