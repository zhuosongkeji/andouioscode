//
//  ShoperModel.h
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/8.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShoperModel : NSObject


@property (nonatomic,strong) NSString *logoimg;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *bannerImg;

@property (nonatomic,strong)NSArray *typesArr;

@property (nonatomic,strong)NSArray *goodsArr;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)initWithDict:(NSDictionary *)dict;

@end




NS_ASSUME_NONNULL_END
