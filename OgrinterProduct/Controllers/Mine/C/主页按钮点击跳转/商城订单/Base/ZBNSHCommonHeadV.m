//
//  ZBNSHCommonHeadV.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/3.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSHCommonHeadV.h"


@interface ZBNSHCommonHeadV ()

/*! 订单状态 */
@property (weak, nonatomic) IBOutlet UILabel *title;
/*! 状态sub */
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
/*! 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *iconV;
@end

@implementation ZBNSHCommonHeadV

- (ZBNSHCommonHeadV * _Nonnull (^)(NSString * _Nonnull))setLabelOneText
{
    return ^(NSString *labelOneText) {
        [self.title setText:labelOneText];
        return self;
    };
}

- (ZBNSHCommonHeadV * _Nonnull (^)(NSString * _Nonnull))setSubLabelOneText
{
    return ^(NSString *subLabelText) {
        [self.subTitle setText:subLabelText];
        return self;
    };
}


- (ZBNSHCommonHeadV * _Nonnull (^)(NSString * _Nonnull))setImageVImage
{
    return ^(NSString *imageName) {
        [self.iconV setImage:[UIImage imageNamed:imageName]];
        return self;
    };
}


@end
