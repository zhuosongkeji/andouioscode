//
//  ZBNProvince.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/1.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface ZBNProvince : NSObject
/*! 简称 */
@property (nonatomic, copy) NSString *name;
/*! 全称 */
@property (nonatomic, copy) NSString *fullname;
/*! 省ID */
@property (nonatomic, assign) NSString *ID;
/*! 城市数组 */
@property (nonatomic, strong) NSArray *children;

@end

NS_ASSUME_NONNULL_END
