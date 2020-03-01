//
//  ZBNProvince.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/1.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNProvince.h"

@implementation ZBNProvince


+ (NSDictionary *)mj_objectClassInArray
{
    return @{
        @"children":@"ZBNCity",
    };
}


@end
