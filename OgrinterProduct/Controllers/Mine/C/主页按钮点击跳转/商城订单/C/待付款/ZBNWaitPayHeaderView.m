//
//  ZBNWaitPayHeaderView.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/20.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNWaitPayHeaderView.h"

@interface ZBNWaitPayHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *LabelOne;
@property (weak, nonatomic) IBOutlet UILabel *subLableOne;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;


@end


@implementation ZBNWaitPayHeaderView


- (ZBNWaitPayHeaderView * _Nonnull (^)(NSString * _Nonnull))setLabelOneText
{
    return ^(NSString *labelOneText) {
        [self.LabelOne setText:labelOneText];
        return self;
    };
}

- (ZBNWaitPayHeaderView * _Nonnull (^)(NSString * _Nonnull))setSubLabelOneText
{
    return ^(NSString *subLabelText) {
        [self.subLableOne setText:subLabelText];
        return self;
    };
}


- (ZBNWaitPayHeaderView * _Nonnull (^)(NSString * _Nonnull))setImageVImage
{
    return ^(NSString *imageName) {
        [self.imageV setImage:[UIImage imageNamed:imageName]];
        return self;
    };
}

@end
