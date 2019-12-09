//
//  CresTwoTableViewCell.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/9.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "CresTwoTableViewCell.h"

@interface CresTwoTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImg;


@end


@implementation CresTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.iconImg.layer.cornerRadius = 22;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
