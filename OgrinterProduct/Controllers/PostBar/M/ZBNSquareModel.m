//
//  ZBNSquareModel.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/17.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSquareModel.h"

@implementation ZBNSquareModel

- (CGFloat)cellHeight
{
    if (_cellHeight == 0) {
        _cellHeight += 15 + 45 + 15;
        CGFloat textOneW = KSCREEN_WIDTH - 30;
        CGFloat textOneH =  [self.title boundingRectWithSize:CGSizeMake(textOneW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        
        _cellHeight += textOneH + 15;
        
        CGFloat textTwoH =  [self.contentL boundingRectWithSize:CGSizeMake(textOneW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
        
        _cellHeight += textTwoH + 15;
        
        if (self.hasImg) {
            _cellHeight += 100;
        }
           _cellHeight += 15 + 17 + 15;
    
        
        if (self.cUserIcon) {
            _cellHeight += 40 + 15;
          CGFloat  textThreeH = [self.contentL boundingRectWithSize:CGSizeMake(textOneW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
            
            _cellHeight += textThreeH + 15;
            _cellHeight += 17;
        }
        _cellHeight += 10;
       
        
    }
    return _cellHeight;
}


@end
