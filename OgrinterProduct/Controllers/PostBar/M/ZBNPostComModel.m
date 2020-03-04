//
//  ZBNPostComModel.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/17.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNPostComModel.h"

@implementation ZBNPostComModel

- (NSAttributedString *)attributedText
{
 
        if (self.to) {
            // 有回复
            NSString *textString = [NSString stringWithFormat:@"%@回复%@: %@", self.name, self.to, self.content];;
            NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:textString];
            mutableAttributedString.yy_font = [UIFont systemFontOfSize:13];
            mutableAttributedString.yy_color = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1];
            mutableAttributedString.yy_lineSpacing = 5;
            
            NSRange fromUserRange = NSMakeRange(0, self.name.length);
            YYTextHighlight *fromUserHighlight = [YYTextHighlight highlightWithBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]];
            fromUserHighlight.userInfo = @{ZBNCommentUserKey:self.name};
            [mutableAttributedString yy_setTextHighlight:fromUserHighlight range:fromUserRange];
            // 设置昵称颜色
            [mutableAttributedString yy_setColor:[UIColor colorWithRed:94/255.0 green:211/255.0 blue:174/255.0 alpha:1] range:NSMakeRange(0, self.name.length)];
            
            
            
            NSRange toUserRange = [textString rangeOfString:[NSString stringWithFormat:@"%@:",self.to]];
            // 文本高亮模型
            YYTextHighlight *toUserHighlight = [YYTextHighlight highlightWithBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]];
            // 这里痛过属性的userInfo保存User模型，后期通过获取模型然后获取User模型
            toUserHighlight.userInfo = @{ZBNCommentUserKey:self.to};
            
            // 点击用户的昵称的事件传递
    //        toUserHighlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect)
    //        {
    //            // 这里通过通知把用户的模型传递出去
    //        };
            
            [mutableAttributedString yy_setTextHighlight:toUserHighlight range:toUserRange];
            [mutableAttributedString yy_setColor:[UIColor colorWithRed:94/255.0 green:211/255.0 blue:174/255.0 alpha:1] range:toUserRange];
            
            return mutableAttributedString;
            
            
        }else{
            
            // 没有回复
            NSString *textString = [NSString stringWithFormat:@"%@: %@", self.name, self.content];
            NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:textString];
            mutableAttributedString.yy_font = [UIFont systemFontOfSize:13];
            // rgba(94, 211, 174, 1)
            mutableAttributedString.yy_color = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1];
            mutableAttributedString.yy_lineSpacing = 5;
            
            NSRange fromUserRange = NSMakeRange(0, self.name.length+1);
            // 设置昵称颜色
            [mutableAttributedString yy_setColor:[UIColor colorWithRed:94/255.0 green:211/255.0 blue:174/255.0 alpha:1] range:fromUserRange];
            
            YYTextHighlight *fromUserHighlight = [YYTextHighlight highlightWithBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]];
            fromUserHighlight.userInfo = @{ZBNCommentUserKey:self.name};
            [mutableAttributedString yy_setTextHighlight:fromUserHighlight range:fromUserRange];
            
            return mutableAttributedString;
        }
        
        return nil;
    }


@end
