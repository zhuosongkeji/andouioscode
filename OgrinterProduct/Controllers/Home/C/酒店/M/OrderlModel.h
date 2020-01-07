//
//  OrderlModel.h
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/3.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderlModel : NSObject


@property(nonatomic,strong)NSString *spid;
@property(nonatomic,strong)NSString *order_sn;
@property(nonatomic,strong)NSString *allnum;


@property(nonatomic,strong)NSString *pay_way;
@property(nonatomic,strong)NSString *pay_money;


@property(nonatomic,strong)NSString *address_id;
@property(nonatomic,strong)NSString *integral;
@property(nonatomic,strong)NSString *pay_time;
@property(nonatomic,strong)NSString *status;

@property(nonatomic,strong)NSArray *listArr;


@property(nonatomic,strong)NSString *area;
@property(nonatomic,strong)NSString *province;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *name;





-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)initWithDict:(NSDictionary *)dict;


@end

NS_ASSUME_NONNULL_END
