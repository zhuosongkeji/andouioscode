//
//  ZBNProvince.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/1.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBNCity.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZBNProvince : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSNumber *ID;
@property (nonatomic, assign) NSNumber *pid;
@property (nonatomic, strong) NSArray <ZBNCity *> *cities;
@property (nonatomic, strong) ZBNCity *city;

@end

NS_ASSUME_NONNULL_END
