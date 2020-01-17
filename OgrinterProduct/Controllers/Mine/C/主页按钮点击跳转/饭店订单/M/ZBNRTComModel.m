//
//  ZBNRTComModel.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/16.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNRTComModel.h"

@implementation ZBNRTComModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
        @"foods":@"ZBNRTFoodsModel"
    };
}

- (CGFloat)cellHeight
{
    if (_cellHeight == 0) {
        _cellHeight += 200;
        _cellHeight += self.foods.count * 40;
    }
    return _cellHeight;
}

@end
