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
#import "ZBNMineModel.h"
#import "ZBNSHCommonModel.h"
#import "ZBNRTComModel.h"
#import "ZBNRTFoodsModel.h"
#import "ZBNRTComDetailModel.h"
#import "ZBNMyNewsModel.h"
#import "ZBNMyNewsDetailModel.h"
#import "ZBNSHReCellM.h"
#import "ZBNSHOrderDetailsM.h"
#import "ZBNMyCollectionM.h"
#import "ZBNBrowseModel.h"
#import "ZBNShopFollowModel.h"
#import "ZBNPostUserModel.h"
#import "ZBNSquareModel.h"
#import "ZBNPostComModel.h"

@implementation ZBNExtensionConfig

+ (void)load
{

    [ZBNShopFollowModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
           return @{
               @"ID" : @"id",
           };
       }];
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
    [ZBNSHOrderDetailsM mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
           return @{
               @"ID" : @"id",
           };
       }];
    [ZBNMineModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
          return @{
              @"ID" : @"id",
          };
    }];
    [ZBNSHCommonModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
           return @{
               @"ID" : @"id",
           };
       }];
    [ZBNRTComModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
              return @{
                  @"ID" : @"id",
              };
          }];
    [ZBNRTFoodsModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                 return @{
                     @"ID" : @"id",
                 };
             }]; 
    [ZBNRTComDetailModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
            @"ID" : @"id",
        };
    }];
    [ZBNMyNewsModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
            @"ID" : @"id",
        };
    }]; 
    [ZBNMyNewsDetailModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
            @"ID" : @"id",
        };
    }];
    [ZBNSHReCellM mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
           return @{
               @"ID" : @"id",
           };
       }]; 
    [ZBNMyCollectionM mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
              return @{
                  @"ID" : @"id",
              };
          }];
    [ZBNBrowseModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
            @"ID" : @"id",
        };
    }];
    [ZBNPostUserModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
           return @{
               @"ID" : @"id",
           };
       }];
    [ZBNSquareModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
            @"ID" : @"id",
        };
    }];
    [ZBNPostComModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
            @"ID" : @"id",
        };
    }];
}


@end
