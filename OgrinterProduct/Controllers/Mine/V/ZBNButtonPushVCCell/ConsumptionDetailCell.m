//
//  ConsumptionDetailCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/6.
//  Copyright © 2019 RXF. All rights reserved.
//  消费明细的cell

#import "ConsumptionDetailCell.h"


@interface ConsumptionDetailCell ()

/*! 消费标题 */
@property (weak, nonatomic) IBOutlet UILabel *buyCostLabel;
/*! 时间 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/*! 消费明细数额 */
@property (weak, nonatomic) IBOutlet UILabel *reduceLabel;

@end

@implementation ConsumptionDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
