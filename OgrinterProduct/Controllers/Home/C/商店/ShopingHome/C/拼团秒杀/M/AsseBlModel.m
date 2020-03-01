//
//  AsseBlModel.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/2/24.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "AsseBlModel.h"

@implementation AsseBlModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    
    AsseBlModel *model = [[AsseBlModel alloc]init];
    
    model.sid = [NSString stringWithFormat:@"%@",dict[@"id"]];
    model.goods_id = [NSString stringWithFormat:@"%@",dict[@"goods_id"]];
    model.sdu_id = [NSString stringWithFormat:@"%@",dict[@"sdu_id"]];
    model.price = [NSString stringWithFormat:@"%@",dict[@"price"]];
    model.storage = [NSString stringWithFormat:@"%@",dict[@"storage"]];
    model.name = [NSString stringWithFormat:@"%@",dict[@"name"]];
    model.img = [NSString stringWithFormat:@"%@",dict[@"img"]];
    model.old_price = [NSString stringWithFormat:@"%@",dict[@"old_price"]];
    model.total_member = [NSString stringWithFormat:@"%@",dict[@"total_member"]];
    model.buy_total = [NSString stringWithFormat:@"%@",dict[@"buy_total"]];
    model.sale_percent = [NSString stringWithFormat:@"%@",dict[@"sale_percent"]];
    
    return model;
}

+(instancetype)initWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

@end
