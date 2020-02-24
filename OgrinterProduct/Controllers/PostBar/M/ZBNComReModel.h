//
//  ZBNComReModel.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/20.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBNPostUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZBNComReModel : NSObject
/** 视频的id */
@property (nonatomic , copy) NSString *mediabase_id;

/** 回复哪个用户的模型 */
@property (nonatomic , strong) ZBNPostUserModel *user;

/** 要回复的id */
@property (nonatomic , copy) NSString *commentReplyId;

/** 话题内容 */
@property (nonatomic, copy) NSString *text;

/** 是否是回复 */
@property (nonatomic, assign , getter = isReply) BOOL reply;
@end

NS_ASSUME_NONNULL_END
