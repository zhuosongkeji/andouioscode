//
//  ZBNCommentFrame.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/20.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNCommentFrame.h"

@interface ZBNCommentFrame ()

/** 内容尺寸 */
@property (nonatomic , assign) CGRect textFrame;
/** cell高度 */
@property (nonatomic , assign) CGFloat cellHeight;

@end

@implementation ZBNCommentFrame

- (void)setComment:(ZBNPostComModel *)comment
{
    _comment = comment;
    
    // 文本内容
    CGFloat textX = 60;
    CGFloat textY = 9;
    CGSize  textLimitSize = CGSizeMake(self.maxW - 50, MAXFLOAT);
    CGFloat textH = [YYTextLayout layoutWithContainerSize:textLimitSize text:comment.attributedText].textBoundingSize.height;
    
    self.textFrame = (CGRect){{textX , textY} , {textLimitSize.width , textH}};
    
    if (CGRectGetMaxY(self.textFrame) <= 39 ) {
        self.cellHeight = 39;
    } else {
        self.cellHeight = CGRectGetMaxY(self.textFrame) + 4;
    }
}
@end
