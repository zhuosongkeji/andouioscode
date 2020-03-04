//
//  ZBNPostImageCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/20.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNPostImageCell.h"
#import "ZBNPostPhotoItem.h"

@interface ZBNPostImageCell ()

@end

@implementation ZBNPostImageCell

- (void)setPhotoItem:(ZBNPostPhotoItem *)photoItem
{
    _photoItem = photoItem;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:photoItem.imageName] placeholderImage:[UIImage imageNamed:@"80"]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
     [self setupView];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}


- (void)setupView
{
    UIImageView *imageView = [UIImageView new];
    [self.contentView addSubview:imageView];
    self.imageView = imageView;
    
}
@end
