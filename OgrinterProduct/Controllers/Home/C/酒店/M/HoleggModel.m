//
//  HoleggModel.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/11.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "HoleggModel.h"

@implementation HoleggModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    
    HoleggModel *model = [[HoleggModel alloc]init];
    
    model.num = [NSString stringWithFormat:@"%@",dict[@"num"]];
    model.img = [NSString stringWithFormat:@"%@%@",imgServer,dict[@"img"]];
    model.has_breakfast = [NSString stringWithFormat:@"%@",dict[@"has_breakfast"]];
    model.gid = [NSString stringWithFormat:@"%@",dict[@"gid"]];
    model.price = [NSString stringWithFormat:@"%@",dict[@"price"]];
    model.bed_type = [NSString stringWithFormat:@"%@",dict[@"bed_type"]];
    model.areas  = [NSString stringWithFormat:@"%@",dict[@"areas"]];
    
    model.house_name = [NSString stringWithFormat:@"%@",dict[@"house_name"]];
    model.has_window = [NSString stringWithFormat:@"%@",dict[@"has_window"]];
    model.wifi = [NSString stringWithFormat:@"%@",dict[@"wifi"]];
    model.other_sets = [NSString stringWithFormat:@"%@",dict[@"other_sets"]];
    
    return model;
}

+(instancetype)initWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

@end
