//
//  HotelOrderModel.h
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/14.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>


@class HotelOrderModelList;

NS_ASSUME_NONNULL_BEGIN

@interface HotelOrderModel : NSObject

@property(nonatomic,strong)NSString *allprice;
@property(nonatomic,strong)NSString *days;
@property(nonatomic,strong)NSString *end;
@property(nonatomic,strong)NSString *start;
@property(nonatomic,strong)NSString *integral;

@property(nonatomic,strong)HotelOrderModelList *listmodel;



-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END


