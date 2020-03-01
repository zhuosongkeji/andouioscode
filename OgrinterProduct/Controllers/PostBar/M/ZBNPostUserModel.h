//
//  ZBNPostUserModel.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/20.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNPostUserModel : NSObject
/** userId */
@property (nonatomic , copy) NSString *userId;

/** 用户昵称 */
@property (nonatomic , copy) NSString *nickname;

/** 头像地址 */
@property (nonatomic , copy) NSString *avatarUrl;

@end

NS_ASSUME_NONNULL_END
