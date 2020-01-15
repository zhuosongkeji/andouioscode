//
//  HotelOrderModel.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/14.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "HotelOrderModel.h"
#import "HotelOrderModelList.h"

@implementation HotelOrderModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    HotelOrderModel *model = [[HotelOrderModel alloc]init];
    HotelOrderModelList *model1 = [[HotelOrderModelList alloc]init];
    
    model.allprice = [NSString stringWithFormat:@"%@",dict[@"allprice"]];
    model.days = [NSString stringWithFormat:@"%@",dict[@"days"]];
    model.end = [NSString stringWithFormat:@"%@",dict[@"end"]];
    model.start = [NSString stringWithFormat:@"%@",dict[@"start"]];
    model.integral = [NSString stringWithFormat:@"%@",dict[@"integral"]];
    
    
    NSDictionary * dict1 = dict[@"room"];
    model1.house_name = [NSString stringWithFormat:@"%@",dict1[@"house_name"]];
    model1.lid = [NSString stringWithFormat:@"%@",dict1[@"id"]];
    model1.img = [NSString stringWithFormat:@"%@%@",imgServer,dict1[@"img"]];
    model1.merchant_id = [NSString stringWithFormat:@"%@",dict1[@"merchant_id"]];
    model1.name = [NSString stringWithFormat:@"%@",dict1[@"name"]];
    model1.price = [NSString stringWithFormat:@"%@",dict1[@"price"]];
    
    model.listmodel = model1;

    return model;
}

+(instancetype)initWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

@end

