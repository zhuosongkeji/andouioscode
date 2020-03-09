//
//  ZBNTopicFrame.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/3/5.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNTopicFrame.h"
#import "ZBNSquareModel.h"
#import "ZBNComReModel.h"
#import "ZBNTopicComFrame.h"
#import "NSString+ZBNExtension.h"
#import "ZBNPostPhotoItem.h"

@interface ZBNTopicFrame ()
/** 头像frame */
@property (nonatomic , assign ) CGRect avatarFrame;
/** 昵称frame */
@property (nonatomic , assign) CGRect nicknameFrame;
/*! 置顶 */
@property (nonatomic , assign ) CGRect topFrame;
/*! 标题 */
@property (nonatomic , assign ) CGRect titleFrame;
/*! 内容 */
@property (nonatomic , assign) CGRect textFrame;
/*! 中间图片 */
@property (nonatomic , assign) CGRect imgFrame;
/** 点赞frame */
@property (nonatomic , assign ) CGRect thumbFrame;
/*! 评论 */
@property (nonatomic , assign ) CGRect commentFrame;
/** 分享frame */
@property (nonatomic , assign ) CGRect shareFrame;
/** 时间frame */
@property (nonatomic , assign ) CGRect createTimeFrame;
/** height 这里只是 整个话题占据的高度 */
@property (nonatomic , assign ) CGFloat topicHeight;
/** tableViewFrame cell嵌套tableView用到 本人有点懒 ，公用了一套模型 */
@property (nonatomic , assign)  CGRect tableViewFrame;
@property (nonatomic , strong) NSMutableArray *imageFrames;

@end

@implementation ZBNTopicFrame

- (instancetype)init
{
    self = [super init];
    if (self) {
        _commentFrames = [NSMutableArray array];
        _imageFrames = [NSMutableArray array];
    }
    return self;
}


#pragma mark - Setter

- (void)setTopic:(ZBNSquareModel *)topic
{
    _topic = topic;
    // 头像
    CGFloat avatarX = 15;
    CGFloat avatarY = 15;
    CGFloat avatarW = 45;
    CGFloat avatarH = 45;
    self.avatarFrame = CGRectMake(avatarX, avatarY, avatarW, avatarH);
    // 置顶
    CGFloat topW = 15;
    CGFloat topH = 15;
    CGFloat topX = KSCREEN_WIDTH - 30;
    CGFloat topY = 15;
    self.topFrame = CGRectMake(topX, topY, topW, topH);
    // 昵称
    CGFloat nickNameX = CGRectGetMaxX(self.avatarFrame) + 15;
    CGFloat nickNameY = avatarY;
    CGFloat nickNameW = CGRectGetMinX(self.topFrame) - nickNameX;
    CGFloat nickNameH = 18;
    self.nicknameFrame = CGRectMake(nickNameX, nickNameY, nickNameW, nickNameH);
    // 标题
    CGFloat titleX = 15;
    CGFloat titleY = CGRectGetMaxY(self.avatarFrame) + 5;
    CGFloat titleW = KSCREEN_WIDTH - 30;
    CGFloat titleH = 17;
    self.titleFrame = CGRectMake(titleX, titleY, titleW, titleH);
    // 内容
    CGFloat textX = 15;
    CGFloat textY = CGRectGetMaxY(self.titleFrame) + 5;
    CGFloat textW = KSCREEN_WIDTH - 30;
    CGSize textLimitSize = CGSizeMake(KSCREEN_WIDTH -30, MAXFLOAT);
    CGFloat textH = [YYTextLayout layoutWithContainerSize:textLimitSize text:topic.attributedText].textBoundingSize.height + 10;
    self.textFrame = CGRectMake(textX, textY, textW, textH);
    
    CGFloat imageX = 15;
    CGFloat imageY = CGRectGetMaxY(self.textFrame);
    CGFloat imageW = KSCREEN_WIDTH - 30;
    if (topic.images.count > 6) {
    CGFloat imageH = ((KSCREEN_WIDTH -45) / 3) * 3 + 10;
    self.imgFrame = CGRectMake(imageX, imageY, imageW, imageH);
    } else if (topic.images.count > 3) {
      CGFloat imageH = 2 * ((KSCREEN_WIDTH - 45) / 3) + 10;
      self.imgFrame = CGRectMake(imageX, imageY, imageW, imageH);
    } else if (topic.images.count >= 1) {
     CGFloat imageH = (KSCREEN_WIDTH - 45) / 3;
     self.imgFrame = CGRectMake(imageX, imageY, imageW, imageH);
    } else {
        CGFloat imageH = 0;
        self.imgFrame = CGRectMake(imageX, imageY, imageW, imageH);
       }
    // 分享
    CGFloat shareW = topic.shareString?([topic.shareString zbn_sizeWithFont:[UIFont systemFontOfSize:8]].width + 30):44;
    CGFloat shareX = KSCREEN_WIDTH - 15 - shareW;
    CGFloat shareY = CGRectGetMaxY(self.imgFrame) + 5;
    CGFloat shareH = 20;
    self.shareFrame = CGRectMake(shareX, shareY, shareW, shareH);
    // 评论
    CGFloat commentW = topic.commentString?([topic.commentString zbn_sizeWithFont:[UIFont systemFontOfSize:8]].width + 30):44;
    CGFloat commentX = KSCREEN_WIDTH - 15 - shareW - 15 - commentW;
    CGFloat commentY = shareY;
    CGFloat commentH = 20;
    self.commentFrame = CGRectMake(commentX, commentY, commentW, commentH);
    // 点赞
    CGFloat voteW = topic.voteString?([topic.voteString zbn_sizeWithFont:[UIFont systemFontOfSize:8]].width + 30):44;
    CGFloat voteX = KSCREEN_WIDTH - 15 - shareW - 15 - commentW - 15 - voteW;
    CGFloat voteY = shareY;
    CGFloat voteH = 20;
    self.thumbFrame = CGRectMake(voteX, voteY, voteW, voteH);
    // 时间
    CGFloat timeX = 15;
    CGFloat timeY = shareY + 5;
    CGFloat timeW =  CGRectGetMinX(self.thumbFrame) - 30;
    CGFloat timeH = 17;
    self.createTimeFrame = CGRectMake(timeX, timeY, timeW, timeH);
    // 评论
    CGFloat tableViewX = textX ;
    CGFloat tableViewY = CGRectGetMaxY(self.createTimeFrame) + 15;
    CGFloat tableViewW = textLimitSize.width ;
    CGFloat tableViewH = 0;
    
    // 评论数据
    if (topic.comments.count>0) {
        for (ZBNPostComModel *comment in topic.comments) {
            ZBNTopicComFrame *commentFrame = [[ZBNTopicComFrame alloc] init];
            commentFrame.maxW = textLimitSize.width ;
            commentFrame.comment = comment;
            [self.commentFrames addObject:commentFrame];
            tableViewH += commentFrame.cellHeight;
        }
    }
    self.tableViewFrame = CGRectMake(tableViewX, tableViewY, tableViewW, tableViewH);
    self.topicHeight = CGRectGetMaxY(self.createTimeFrame) + 15;
}


+ (NSDictionary *)mj_objectClassInArray
{
    return @{
        @"commentFrames":@"ZBNTopicComFrame",
        @"squareM":@"ZBNSquareModel",
    };
}


@end
