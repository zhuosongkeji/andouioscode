//
//  AsseBlModel.h
//  OgrinterProduct
//
//  Created by wongshine on 2020/2/24.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AsseBlModel : NSObject

@property(nonatomic,strong)NSString *sid;
@property(nonatomic,strong)NSString *goods_id;
@property(nonatomic,strong)NSString *sdu_id;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *storage;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *img;
@property(nonatomic,strong)NSString *old_price;
@property(nonatomic,strong)NSString *total_member;
@property(nonatomic,strong)NSString *buy_total;
@property(nonatomic,strong)NSString *sale_percent;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
