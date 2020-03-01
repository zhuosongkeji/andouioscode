//
//  ZBNSHGoAndEvaluateModel.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/9.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNSHGoAndEvaluateModel : NSObject

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *stars;
@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, copy) NSString *order_id;
@property (nonatomic, copy) NSString *merchants_id;


+ (ZBNSHGoAndEvaluateModel *)sharedInstance;

@end

NS_ASSUME_NONNULL_END
