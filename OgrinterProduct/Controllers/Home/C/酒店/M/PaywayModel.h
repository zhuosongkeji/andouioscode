//
//  PaywayModel.h
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/4.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PaywayModel : NSObject

@property(nonatomic,strong)NSString *pid;
@property(nonatomic,strong)NSString *pay_way;
@property(nonatomic,strong)NSString *logo;


-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
