//
//  ZBNPostComModel.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/17.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNPostComModel.h"

@implementation ZBNPostComModel

- (CGFloat)cellHeight
{
    if (_cellHeight == 0) {
        _cellHeight = 15 + 40;
        _cellHeight += 15;
        CGFloat textW = KSCREEN_WIDTH - 30;
        CGFloat textH = [self.comment boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
        _cellHeight += 15 + textH;
        _cellHeight += 30;
    }
    return _cellHeight;
}

@end
