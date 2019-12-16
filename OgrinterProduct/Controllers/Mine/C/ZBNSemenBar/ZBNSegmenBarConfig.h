//
//  ZBNSegmenBarConfig.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNSegmenBarConfig : NSObject
+ (instancetype)defaultConfig;

/** 背景颜色 */
@property (nonatomic, strong) UIColor *segmentBarBackColor;

@property (nonatomic, strong) UIColor *itemNormalColor;
@property (nonatomic, strong) UIColor *itemSelectColor;
@property (nonatomic, strong) UIFont *itemFont;

@property (nonatomic, strong) UIColor *indicatorColor;

@property (nonatomic, assign) CGFloat indicatorHeight;
@property (nonatomic, assign) CGFloat indicatorExtraW;

@property (nonatomic ,assign) BOOL indicatorIsHidden;
    // 内部实现, 在这个里面写, 外界, 只负责调用
    // 功能, 改变 itemNormalColor 的值
    //
@property (nonatomic, copy, readonly) ZBNSegmenBarConfig *(^itemBColor)(UIColor *color);//背景颜色
@property (nonatomic, copy, readonly) ZBNSegmenBarConfig *(^itemNColor)(UIColor *color);//nomalColor
@property (nonatomic, copy, readonly) ZBNSegmenBarConfig *(^itemSColor)(UIColor *color);//选中颜色
@property (nonatomic, copy, readonly) ZBNSegmenBarConfig *(^itemF)(UIFont *font);//字体大小

@property (nonatomic, copy, readonly) ZBNSegmenBarConfig *(^indictColor)(UIColor *color);//显示器颜色
@property (nonatomic, copy, readonly) ZBNSegmenBarConfig *(^indictHide)(BOOL isHide);//显示器是否显示
@property (nonatomic, copy, readonly) ZBNSegmenBarConfig *(^indicatorH)(CGFloat H);

@end

NS_ASSUME_NONNULL_END
