//
//  HomeModel.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/6.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    HomeModel *model = [[HomeModel alloc]init];
    
    model.tid = [NSString stringWithFormat:@"%@",dict[@"id"]];
    model.img = [NSString stringWithFormat:@"%@%@",imgServer,dict[@"img"]];
    model.url = [NSString stringWithFormat:@"%@",dict[@"url"]];
    model.logo_img = [NSString stringWithFormat:@"%@%@",imgServer,dict[@"logo_img"]];
    model.name = [NSString stringWithFormat:@"%@",dict[@"name"]];
    model.content = [NSString stringWithFormat:@"%@",dict[@"content"]];
    model.updated_at = [NSString stringWithFormat:@"%@",dict[@"updated_at"]];
    
    return model;
}

+(instancetype)initWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

@end
