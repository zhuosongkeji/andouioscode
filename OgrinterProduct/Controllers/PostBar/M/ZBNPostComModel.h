//
//  ZBNPostComModel.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/17.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBNPostUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZBNPostComModel : NSObject

/** 视频的id */
@property (nonatomic , copy) NSString *mediabase_id;

/** 评论、回复id */
@property (nonatomic , copy) NSString * commentId;

/** 创建时间 */
@property (nonatomic , copy) NSString *creatTime;

/** 回复用户模型 */
@property (nonatomic , strong) ZBNPostUserModel *toUser;

/** 来源用户模型 */
@property (nonatomic , strong) ZBNPostUserModel *fromUser;

/** 话题内容 */
@property (nonatomic, copy) NSString *text;

/** 获取富文本 */
- (NSAttributedString *)attributedText;

@end

NS_ASSUME_NONNULL_END
