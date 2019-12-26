//
//  ShopDetalisModel.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/25.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ShopDetalisModel.h"

@implementation ShopDetalisModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    ShopDetalisModel *model = [[ShopDetalisModel alloc]init];
    
    model.weight = [NSString stringWithFormat:@"%@",dict[@"weight"]];
    model.volume = [NSString stringWithFormat:@"%@",dict[@"volume"]];
    model.price = [NSString stringWithFormat:@"%@",dict[@"price"]];
    model.dilivery = [NSString stringWithFormat:@"%@",dict[@"dilivery"]];
    model.store_num = [NSString stringWithFormat:@"%@",dict[@"store_num"]];
    
    model.store_num = [NSString stringWithFormat:@"%@",dict[@"store_num"]];
    model.merchant_id = [NSString stringWithFormat:@"%@",dict[@"merchant_id"]];
    
    model.name = [NSString stringWithFormat:@"%@",dict[@"name"]];

    model.is_collection = [NSString stringWithFormat:@"%@",dict[@"is_collection"]];
    
    NSDictionary *dic = dict[@"merchant"];
    
    model.logoid = [NSString stringWithFormat:@"%@",dic[@"id"]];
    model.logoName = [NSString stringWithFormat:@"%@",dic[@"name"]];
    model.logoimg = [NSString stringWithFormat:@"%@",dic[@"logo_img"]];
    
    NSArray *array = dict[@"album"];
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i = 0; i < [array count]; i ++) {
        NSString *imgStr = [NSString stringWithFormat:@"%@%@",imgServer,array[i]];
        [arr addObject:imgStr];
    }
    
    [arr insertObject:[NSString stringWithFormat:@"%@%@",imgServer,dict[@"img"]] atIndex:0];
    
    model.bStrArr = arr;
    
    return model;
}

+(instancetype)initWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

@end
