//
//  ZBNMineModel.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/30.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNMineModel : NSObject


/*! 用户id */
@property (nonatomic, copy) NSString *ID;
/*! 用户名 */
@property (nonatomic, copy) NSString *name;
/*! 头像 */
@property (nonatomic, copy) NSString *avator;
/*! 会员等级 */
@property (nonatomic, copy) NSString *grade;
/*! 余额 */
@property (nonatomic, copy) NSString *money;
/*! 积分 */
@property (nonatomic, copy) NSString *integral;
/*! 收藏 */
@property (nonatomic, copy) NSString *collect;
/*! 关注 */
@property (nonatomic, copy) NSString *focus;
/*! 浏览记录 */
@property (nonatomic, copy) NSString *record;
/*! 判断会员 */
@property (nonatomic, copy) NSString *status;
/*! 商城订单数 */
@property (nonatomic, copy) NSString *goodordernum;
/*! 饭店订单数 */
@property (nonatomic, copy) NSString *foodsordernum;
/*! 酒店订单数 */
@property (nonatomic, copy) NSString *booksordernum;


@end

NS_ASSUME_NONNULL_END
