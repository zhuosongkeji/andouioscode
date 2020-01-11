//
//  ZBNSHDetailLogisticsModel.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/10.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSHDetailLogisticsModel.h"

@implementation ZBNSHDetailLogisticsModel

/*! cell的高度 */
- (CGFloat)height
{
    if (_height == 0) {
        // 距离文字的间距
        _height += 15;
        // 计算文字的高度
        CGFloat textW = KSCREEN_WIDTH - 15 * 4;
        CGFloat textH = [self.context boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]} context:nil].size.height;
        _height += textH + 15 + 14.5 + 15;
    }
    return _height;
}


@end
