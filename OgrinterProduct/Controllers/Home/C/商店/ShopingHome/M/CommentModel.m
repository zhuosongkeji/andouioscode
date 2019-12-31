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
        
    model.avator = [NSString stringWithFormat:@"%@%@",imgServer,dict[@"avator"]];
    model.name = [NSString stringWithFormat:@"%@",dict[@"name"]];
    model.uid = [NSString stringWithFormat:@"%@",dict[@"id"]];
    model.stars = [NSString stringWithFormat:@"%@",dict[@"stars"]];
    
    model.content = [NSString stringWithFormat:@"%@",dict[@"content"]];
    model.created_at = [NSString stringWithFormat:@"%@",dict[@"created_at"]];
    
    return model;
}


+(instancetype)initWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

@end
