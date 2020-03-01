//
//  AssembModel.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/2/24.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "AssembModel.h"
#import "KillerListAessbModel.h"

@implementation AssembModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    AssembModel *model = [[AssembModel alloc]init];
    
    NSArray *top_goodA = dict[@"today_goods"];
    NSArray *goods_listA = dict[@"hot_goods"];
    
    
    NSMutableArray *TopArr = [NSMutableArray array];
    NSMutableArray *goodslistArr = [NSMutableArray array];
    
    for (int i = 0;i < [top_goodA count]; i ++) {
        KillerListAessbModel *models = [[KillerListAessbModel alloc]init];
        NSDictionary *dic = top_goodA[i];
        models.kid
        = dic[@"id"];
        models.goods_id = dic[@"goods_id"];
        models.sku_id = dic[@"sku_id"];
        models.name = dic[@"name"];
        models.img = [NSString stringWithFormat:@"%@",dic[@"img"]];
        models.ktop_member = dic[@"top_member"];
        models.price = dic[@"price"];
        models.total_member = dic[@"total_member"];
        [TopArr addObject:models];
        
    }
    
    for (int i = 0;i < [goods_listA count]; i ++) {
        
        KillerListAessbModel *models = [[KillerListAessbModel alloc]init];
        NSDictionary *dic = goods_listA[i];
        
        models.kid
        = dic[@"id"];
        models.total_member = dic[@"id"];
        models.lgoods_id = dic[@"goods_id"];
        models.total_member = dic[@"total_member"];
        models.lsku_id = dic[@"sku_id"];
        models.lname = dic[@"name"];
        models.limg = [NSString stringWithFormat:@"%@",dic[@"img"]];
        models.lprice = dic[@"price"];
        
        
        
        [goodslistArr addObject:models];
        
    }
    
    
    model.today_goods = TopArr;
    model.hot_goods = goodslistArr;
    
    return model;
}

+(instancetype)initWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

@end
