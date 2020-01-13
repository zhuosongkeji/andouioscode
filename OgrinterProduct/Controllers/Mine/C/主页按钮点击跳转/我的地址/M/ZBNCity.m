//
//  ZBNCity.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/1.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNCity.h"
#import "ZBNArea.h"

@implementation ZBNCity

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
        @"areas":@"ZBNArea",
    };
}

@end
