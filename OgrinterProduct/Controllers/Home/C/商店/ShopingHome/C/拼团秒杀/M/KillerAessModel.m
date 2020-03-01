//
//  KillerAessModel.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/2/24.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "KillerAessModel.h"
#import "KillerListAessbModel.h"

@implementation KillerAessModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    KillerAessModel *model = [[KillerAessModel alloc]init];
    
    NSArray *top_goodA = dict[@"top_goods"];
    NSArray *goods_listA = dict[@"top_goods"];
    
    
    NSMutableArray *TopArr = [NSMutableArray array];
    NSMutableArray *goodslistArr = [NSMutableArray array];
    
    for (int i = 0;i < [top_goodA count]; i ++) {
        KillerListAessbModel *models = [[KillerListAessbModel alloc]init];
        NSDictionary *dic = top_goodA[i];
        models.sec_id = dic[@"sec_id"];
        models.goods_id = dic[@"goods_id"];
        models.sku_id = dic[@"sku_id"];
        models.name = dic[@"name"];
        models.img = [NSString stringWithFormat:@"%@",dic[@"img"]];
        models.kill_price = dic[@"kill_price"];
        [TopArr addObject:models];
        
    }
    
    for (int i = 0;i < [goods_listA count]; i ++) {
        KillerListAessbModel *models = [[KillerListAessbModel alloc]init];
        NSDictionary *dic = goods_listA[i];
        
        models.lsec_id = dic[@"sec_id"];
        models.lgoods_id = dic[@"goods_id"];
        models.lsku_id = dic[@"sku_id"];
        models.lname = dic[@"name"];
        models.limg = [NSString stringWithFormat:@"%@",dic[@"img"]];
        models.lkill_price = dic[@"kill_price"];
        models.lprice = dic[@"price"];
        
        
        models.lnum = dic[@"num"];
        models.lkill_num = dic[@"kill_num"];
        models.lstart_time = dic[@"start_time"];
        models.lend_time = dic[@"end_time"];
        models.lkill_percent = dic[@"kill_percent"];
        models.lis_finish = dic[@"is_finish"];
        models.lin_sec = dic[@"in_sec"];
        models.lhas_sec = dic[@"has_sec"];
        
        [goodslistArr addObject:models];
        
    }
    
    
    model.top_goods = TopArr;
    model.goods_list = goodslistArr;
    
    return model;
}

+(instancetype)initWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

@end
