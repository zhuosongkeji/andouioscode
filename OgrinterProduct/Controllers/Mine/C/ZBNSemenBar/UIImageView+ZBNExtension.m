//
//  UIImageView+ZBNExtension.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/18.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "UIImageView+ZBNExtension.h"


@implementation UIImageView (ZBNExtension)

- (void)setHeader:(NSString *)url
{
    [self setCircleHeader:url];
}

- (void)setRectHeader:(NSString *)url
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"yxj"]];
}

- (void)setCircleHeader:(NSString *)url
{
    ADWeakSelf;
    UIImage *placehoderImg = [[UIImage imageNamed:@"yxj"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placehoderImg completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        // 如果图片下载失败，就不做任何处理，按照默认的做法：会显示占位图片
        if (image == nil) return;
        weakSelf.image = [image circleImage];
    }];
}
@end
