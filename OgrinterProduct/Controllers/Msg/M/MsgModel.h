//
//  MsgModel.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/5.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MsgModel : NSObject

@property (nonatomic,strong)NSString *shopimgStr;//配图
@property (nonatomic,strong)NSString *shoptitle;//商家
@property (nonatomic,strong)NSString *shopscore;//评分
@property (nonatomic,strong)NSString *shopadress;//地址
@property (nonatomic,strong)NSString *shophone;//电话
@property (nonatomic,strong)NSString *shopthumb;//点赞

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)initWithDict:(NSDictionary *)dict;


@end

NS_ASSUME_NONNULL_END
