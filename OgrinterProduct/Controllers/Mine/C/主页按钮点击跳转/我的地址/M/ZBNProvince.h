//
//  ZBNProvince.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/1.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
@class ZBNCity,ZBNArea;
@interface ZBNProvince : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSNumber *ID;
@property (nonatomic, assign) NSNumber *pid;
@property (nonatomic, strong) NSArray < ZBNCity *>*cities;

@property (nonatomic, strong) ZBNArea *area;
@property (nonatomic, strong) ZBNCity *city;

@end

NS_ASSUME_NONNULL_END
