//
//  ZBNSquareModel.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/17.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBNPostUserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZBNSquareModel : NSObject

/** 话题idSquareId */
@property (nonatomic , strong) NSNumber *ID ;
/*! 用户 */
@property (nonatomic, strong) ZBNPostUserModel *userM;
/*! 用户ID */
@property (nonatomic, strong) NSNumber *user_id;
/*! 用户名 */
@property (nonatomic, copy) NSString *name;
/*! 用户头像 */
@property (nonatomic, copy) NSString *avator;
/*! 是否置顶 */
@property (nonatomic, assign) BOOL top_post;
/*! 标题 */
@property (nonatomic, copy) NSString *title;
/*! 内容 */
@property (nonatomic, copy) NSString *content;
/*! 展示图片数组 */
@property (nonatomic, strong) NSMutableArray *images;
/*! 所有评论数组conments */
@property (nonatomic, strong) NSMutableArray *comments;
/*! 点赞数 thumbNums*/
@property (nonatomic, strong) NSNumber *vote;
/*! 点赞数 thumbNums*/
@property (nonatomic, assign) BOOL is_vote;
/*! 时间create_time */
@property (nonatomic, copy) NSString *created_at;
/*! 评论数 commentCount*/
@property (nonatomic, strong) NSNumber *comment_count;
/*! 分享数shareCount */
@property (nonatomic, strong) NSNumber *share;

/** 富文本 */
- (NSAttributedString *)attributedText;

@end

NS_ASSUME_NONNULL_END
