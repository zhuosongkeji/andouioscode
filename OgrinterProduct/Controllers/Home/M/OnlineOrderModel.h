//
//  OnlineOrderModel.h
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/16.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OnlineOrderModel : NSObject

@property (nonatomic,strong)NSString *name;//配图
@property (nonatomic,strong)NSString *praise_num;//标题

@property (nonatomic,strong)NSString *stars_all;//配图
@property (nonatomic,strong)NSString *door_img;//标题

@property (nonatomic,strong)NSString *oid;//配图


@property (nonatomic,strong)NSString *logo_img;//配图
@property (nonatomic,strong)NSString *address;//配图
@property (nonatomic,strong)NSString *desc;//配图
@property (nonatomic,strong)NSString *business_start;//配图
@property (nonatomic,strong)NSString *business_end;//配图
@property (nonatomic,strong)NSString *tel;
@property (nonatomic,strong)NSString *status;//是否关注



@property (nonatomic,strong)NSArray *cai;//标题






-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
