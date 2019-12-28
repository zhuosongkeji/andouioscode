//
//  ZBNOrderModel.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/16.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNOrderModel.h"

@implementation ZBNOrderModel

- (CGFloat)cellHeight
{
    if (_cellHeight == 0) {
        _cellHeight = 35 + 15 * 2 + 15 + 15 + 17;
        
        CGFloat contentW = KSCREEN_WIDTH - 30;
        CGFloat contentH = 120;
        CGFloat contentY = _cellHeight;
        CGFloat contentX = 15;
        self.contentFrame = CGRectMake(contentX, contentY, contentW, contentH);
        _cellHeight += contentH;
        _cellHeight += 15 + 16 + 15 + 44;
    }
    return _cellHeight;
}

@end
