//
//  ZBNCity.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/1.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface ZBNCity : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSNumber *ID;
@property (nonatomic, assign) NSNumber *pid;
@property (nonatomic, strong) NSArray  *areas;
@end

NS_ASSUME_NONNULL_END
