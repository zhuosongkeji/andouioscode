//
//  ZBNPostPayModel.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/22.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNPostPayModel.h"

@implementation ZBNPostPayModel

- (NSMutableArray *)payWays
{
    if (!_payWays) {
        _payWays = [NSMutableArray array];
    }
    return _payWays;
}

- (NSMutableArray *)dingWays
{
    if (!_dingWays) {
        _dingWays = [NSMutableArray array];
    }
    return _dingWays;
}

@end
