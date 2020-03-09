//
//  ZBNMyAddressModel.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/14.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNMyAddressModel : NSObject

/*! 省地址id */
@property (nonatomic, assign) NSString *province_id;
/*! 地址id */
@property (nonatomic, copy) NSString *ID;
/*! 收货人名字 */
@property (nonatomic, copy) NSString *name;
/*! 收货人电话 */
@property (nonatomic, copy) NSString *mobile;
/*!是否默认*/
@property (nonatomic, assign) BOOL is_defualt;
/*! city_id */
@property (nonatomic, assign) NSString *city_id;
/*! 区地址id */
@property (nonatomic, assign) NSString *area_id;
/*! 详细地址 */
@property (nonatomic, copy) NSString *address;
/*! city */
@property (nonatomic, copy) NSString *city;
/*! 区地址 */
@property (nonatomic, copy) NSString *area;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, assign) CGFloat cellHeight;

@end

NS_ASSUME_NONNULL_END
