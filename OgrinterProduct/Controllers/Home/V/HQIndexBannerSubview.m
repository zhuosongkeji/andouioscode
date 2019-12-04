//
//  HQIndexBannerSubview.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/28.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "HQIndexBannerSubview.h"

@implementation HQIndexBannerSubview

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.mainImageView];
        [self addSubview:self.coverView];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleCellTapAction:)];
        [self addGestureRecognizer:singleTap];
    }
    
    return self;
}

- (void)singleCellTapAction:(UIGestureRecognizer *)gesture {
    if (self.didSelectCellBlock) {
        self.didSelectCellBlock(self.tag, self);
    }
}

- (void)setSubviewsWithSuperViewBounds:(CGRect)superViewBounds {
    
//    NSLog(@"cell.coverView.alpha---%f",self.coverView.alpha);
    
    if (CGRectEqualToRect(self.mainImageView.frame, superViewBounds)) {
        return;
    }
    
    self.mainImageView.frame = superViewBounds;
    self.coverView.frame = superViewBounds;
}

- (UIImageView *)mainImageView {
    
    if (!_mainImageView) {
        _mainImageView = [[UIImageView alloc] init];
        _mainImageView.userInteractionEnabled = YES;
    }
    return _mainImageView;
}

- (UIImageView *)iconImage {
    
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _iconImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImage;
}

- (UIView *)coverView {
    
    if (!_coverView) {
        _coverView = [[UIView alloc] init];
        _coverView.backgroundColor = [UIColor blackColor];
    }
    return _coverView;
}


@end
