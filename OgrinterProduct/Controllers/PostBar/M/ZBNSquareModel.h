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

/** 话题id */
@property (nonatomic , copy) NSString * SquareId;
/*! 用户 */
@property (nonatomic, strong) ZBNPostUserModel *userM;
/*! 是否置顶 */
@property (nonatomic, assign) BOOL isTop;
/*! 标题 */
@property (nonatomic, copy) NSString *title;
/*! 内容 */
@property (nonatomic, copy) NSString *content;
/*! 展示图片数组 */
@property (nonatomic, strong) NSMutableArray *images;
/*! 所有评论数组 */
@property (nonatomic, strong) NSMutableArray *conments;
/*! 点赞数 */
@property (nonatomic, copy) NSString *thumbNums;
/*! 时间 */
@property (nonatomic, copy) NSString *create_time;
/*! 评论数 */
@property (nonatomic, copy) NSString *commentCount;
/*! 分享数 */
@property (nonatomic, copy) NSString *shareCount;

/** 富文本 */
- (NSAttributedString *)attributedText;

@end

NS_ASSUME_NONNULL_END
