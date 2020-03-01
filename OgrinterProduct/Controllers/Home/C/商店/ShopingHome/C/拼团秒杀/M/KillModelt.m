//
//  KillModelt.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/2/28.
//  Copyright © 2020 RXF. All rights reserved.
//


#import "KillModelt.h"
#import "KillerbListModel.h"

@implementation KillModelt

-(instancetype)initWithDict:(NSDictionary *)dict{
    KillModelt *model = [[KillModelt alloc]init];
    
    NSDictionary *dic = dict[@"group_goods"];
    
    model.goods_id = dic[@"goods_id"];
    model.now = dict[@"now"];
    model.sku_id = dic[@"sku_id"];
    model.price = dic[@"price"];
    model.storage = dic[@"storage"];
    model.top_member = dic[@"top_member"];
    model.begin_time = dic[@"begin_time"];
    
    model.finish_time = dic[@"finish_time"];
    model.code = dic[@"code"];
    model.sale_total = dic[@"sale_total"];
    
    
    model.total_member = dict[@"total_member"];
    
    NSMutableArray *mArr = [NSMutableArray array];
    NSArray *arr = dict[@"team_list"];
    for (int i = 0; i < [arr count]; i ++) {
        NSDictionary *d = arr[i];
        KillerbListModel *m = [[KillerbListModel alloc]init];
        m.group_id = d[@"group_id"];
        m.left_member = [NSString stringWithFormat:@"%@",d[@"left_member"]];
        m.captain_avatar = [NSString stringWithFormat:@"%@",d[@"captain_avatar"]];
        [mArr addObject:m];
    }
    
    model.team_list = [NSArray arrayWithArray:mArr];
    
    return model;
}

+(instancetype)initWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

@end
