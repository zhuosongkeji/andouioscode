//
//  MsgModel.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/5.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "MsgModel.h"

@implementation MsgModel

-(instancetype)initWithDict:(NSDictionary *)dict {
    
    MsgModel *model = [[MsgModel alloc]init];
    
    model.address = [NSString stringWithFormat:@"%@",dict[@"address"]];
    model.created_at = [NSString stringWithFormat:@"%@",dict[@"created_at"]];
    model.uid = [NSString stringWithFormat:@"%@",dict[@"id"]];
    model.logo_img = [NSString stringWithFormat:@"%@%@",imgServer,dict[@"logo_img"]];
    model.img = [NSString stringWithFormat:@"%@%@",imgServer,dict[@"img"]];
    model.cid = [NSString stringWithFormat:@"%@",dict[@"id"]];
    model.merchant_type_id = [NSString stringWithFormat:@"%@",dict[@"merchant_type_id"]];
    model.name = [NSString stringWithFormat:@"%@",dict[@"name"]];
    model.praise_num = [NSString stringWithFormat:@"%@",dict[@"praise_num"]];
    model.price = [NSString stringWithFormat:@"%@",dict[@"price"]];
    model.stars_all = [NSString stringWithFormat:@"%@",dict[@"stars_all"]];
    model.tel = [NSString stringWithFormat:@"%@",dict[@"tel"]];
    
    model.house_name = [NSString stringWithFormat:@"%@",dict[@"house_name"]];
    model.desc = [NSString stringWithFormat:@"%@",dict[@"desc"]];
    
    return model;
}

+(instancetype)initWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

@end
