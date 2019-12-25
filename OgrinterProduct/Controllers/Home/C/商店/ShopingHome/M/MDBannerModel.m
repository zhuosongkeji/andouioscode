
//
//  MDBannerModel.m
//  MDShockBannerViewOCDemo
//
//  Created by Alan on 2018/4/27.
//  Copyright © 2018年 MD. All rights reserved.
//

#import "MDBannerModel.h"
#import "MdBannerListModel.h"

@implementation MDBannerModel


-(instancetype)initWithDict:(NSDictionary *)dict{
    MDBannerModel *model = [[MDBannerModel alloc]init];
    
    NSMutableArray *bannerArr = [NSMutableArray array];
    NSMutableArray *categoryArr = [NSMutableArray array];
    NSMutableArray *recommendArr = [NSMutableArray array];
    NSMutableArray *bargainArr = [NSMutableArray array];
    
    NSArray *bannerArray = dict[@"banner"];
    NSArray *categoryArray = dict[@"category"];
    NSArray *recommenArray = dict[@"recommend_goods"];
    NSArray *bargainArray = dict[@"bargain_goods"];
    
    for (int i = 0; i < [bannerArray count]; i ++) {
        
        NSDictionary *dic = bannerArray[i];
        MdBannerListModel *list = [[MdBannerListModel alloc]init];
        list.uid = [NSString stringWithFormat:@"%@",dic[@"id"]];
        list.img = [NSString stringWithFormat:@"%@%@",imgServer,dic[@"img"]];
        list.url = [NSString stringWithFormat:@"%@",dic[@"url"]];
        [bannerArr addObject:list];
    }
    
    for (int j = 0; j < [categoryArray count]; j ++) {
        NSDictionary *dic = categoryArray[j];
        MdBannerListModel *list = [[MdBannerListModel alloc]init];
        list.uid = [NSString stringWithFormat:@"%@",dic[@"id"]];
        list.img = [NSString stringWithFormat:@"%@",dic[@"img"]];
        list.name = [NSString stringWithFormat:@"%@",dic[@"name"]];
        [categoryArr addObject:list];
    }
    
    for (int p = 0; p < [recommenArray count]; p ++) {
        NSDictionary *dic = recommenArray[p];
        MdBannerListModel *list = [[MdBannerListModel alloc]init];
        list.uid = [NSString stringWithFormat:@"%@",dic[@"id"]];
        list.img = [NSString stringWithFormat:@"%@",dic[@"img"]];
        list.name = [NSString stringWithFormat:@"%@",dic[@"name"]];
        list.price = [NSString stringWithFormat:@"%@",dic[@"price"]];
        [recommendArr addObject:list];
    }
    
    for (int t = 0; t < [bargainArray count]; t ++) {
        NSDictionary *dic = bargainArray[t];
        MdBannerListModel *list = [[MdBannerListModel alloc]init];
        list.uid = [NSString stringWithFormat:@"%@",dic[@"id"]];
        list.img = [NSString stringWithFormat:@"%@",dic[@"img"]];
        list.name = [NSString stringWithFormat:@"%@",dic[@"name"]];
        [bargainArr addObject:list];
    }
    
    model.dataDic = @{@"banner":bannerArr,@"category":categoryArr,@"recommend_goods":recommendArr,@"bargain_goods":bargainArr};
    
    return model;
}

+(instancetype)initWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}


@end
