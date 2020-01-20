//
//  ZBNSHReturnGoodsComM.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/19.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNSHReturnGoodsComM : NSObject
@property (nonatomic, copy) NSString *reason_id;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *image;
+ (ZBNSHReturnGoodsComM *)sharedInstance;
@end

NS_ASSUME_NONNULL_END
