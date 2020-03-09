//
//  ZBNTopicFrame.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/3/5.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
@class ZBNSquareModel,ZBNComReModel,ZBNCommentFrame;
@interface ZBNTopicFrame : NSObject

/** 头像frame */
@property (nonatomic , assign , readonly) CGRect avatarFrame;
/** 昵称frame */
@property (nonatomic , assign , readonly) CGRect nicknameFrame;
/*! 置顶 */
@property (nonatomic , assign , readonly) CGRect topFrame;
/*! 标题 */
@property (nonatomic , assign , readonly) CGRect titleFrame;
/*! 内容 */
@property (nonatomic , assign , readonly) CGRect textFrame;
/*! 中间图片 */
@property (nonatomic , assign , readonly) CGRect imgFrame;
/** 点赞frame */
@property (nonatomic , assign , readonly) CGRect thumbFrame;
/*! 评论 */
@property (nonatomic , assign , readonly) CGRect commentFrame;
/** 分享frame */
@property (nonatomic , assign , readonly) CGRect shareFrame;
/** 时间frame */
@property (nonatomic , assign , readonly) CGRect createTimeFrame;
/** height 这里只是 整个话题占据的高度 */
@property (nonatomic , assign , readonly) CGFloat topicHeight;
/** 评论尺寸模型 由于后期需要用到，所以不涉及为只读 */
@property (nonatomic , strong ) NSMutableArray *commentFrames;
/** tableViewFrame cell嵌套tableView用到 本人有点懒 ，公用了一套模型 */
@property (nonatomic , assign , readonly) CGRect tableViewFrame;
@property (nonatomic , strong , readonly) NSMutableArray *imageFrames;
/** 话题模型 */
@property (nonatomic , strong) ZBNSquareModel *topic;

@end

NS_ASSUME_NONNULL_END
