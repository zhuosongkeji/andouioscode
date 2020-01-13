//
//  ZBNSHOrderUserInfoM.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/4.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNSHOrderUserInfoM : NSObject

/*! 收货人 */
@property (nonatomic, copy) NSString *name;
/*! 收货详细地址 */
@property (nonatomic, copy) NSString *address;
/*! 收货人电话 */
@property (nonatomic, copy) NSString *mobile;
/*! 省 */
@property (nonatomic, copy) NSString *province;
/*! 市 */
@property (nonatomic, copy) NSString *city;
/*! 区 */
@property (nonatomic, copy) NSString *area;

@end

NS_ASSUME_NONNULL_END
