//
//  ZBNTopicComFrame.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/3/8.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNTopicComFrame.h"

@interface ZBNTopicComFrame ()

/** 内容尺寸 */
@property (nonatomic , assign) CGRect textFrame;
@property (nonatomic, assign) CGRect userIconFrame;
/** cell高度 */
@property (nonatomic , assign) CGFloat cellHeight;
@end

@implementation ZBNTopicComFrame

- (void)setComment:(ZBNPostComModel *)comment
{
    _comment = comment;
    
    // 头像
    CGFloat iconX = 15;
    CGFloat iconY = 5;
    CGFloat iconW = 30;
    CGFloat iconH = iconW;
    self.userIconFrame =  CGRectMake(iconX, iconY, iconW, iconH);
    // 文本内容
    CGFloat textX = 60;
    CGFloat textY = 9;
    CGSize textLimitSize = CGSizeMake(self.maxW - 50, MAXFLOAT);
    CGFloat textH = [YYTextLayout layoutWithContainerSize:textLimitSize text:comment.attributedText].textBoundingSize.height;
    self.textFrame = CGRectMake(textX, textY, textLimitSize.width, textH);
    
    if (CGRectGetMaxY(self.textFrame) <= 40) {
        self.cellHeight = 40;
    } else {
        self.cellHeight = CGRectGetMaxY(self.textFrame) + 5;
    }
}


@end
