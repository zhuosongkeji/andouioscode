//
//  HolelModel.h
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/10.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HolelModel : NSObject

@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSArray *facilities;
@property(nonatomic,strong)NSString *door_img;
@property(nonatomic,strong)NSString *jdid;

@property(nonatomic,strong)NSString *praise_num;
@property(nonatomic,strong)NSString *tel;
@property(nonatomic,strong)NSString *stars_all;

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *desc;


-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
