//
//  ZBNSegmenBarConfig.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNSegmenBarConfig.h"

@implementation ZBNSegmenBarConfig

+ (instancetype)defaultConfig {
    
    ZBNSegmenBarConfig *config = [[ZBNSegmenBarConfig alloc] init];
    config.segmentBarBackColor = [UIColor clearColor];
    config.itemFont = [UIFont systemFontOfSize:14];
    config.itemNormalColor = [UIColor lightGrayColor];
    config.itemSelectColor = [UIColor redColor];
    config.indicatorColor = [UIColor redColor];
    config.indicatorHeight = 1;
    config.indicatorExtraW = 10;
    
    return config;
    
}


- (ZBNSegmenBarConfig *(^)(UIColor *))itemBColor
{
    return ^(UIColor *color) {
        self.segmentBarBackColor = color;
        return self;
};
    
}

//平时颜色
- (ZBNSegmenBarConfig *(^)(UIColor *))itemNColor
{
    
    return ^(UIColor *color) {
        self.itemNormalColor = color;
        return self;
    };
    
}

//选中颜色
- (ZBNSegmenBarConfig *(^)(UIColor *))itemSColor
{
    
    return ^(UIColor *color) {
        self.itemSelectColor = color;
        return self;
    };
    
}

//item字体
- (ZBNSegmenBarConfig *(^)(UIFont *))itemF
{
    
    return ^(UIFont *font) {
        self.itemFont = font;
        return self;
    };
    
}

//指示器高度
- (ZBNSegmenBarConfig *(^)(CGFloat))indicatorH
{
    return ^(CGFloat H) {
        self.indicatorHeight = H;
        return self;
    };
}

//指示器颜色
- (ZBNSegmenBarConfig *(^)(UIColor *))indictColor
{
    return ^(UIColor *color) {
        self.indicatorColor = color;
        return self;
    };

}

//指示器是否隐藏
- (ZBNSegmenBarConfig *(^)(BOOL))indictHide
{
    return ^(BOOL isHidden) {
        self.indicatorIsHidden = isHidden;
        return self;
    };
}


@end
