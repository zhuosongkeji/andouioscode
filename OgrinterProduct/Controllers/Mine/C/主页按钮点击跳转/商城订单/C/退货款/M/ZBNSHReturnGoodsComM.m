//
//  ZBNSHReturnGoodsComM.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/19.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSHReturnGoodsComM.h"

@implementation ZBNSHReturnGoodsComM

static ZBNSHReturnGoodsComM *__onetimeClass;

+ (ZBNSHReturnGoodsComM *)sharedInstance {
static dispatch_once_t oneToken;

    dispatch_once(&oneToken, ^{

        __onetimeClass = [[ZBNSHReturnGoodsComM alloc]init];
    });
    return __onetimeClass;
}
@end
