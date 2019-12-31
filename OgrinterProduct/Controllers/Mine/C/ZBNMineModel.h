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

/*! 用户名 */
@property (nonatomic, copy) NSString *name;
/*! 头像 */
@property (nonatomic, copy) NSString *avator;
/*! 会员等级 */
@property (nonatomic, copy) NSString *grade;

@end

NS_ASSUME_NONNULL_END
