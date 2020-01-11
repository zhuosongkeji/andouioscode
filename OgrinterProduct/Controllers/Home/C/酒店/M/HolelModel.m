//
//  HolelModel.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/10.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "HolelModel.h"

@implementation HolelModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    HolelModel *model = [[HolelModel alloc]init];
    
    model.address = [NSString stringWithFormat:@"%@",dict[@"address"]];
    
    model.door_img = [NSString stringWithFormat:@"%@",dict[@"door_img"]];
    model.jdid = [NSString stringWithFormat:@"%@",dict[@"id"]];
    model.praise_num = [NSString stringWithFormat:@"%@",dict[@"praise_num"]];
    model.tel = [NSString stringWithFormat:@"%@",dict[@"tel"]];
    model.stars_all = [NSString stringWithFormat:@"%@",dict[@"stars_all"]];
    model.name = [NSString stringWithFormat:@"%@",dict[@"name"]];
    model.desc = [NSString stringWithFormat:@"%@",dict[@"desc"]];
    
    NSArray *facilitiesArr = dict[@"facilities"];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < [facilitiesArr count]; i ++) {
        NSString *imgStr = [NSString stringWithFormat:@"%@%@",imgServer,facilitiesArr[i]];
        [array addObject:imgStr];
    }
    
    model.facilities = [NSArray arrayWithArray:array];
    
    
    return model;
}

+(instancetype)initWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

@end
