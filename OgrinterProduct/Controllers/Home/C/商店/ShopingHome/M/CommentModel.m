//
//  CommentModel.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/28.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    CommentModel *model = [[CommentModel alloc]init];
    
    return model;
}

+(instancetype)initWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

@end
