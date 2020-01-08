//
//  ZBNShoppingCartModel.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/13.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNShoppingCartModel : NSObject


/*! 是否被选中 */
@property (nonatomic, assign, getter=isSelected) BOOL selected;

/*! 购物车id */
@property (nonatomic, copy) NSString *ID;
/*! 商品ID */
@property (nonatomic, copy) NSString *goods_id;
/*! 商品规格 */
@property (nonatomic, copy) NSString *goods_sku_id;
/*! 购买数量 */
@property (nonatomic, copy) NSString *num;
/*! 商品名字 */
@property (nonatomic, copy) NSString *goods_name;
/*! 商品图片 */
@property (nonatomic, copy) NSString *img;
/*! 价格 */
@property (nonatomic, copy) NSString *price;
/*! 商家名字 */
@property (nonatomic, copy) NSString *merchant_name;
/*! 商家图片 */
@property (nonatomic, copy) NSString *logo_img;


@end

NS_ASSUME_NONNULL_END
