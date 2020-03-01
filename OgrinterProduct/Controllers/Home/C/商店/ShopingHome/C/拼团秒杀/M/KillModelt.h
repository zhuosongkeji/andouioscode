//
//  KillModelt.h
//  OgrinterProduct
//
//  Created by wongshine on 2020/2/28.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface KillModelt : NSObject


@property(nonatomic,strong)NSString *goods_id;
@property(nonatomic,strong)NSString *sku_id;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *storage;
@property(nonatomic,strong)NSString *top_member;
@property(nonatomic,strong)NSString *begin_time;
@property(nonatomic,strong)NSString *finish_time;
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *sale_total;
@property(nonatomic,strong)NSString *total_member;
@property(nonatomic,strong)NSString *now;



@property(nonatomic,strong)NSArray *team_list;


-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)initWithDict:(NSDictionary *)dict;


@end

NS_ASSUME_NONNULL_END
