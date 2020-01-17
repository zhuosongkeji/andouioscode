//
//  OnlineOrderModel.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/16.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "OnlineOrderModel.h"
#import "OnlineOrderListModel.h"

@implementation OnlineOrderModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    
    OnlineOrderModel *model = [[OnlineOrderModel alloc]init];
    
    model.name = [NSString stringWithFormat:@"%@",dict[@"name"]];
    model.praise_num = [NSString stringWithFormat:@"%@",dict[@"praise_num"]];
    
    model.stars_all = [NSString stringWithFormat:@"%@",dict[@"stars_all"]];
    model.door_img = [NSString stringWithFormat:@"%@%@",imgServer,dict[@"door_img"]];
    
    model.oid = [NSString stringWithFormat:@"%@",dict[@"id"]];
    
    model.logo_img = [NSString stringWithFormat:@"%@%@",imgServer,dict[@"logo_img"]];
    model.address = [NSString stringWithFormat:@"%@",dict[@"address"]];
    model.desc = [NSString stringWithFormat:@"%@",dict[@"desc"]];
    model.business_start = [NSString stringWithFormat:@"%@",dict[@"business_start"]];
    model.business_end = [NSString stringWithFormat:@"%@",dict[@"business_end"]];
    model.tel = [NSString stringWithFormat:@"%@",dict[@"tel"]];
    model.status = [NSString stringWithFormat:@"%@",dict[@"status"]];
    
    NSArray *array = dict[@"cai"];
    NSMutableArray *mArr = [NSMutableArray array];
    for (int i = 0; i < [array count]; i ++ ) {
        NSDictionary *d = array[i];
        
        OnlineOrderListModel *mod = [[OnlineOrderListModel alloc]init];
        mod.lid = [NSString stringWithFormat:@"%@",d[@"id"]];
        mod.image = [NSString stringWithFormat:@"%@%@",imgServer,d[@"image"]];
        [mArr addObject:mod];
    }
    
    model.cai = mArr;
    
    return model;
}

+(instancetype)initWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

@end
