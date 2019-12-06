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
    
    return model;
}

+(instancetype)initWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

@end
