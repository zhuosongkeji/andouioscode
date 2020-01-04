//
//  ZBNSHOrderDetailsM.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/4.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNSHOrderDetailsM : NSObject
/*! 商品图片 */
@property (nonatomic, copy) NSString *img;
/*! 名字 */
@property (nonatomic, copy) NSString *name;
/*! 购买数量 */
@property (nonatomic, copy) NSString *num;
/*! 单商品邮费 */
@property (nonatomic, copy) NSString *shipping_free;
/*! 单价 */
@property (nonatomic, copy) NSString *price;
/*! 规格 */
@property (nonatomic, copy) NSArray *attr_value;
@end

NS_ASSUME_NONNULL_END
