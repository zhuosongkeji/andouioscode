//
//  ZBNPostComReplyFrame.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/3/7.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNPostComReplyFrame.h"
#import "ZBNPostComReplyM.h"

@interface ZBNPostComReplyFrame ()
/** 头像frame */
@property (nonatomic , assign ) CGRect avatarFrame;
/*! 标题 */
@property (nonatomic , assign ) CGRect titleFrame;
/** 时间frame */
@property (nonatomic , assign ) CGRect createTimeFrame;
@property (nonatomic , assign) CGFloat cellHeight;

@end


@implementation ZBNPostComReplyFrame

- (void)setReM:(ZBNPostComReplyM *)reM
{
    _reM = reM;
    
    // 头像
    CGFloat avatarX = 15;
    CGFloat avatarY = 15;
    CGFloat avatarW = 45;
    CGFloat avatarH = 45;
    self.avatarFrame = CGRectMake(avatarX, avatarY, avatarW, avatarH);
    // 标题
       CGFloat titleX = 65;
       CGFloat titleY =  15;
       CGSize  textLimitSize = CGSizeMake(KSCREEN_WIDTH - 30, MAXFLOAT);
    CGFloat titleH = [YYTextLayout layoutWithContainerSize:textLimitSize text:reM.attributedText].textBoundingSize.height;
       self.titleFrame = CGRectMake(titleX, titleY, textLimitSize.width, titleH);
    // 时间
    CGFloat timeX = 65;
    CGFloat timeY = CGRectGetMaxY(self.titleFrame) + 5;
    CGFloat timeW = KSCREEN_WIDTH - 80;
    CGFloat timeH = 17;
    self.createTimeFrame = CGRectMake(timeX, timeY, timeW, timeH);
    
    self.cellHeight = CGRectGetMaxY(self.avatarFrame) + 20;
    
}


@end
