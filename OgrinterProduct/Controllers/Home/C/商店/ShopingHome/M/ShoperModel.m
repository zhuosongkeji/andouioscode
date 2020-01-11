//
//  ShoperModel.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/8.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ShoperModel.h"
#import "ShoperListModel.h"

@implementation ShoperModel


-(instancetype)initWithDict:(NSDictionary *)dict{
    
    ShoperModel *model = [[ShoperModel alloc]init];
    model.logoimg = [NSString stringWithFormat:@"%@%@",imgServer,dict[@"logo_img"]];
    model.status = [NSString stringWithFormat:@"%@",dict[@"status"]];
    model.name = [NSString stringWithFormat:@"name"];
    model.bannerImg = [NSString stringWithFormat:@"%@%@",imgServer,dict[@"banner_img"]];
    
    NSArray *typeArray = dict[@"type"];
    NSMutableArray *tArr = [NSMutableArray array];
    for (int i = 0; i < [typeArray count]; i ++) {
        ShoperListModel *models = [[ShoperListModel alloc]init];
        NSDictionary *tydic = typeArray[i];
        
        models.type_Id = [NSString stringWithFormat:@"%@",tydic[@"id"]];
        models.type_Name = [NSString stringWithFormat:@"%@",tydic[@"name"]];
        
        [tArr addObject:models];
    }
    
    model.typesArr = tArr;
    
    NSArray *goodsArray = dict[@"goods"];
    NSMutableArray *gArr = [NSMutableArray array];
    for (int i = 0; i < [goodsArray count]; i ++) {
        ShoperListModel *models = [[ShoperListModel alloc]init];
        NSDictionary *gdic = goodsArray[i];
        models.goods_Id = [NSString stringWithFormat:@"%@",gdic[@"id"]];
        models.goods_Img = [NSString stringWithFormat:@"%@%@",imgServer,gdic[@"img"]];
        models.goods_Name = [NSString stringWithFormat:@"%@",gdic[@"name"]];
        models.goods_price = [NSString stringWithFormat:@"%@",gdic[@"price"]];
        [gArr addObject:models];
    }
    
    model.goodsArr = gArr;
    
    return model;
}

+(instancetype)initWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

@end
