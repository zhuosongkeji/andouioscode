//
//  ZBNPostComReplyM.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/3/7.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNPostComReplyM.h"


@interface ZBNPostComReplyM ()

@end

@implementation ZBNPostComReplyM

- (NSString *)created_at
{
    NSDateFormatter *fmt = [NSDateFormatter zbn_defaultDateFormatter];
    #warning CoderMikeHe: 真机调试的时候，必须加上这句
        fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        // 获得发布的具体时间
        NSDate *createDate = [fmt dateFromString:_created_at];
        
        // 判断是否为今年
        if (createDate.zbn_isThisYear) {
            if (createDate.zbn_isToday) { // 今天
                NSDateComponents *cmps = [createDate zbn_deltaWithNow];
                if (cmps.hour >= 1) { // 至少是1小时前发的
                    return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
                } else if (cmps.minute >= 1) { // 1~59分钟之前发的
                    return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
                } else { // 1分钟内发的
                    return @"刚刚";
                }
            } else if (createDate.zbn_isYesterday) { // 昨天
                fmt.dateFormat = @"昨天 HH:mm";
                return [fmt stringFromDate:createDate];
            } else { // 至少是前天
                fmt.dateFormat = @"MM-dd HH:mm";
                return [fmt stringFromDate:createDate];
            }
        } else { // 非今年
            fmt.dateFormat = @"yyyy-MM-dd";
            return [fmt stringFromDate:createDate];
        }
}

- (NSAttributedString *)attributedText
{
    // 赞
        NSString *textStr = [NSString stringWithFormat:@"%@ 赞了您的帖子 <<%@>>",self.from_user,self.title];
        NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:textStr];
        mutableAttributedString.yy_font = [UIFont systemFontOfSize:14];
        mutableAttributedString.yy_color = [UIColor blackColor];
        mutableAttributedString.yy_lineSpacing = 5;
        NSRange fromRange = NSMakeRange(0, self.from_user.length);
        YYTextHighlight *fromUserHighlight = [YYTextHighlight highlightWithBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]];
        fromUserHighlight.userInfo = @{ZBNCommentUserKey:self.from_user};
        [mutableAttributedString yy_setTextHighlight:fromUserHighlight range:fromRange];
        // 设置昵称颜色
        [mutableAttributedString yy_setColor:[UIColor colorWithRed:94/255.0 green:211/255.0 blue:174/255.0 alpha:1] range:NSMakeRange(0, self.from_user.length)];
        
        NSRange toUserRange = [textStr rangeOfString:[NSString stringWithFormat:@"<<%@>>",self.title]];
        // 文本高亮模型
        YYTextHighlight *toUserHighlight = [YYTextHighlight highlightWithBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]];
        // 这里痛过属性的userInfo保存User模型，后期通过获取模型然后获取User模型
        toUserHighlight.userInfo = @{ZBNCommentUserKey:self.title};
        [mutableAttributedString yy_setTextHighlight:toUserHighlight range:toUserRange];
        [mutableAttributedString yy_setColor:[UIColor colorWithRed:94/255.0 green:211/255.0 blue:174/255.0 alpha:1] range:toUserRange];
        
        return mutableAttributedString;
}

- (NSAttributedString *)attributedTextRe
{
    // 赞
    NSString *textStr = [NSString stringWithFormat:@"%@ 回复了您的 <<%@>>",self.from_user,self.title];
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:textStr];
    mutableAttributedString.yy_font = [UIFont systemFontOfSize:14];
    mutableAttributedString.yy_color = [UIColor blackColor];
    mutableAttributedString.yy_lineSpacing = 5;
    NSRange fromRange = NSMakeRange(0, self.from_user.length);
    YYTextHighlight *fromUserHighlight = [YYTextHighlight highlightWithBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]];
    fromUserHighlight.userInfo = @{ZBNCommentUserKey:self.from_user};
    [mutableAttributedString yy_setTextHighlight:fromUserHighlight range:fromRange];
    // 设置昵称颜色
    [mutableAttributedString yy_setColor:[UIColor colorWithRed:94/255.0 green:211/255.0 blue:174/255.0 alpha:1] range:NSMakeRange(0, self.from_user.length)];
    
    NSRange toUserRange = [textStr rangeOfString:[NSString stringWithFormat:@"<<%@>>",self.title]];
    // 文本高亮模型
    YYTextHighlight *toUserHighlight = [YYTextHighlight highlightWithBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]];
    // 这里痛过属性的userInfo保存User模型，后期通过获取模型然后获取User模型
    toUserHighlight.userInfo = @{ZBNCommentUserKey:self.title};
    [mutableAttributedString yy_setTextHighlight:toUserHighlight range:toUserRange];
    [mutableAttributedString yy_setColor:[UIColor colorWithRed:94/255.0 green:211/255.0 blue:174/255.0 alpha:1] range:toUserRange];
    
    return mutableAttributedString;
}


@end
