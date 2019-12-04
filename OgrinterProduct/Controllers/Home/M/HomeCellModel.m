//
//  HomeCellModel.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/28.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "HomeCellModel.h"

@implementation HomeCellModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    HomeCellModel *model = [[HomeCellModel alloc]init];
    
    
    return model;
    
}

+(instancetype)initWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

@end
