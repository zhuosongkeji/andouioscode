//
//  ADCellGroupItemModel.h
//  AnDouBusiness
//
//  Created by 周芳圆 on 2019/12/4.
//  Copyright © 2019 ZhouBunian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADCellGroupItemModel : NSObject

/**
 z一组有多少行
 */
@property (nonatomic, strong) NSArray *rowArray;

/**
 头标题
 */
@property (nonatomic, copy) NSString *headerTitle;

/**
 尾部标题
 */
@property (nonatomic, copy) NSString *footerTitle;

/**
 快速创建组模型

 @param array 行数
 @param headerTitle 头标题
 @param footerTitle 尾标题
 @return 组模型
 */
+ (instancetype)ad_settingGroupItemWithRowArray:(NSArray *)array headerTitle:(NSString * __nullable)headerTitle footerTitle:(NSString * __nullable)footerTitle;


@end

NS_ASSUME_NONNULL_END
