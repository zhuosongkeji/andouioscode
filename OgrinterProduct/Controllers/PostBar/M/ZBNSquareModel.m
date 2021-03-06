//
//  ZBNSquareModel.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/17.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSquareModel.h"

@interface ZBNSquareModel ()
/*! 辅助属性 */
@property (nonatomic, copy) NSString *shareString;
@property (nonatomic, copy) NSString *commentString;
@property (nonatomic, copy) NSString *voteString;
@end

@implementation ZBNSquareModel

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
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.content];
    attributedString.yy_font = [UIFont systemFontOfSize:13];
    attributedString.yy_color = [UIColor colorWithRed:100/255.0 green:100/255.0  blue:100/255.0  alpha:1];
    attributedString.yy_lineSpacing = 15;
    return attributedString;
}

- (void)setShare:(NSNumber *)share
{
    _share = share;
    self.shareString = [self _numsStringWithNums:share];
}

- (void)setVote:(NSNumber *)vote
{
    _vote = vote;
    self.voteString = [self _numsStringWithNums:vote];
}

- (void)setComment_count:(NSNumber *)comment_count
{
    _comment_count = comment_count;
    self.commentString = [self _numsStringWithNums:comment_count];
}

#pragma mark - 私有方法
// 点赞
- (NSString *)_numsStringWithNums:(NSNumber *)nums
{

    NSString *titleString = nil;
    
    if (nums.intValue >= 10000) { // 上万
        CGFloat final = nums.intValue / 10000.0;
        titleString = [NSString stringWithFormat:@"%.1f万", final];
        // 替换.0为空串
        titleString = [titleString stringByReplacingOccurrencesOfString:@".0" withString:@""];
    } else if (nums.intValue >= 0) { // 一万以内
        titleString = [NSString stringWithFormat:@"%@1", nums];
    }
    
    return titleString;
}



+ (NSDictionary *)mj_objectClassInArray
{
    return @{
        @"comments":@"ZBNPostComModel",
        @"userM":@"ZBNPostUserModel",
    };
}



@end
