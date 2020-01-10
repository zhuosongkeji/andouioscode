//
//  ZBNSHGoAndEvaluateModel.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/9.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSHGoAndEvaluateModel.h"

@implementation ZBNSHGoAndEvaluateModel

static ZBNSHGoAndEvaluateModel *__onetimeClass;

+ (ZBNSHGoAndEvaluateModel *)sharedInstance {
static dispatch_once_t oneToken;

    dispatch_once(&oneToken, ^{

        __onetimeClass = [[ZBNSHGoAndEvaluateModel alloc]init];
    });
    return __onetimeClass;
}


@end
