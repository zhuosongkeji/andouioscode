//
//  HomeModel.h
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/6.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeModel : NSObject

@property (nonatomic,strong)NSString *tid;//配图
@property (nonatomic,strong)NSString *img;//标题
@property (nonatomic,strong)NSString *url;


@property (nonatomic,strong)NSString *logo_img;//
@property (nonatomic,strong)NSString *name;

@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSString *updated_at;


-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
