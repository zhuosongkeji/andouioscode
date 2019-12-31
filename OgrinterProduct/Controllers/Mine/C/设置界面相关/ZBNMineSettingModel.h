//
//  ZBNMineSettingModel.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/31.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNMineSettingModel : NSObject

/*! 头像 */
@property (nonatomic, copy) NSString *avator;
/*! 昵称 */
@property (nonatomic, copy) NSString *name;
/*! 电话 */
@property (nonatomic, copy) NSString *mobile;
/*! 密码 */
@property (nonatomic, copy) NSString *password;

@end

NS_ASSUME_NONNULL_END
