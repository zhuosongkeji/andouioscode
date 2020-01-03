//
//  BeseModel.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/2.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "BeseModel.h"
#import "BeseListListModel.h"

@interface BeseModel ()


@end

@implementation BeseModel


-(instancetype)initWithDict:(NSDictionary *)dict{
    
    BeseModel *model = [[BeseModel alloc]init];
    
    NSArray *arr1 = dict[@"res"];
    
    model.pDict = dict[@"price"];
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < [arr1 count]; i ++) {
        NSDictionary *dict1 = [arr1 objectAtIndex:i];
        BeseListListModel *modellist = [[BeseListListModel alloc]init];
        modellist.name = [NSString stringWithFormat:@"%@",dict1[@"name"]];
        modellist.value = dict1[@"value"];
        
        [array addObject:modellist];
    }
    
    model.resArr = array;
    
    return model;
}

+(instancetype)initWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}


@end
