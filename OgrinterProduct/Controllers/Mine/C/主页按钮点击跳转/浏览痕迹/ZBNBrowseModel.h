//
//  ZBNBrowseModel.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/12.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNBrowseModel : NSObject

/*! 商户id */
@property (nonatomic, copy) NSString *ID;
/*! 创建时间 */
@property (nonatomic, copy) NSString *created_at;
/*! 星级 */
@property (nonatomic, copy) NSString *stars_all;
/*! 点赞数量 */
@property (nonatomic, copy) NSString *praise_num;
/*! 商家图片 */
@property (nonatomic, copy) NSString *logo_img;
/*! 商家名字 */
@property (nonatomic, copy) NSString *name;
/*! 商家地址 */
@property (nonatomic, copy) NSString *address;
/*! 商家电话 */
@property (nonatomic, copy) NSString *tel;
/*! 商户类型id */
@property (nonatomic, copy) NSString *merchant_type_id;

@end

NS_ASSUME_NONNULL_END
