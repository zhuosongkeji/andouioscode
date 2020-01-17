//
//  ZBNRTFoodsModel.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/16.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNRTFoodsModel : NSObject

/*! 菜品id */
@property (nonatomic, copy) NSString *ID;
/*! 菜品名称 */
@property (nonatomic, copy) NSString *name;
/*! 菜品价格 */
@property (nonatomic, copy) NSString *price;
/*! 数量 */
@property (nonatomic, copy) NSString *num;
/*! 图片 */
@property (nonatomic, copy) NSString *image;


@end

NS_ASSUME_NONNULL_END
