//
//  HoleggModel.h
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/11.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HoleggModel : NSObject


@property(nonatomic,strong)NSString *num;
@property(nonatomic,strong)NSString *img;
@property(nonatomic,strong)NSString *has_breakfast;
@property(nonatomic,strong)NSString *gid;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *bed_type;
@property(nonatomic,strong)NSString *areas;

@property(nonatomic,strong)NSString *house_name;
@property(nonatomic,strong)NSString *has_window;
@property(nonatomic,strong)NSString *wifi;
@property(nonatomic,strong)NSString *other_sets;


-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
