//
//  ZBNMyAddressModel.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/14.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMyAddressModel.h"

@implementation ZBNMyAddressModel

- (CGFloat)cellHeight
{
    if (_cellHeight == 0) {
        _cellHeight += 47;
        CGFloat textW = KSCREEN_WIDTH - 30;
        CGFloat textH = [self.address boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
        _cellHeight += textH + 71;
    }
    return _cellHeight;
 }


@end
