//
//  ZBNMyNewsCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/11.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMyNewsCell.h"
#import "UIImage+ZBNExtension.h"

@interface ZBNMyNewsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userIconView;


@end

@implementation ZBNMyNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.userIconView.image = [UIImage circleImageNamed:@"yxj"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

@end
