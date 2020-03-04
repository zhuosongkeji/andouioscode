//
//  ZBNSquareFrame.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/20.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSquareFrame.h"

@interface ZBNSquareFrame ()
/*! 头像 */
@property (nonatomic , assign ) CGRect avatarFrame;
/*! 标题 */
@property (nonatomic , assign ) CGRect titleFrame;
/*! 内容 */
@property (nonatomic , assign ) CGRect contentFrame;
/*! 中间图片 */
@property (nonatomic , assign ) CGRect imageFrame;
/*! 整个高度 */
@property (nonatomic , assign ) CGFloat height;

@property (nonatomic, strong) NSMutableArray *commentFrames;

@end

@implementation ZBNSquareFrame



- (instancetype)init
{
    self = [super init];
    if (self) {
        _commentFrames = [NSMutableArray array];
    }
    return self;
}

- (void)setSquareM:(ZBNSquareModel *)squareM
{
    _squareM = squareM;
    
    // 中间图片的额frame
    // 头像
    CGFloat avatarX = 15;
    CGFloat avatarY = 15;
    CGFloat avatarW = 45;
    CGFloat avatarH = 45;
    self.avatarFrame = (CGRect){{avatarX , avatarY},{avatarW , avatarH}};
    
    // 中间文字内容
    CGFloat contentX = 15;
    CGFloat contentY = CGRectGetMaxY(self.avatarFrame) + 15 + 15 + 17;
    CGSize contentSize = CGSizeMake(KSCREEN_WIDTH - 30, MAXFLOAT);
    CGFloat contentH = [YYTextLayout layoutWithContainerSize:contentSize text:squareM.attributedText].textBoundingSize.height + 30;
    self.contentFrame = CGRectMake(contentX, contentY, contentSize.width, contentH);
    
    // 图片
    CGFloat imageX = 15;
    CGFloat imageY = CGRectGetMaxY(self.contentFrame);
    CGFloat imageW = KSCREEN_WIDTH - 30;
    if (squareM.images.count > 6) {
        CGFloat imageH = ((KSCREEN_WIDTH -45) / 3) * 3 + 10;
        self.imageFrame = CGRectMake(imageX, imageY, imageW, imageH);
    } else if (squareM.images.count > 3) {
        CGFloat imageH = 2 * ((KSCREEN_WIDTH - 45) / 3) + 10;
        self.imageFrame = CGRectMake(imageX, imageY, imageW, imageH);
    } else if (squareM.images.count >= 1) {
        CGFloat imageH = (KSCREEN_WIDTH - 45) / 3;
        self.imageFrame = CGRectMake(imageX, imageY, imageW, imageH);
    } else {
        CGFloat imageH = 0;
        self.imageFrame = CGRectMake(imageX, imageY, imageW, imageH);
    }
    
    // 评论数据
    if (squareM.comments > 0) {
        for (ZBNPostComModel *model in squareM.comments)
        {
            ZBNCommentFrame *comFrame = [[ZBNCommentFrame alloc] init];
            comFrame.maxW = KSCREEN_WIDTH - 30;
            comFrame.comment = model;
            [self.commentFrames addObject:comFrame];
        }
         
    }
    
    // 总体高度
    self.height = CGRectGetMaxY(self.imageFrame) + 40;
    
}


+ (NSDictionary *)mj_objectClassInArray
{
    return @{
        @"squareM":@"ZBNSquareModel",
    };
}


@end
