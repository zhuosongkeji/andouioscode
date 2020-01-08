//
//  ZBNExtensionConfig.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/2.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNExtensionConfig.h"
#import <MJExtension.h>
#import "ZBNProvince.h"
#import "ZBNCity.h"
#import "ZBNArea.h"
#import "ZBNMyAddressModel.h"
#import "ZBNShoppingCartModel.h"
#import "ZBNSHOrderDetailComM.h"


@implementation ZBNExtensionConfig

+ (void)load
{
    [ZBNProvince mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
            @"ID" : @"id",
        };
    }];
    [ZBNCity mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
            @"ID" : @"id",
        };
    }];
    [ZBNArea mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
           return @{
               @"ID" : @"id",
           };
       }];
    [ZBNMyAddressModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
            @"ID" : @"id",
        };
    }];
    [ZBNShoppingCartModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
            @"ID" : @"id",
        };
    }];
    [ZBNSHOrderDetailComM mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
            @"ID" : @"id",
        };
    }];
}


@end
