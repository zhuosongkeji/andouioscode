//
//  BeseModel.h
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/2.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BeseModel : NSObject

@property(nonatomic,strong)NSArray *resArr;

@property(nonatomic,strong)NSDictionary *pDict;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
