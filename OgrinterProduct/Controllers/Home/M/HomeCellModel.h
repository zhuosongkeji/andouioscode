//
//  HomeCellModel.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/28.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeCellModel : NSObject

@property (nonatomic,strong)NSString *imgicon;//配图

@property (nonatomic,strong)NSString *title;//标题


-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)initWithDict:(NSDictionary *)dict;


@end

NS_ASSUME_NONNULL_END
