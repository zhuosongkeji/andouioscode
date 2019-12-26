//
//  ShopDetalisModel.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/25.
//  Copyright © 2019 RXF. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopDetalisModel : NSObject

@property (nonatomic,strong) NSString *weight;
@property (nonatomic,strong) NSString *volume;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *dilivery;
@property (nonatomic,strong) NSString *store_num;
@property (nonatomic,strong) NSString *merchant_id;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *is_collection;


//商家属性
@property (nonatomic,strong) NSString *logoid;
@property (nonatomic,strong) NSString *logoimg;
@property (nonatomic,strong) NSString *logoName;


@property (nonatomic,strong)NSArray *bStrArr;




-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
