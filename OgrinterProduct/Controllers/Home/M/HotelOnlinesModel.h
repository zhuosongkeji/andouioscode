//
//  HotelOnlinesModel.h
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/17.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HotelOnlinesModel : NSObject

@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *nid;
@property (nonatomic,strong)NSArray *information;


-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)initWithDict:(NSDictionary *)dict;


@end

NS_ASSUME_NONNULL_END
