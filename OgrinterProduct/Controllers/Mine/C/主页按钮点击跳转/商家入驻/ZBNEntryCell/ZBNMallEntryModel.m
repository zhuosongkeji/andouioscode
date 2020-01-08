//
//  ZBNMallEntryModel.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/8.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNMallEntryModel.h"

@implementation ZBNMallEntryModel

static ZBNMallEntryModel *__onetimeClass;

+ (ZBNMallEntryModel *)sharedInstance {
static dispatch_once_t oneToken;

    dispatch_once(&oneToken, ^{

        __onetimeClass = [[ZBNMallEntryModel alloc]init];
    });
    return __onetimeClass;
}

@end
