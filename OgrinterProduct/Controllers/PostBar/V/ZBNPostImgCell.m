//
//  ZBNPostImgCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/17.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNPostImgCell.h"

@interface ZBNPostImgCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end

@implementation ZBNPostImgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"awkefromenib1111111111");
}

- (void)setImage:(NSString *)image
{
    _image = image;
    self.imageV.image = [UIImage imageNamed:image];
}

@end
