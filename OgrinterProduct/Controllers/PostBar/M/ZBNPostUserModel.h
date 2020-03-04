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
//@property (nonatomic , copy) NSString *userId;
@property (nonatomic , copy) NSNumber *ID;

/** 用户昵称 */
//@property (nonatomic , copy) NSString *nickname;
@property (nonatomic , copy) NSString *name;

/** 头像地址 */
//@property (nonatomic , copy) NSString *avatarUrl;
@property (nonatomic , copy) NSString *avator;
@end

NS_ASSUME_NONNULL_END
