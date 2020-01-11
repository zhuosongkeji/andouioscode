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

@property (nonatomic,strong)NSString *address;
@property (nonatomic,strong)NSString *created_at;
@property (nonatomic,strong)NSString *uid;
@property (nonatomic,strong)NSString *logo_img;
@property (nonatomic,strong)NSString *merchant_type_id;
@property (nonatomic,strong)NSString *name;

@property (nonatomic,strong)NSString *praise_num;
@property (nonatomic,strong)NSString *price;
@property (nonatomic,strong)NSString *stars_all;
@property (nonatomic,strong)NSString *tel;


@property (nonatomic,strong)NSString *img;
@property (nonatomic,strong)NSString *cid;


@property (nonatomic,strong)NSString *desc;
@property (nonatomic,strong)NSString *house_name;


-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)initWithDict:(NSDictionary *)dict;


@end

NS_ASSUME_NONNULL_END
