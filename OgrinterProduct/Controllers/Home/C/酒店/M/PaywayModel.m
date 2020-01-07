//
//  PaywayModel.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/4.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "PaywayModel.h"

@implementation PaywayModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    PaywayModel *model = [[PaywayModel alloc]init];
    
    model.pid = [NSString stringWithFormat:@"%@",dict[@"id"]];
    model.pay_way = [NSString stringWithFormat:@"%@",dict[@"pay_way"]];
    model.logo = [NSString stringWithFormat:@"%@%@",imgServer,dict[@"logo"]];
    
    return model;
}


+(instancetype)initWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

@end
