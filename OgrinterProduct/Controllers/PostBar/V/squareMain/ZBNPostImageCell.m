//
//  ZBNPostImageCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/20.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNPostImageCell.h"

@interface ZBNPostImageCell ()
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation ZBNPostImageCell

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        UIImageView *imageV = [[UIImageView alloc] init];
        
        _imageView = imageV;
        
        [self.contentView addSubview:imageV];
    }
    
    return _imageView;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageView.image = image;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
}

@end
