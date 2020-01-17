//
//  HotelOnlinesModel.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/17.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "HotelOnlinesModel.h"
#import "HotelOnlinesListModel.h"

@implementation HotelOnlinesModel


-(instancetype)initWithDict:(NSDictionary *)dict{
    HotelOnlinesModel *model = [[HotelOnlinesModel alloc]init];
    model.name = [NSString stringWithFormat:@"%@",dict[@"name"]];
    model.nid = [NSString stringWithFormat:@"%@",dict[@"id"]];
    
    NSArray *array = dict[@"information"];
    
    NSMutableArray *mArr = [NSMutableArray array];
    
    for (int i = 0; i < [array count]; i ++) {
        NSDictionary *d  = array[i];
        HotelOnlinesListModel *mode = [[HotelOnlinesListModel alloc]init];
        
        mode.price = [NSString stringWithFormat:@"%@",d[@"price"]];
        mode.hid = [NSString stringWithFormat:@"%@",d[@"id"]];
        mode.image = [NSString stringWithFormat:@"%@%@",imgServer,d[@"image"]];
        
        mode.hname = [NSString stringWithFormat:@"%@",d[@"name"]];
        mode.remark = [NSString stringWithFormat:@"%@",d[@"remark"]];
        
        [mArr addObject:mode];
    }
    
    model.information = [NSArray arrayWithArray:mArr];

    
    
    return model;
}

+(instancetype)initWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}


@end
