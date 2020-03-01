//
//  KillerAessModel.h
//  OgrinterProduct
//
//  Created by wongshine on 2020/2/24.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KillerAessModel : NSObject

@property(nonatomic,strong)NSArray *top_goods;

@property(nonatomic,strong)NSArray *goods_list;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
