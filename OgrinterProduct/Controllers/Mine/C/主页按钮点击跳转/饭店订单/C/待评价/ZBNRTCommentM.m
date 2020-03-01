//
//  ZBNRTCommentM.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/28.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNRTCommentM.h"

@implementation ZBNRTCommentM

static ZBNRTCommentM *__onetimeClass;

+ (ZBNRTCommentM *)sharedInstance {
static dispatch_once_t oneToken;

    dispatch_once(&oneToken, ^{

        __onetimeClass = [[ZBNRTCommentM alloc]init];
    });
    return __onetimeClass;
}

@end
