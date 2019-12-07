//
//  Img+lable.m
//  Conscience
//
//  Created by Mac on 2019/9/24.
//  Copyright © 2019 Conscience. All rights reserved.
//

#import "Img+lable.h"

@implementation Img_lable


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


-(void)awakeFromNib{
    [super awakeFromNib];
    
    //图片在上 文字在下
    CGFloat imageWidth = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
//    self.imageView.backgroundColor = [UIColor blackColor];
//    self.titleLabel.backgroundColor = [UIColor redColor];
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-12.0, 0, 0, -labelWidth);
    labelEdgeInsets = UIEdgeInsetsMake(-10, -imageWidth, -imageHeight-12/2.0, 0);
    
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
