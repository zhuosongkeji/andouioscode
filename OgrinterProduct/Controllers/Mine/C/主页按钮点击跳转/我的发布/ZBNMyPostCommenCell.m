//
//  ZBNMyPostCommenCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMyPostCommenCell.h"
#import "UIImage+ZBNExtension.h"

@interface ZBNMyPostCommenCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userIconView;

@property (weak, nonatomic) IBOutlet UIView *removeBtnBack;


@end

@implementation ZBNMyPostCommenCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.userIconView.image = [UIImage circleImageNamed:@"图层 520"];
    self.removeBtnBack.layer.cornerRadius = 10;
    self.removeBtnBack.layer.borderWidth = 1;
    self.removeBtnBack.layer.borderColor = [UIColor colorWithRed:50/255.0 green:193/255.0 blue:164/255.0 alpha:1].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
